unit FinderForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ToolsApi;

type
  TfrmFinder = class(TForm)
    btnClose: TButton;
    btnSearch: TButton;
    editSearch: TEdit;
    ListBox1: TListBox;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure editSearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    procedure PopulateList;
    procedure SelectProject;
  end;

var
  frmFinder: TfrmFinder;

implementation

{$R *.dfm}

procedure TfrmFinder.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFinder.btnSearchClick(Sender: TObject);
begin
  SelectProject;
end;

procedure TfrmFinder.editSearchChange(Sender: TObject);
begin
  PopulateList;
end;

procedure TfrmFinder.FormCreate(Sender: TObject);
begin
  PopulateList;
end;

procedure TfrmFinder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFinder.FormShow(Sender: TObject);
begin
  editSearch.SetFocus;
end;

procedure TfrmFinder.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Handle Cursor / Up down keys to move list even when focus is on the Edit Box
  if (Key = VK_DOWN) then
  begin
    if (ListBox1.ItemIndex < ListBox1.Count) then
      ListBox1.ItemIndex := ListBox1.ItemIndex + 1;
    Key := 0;  // eat the key so the edit box doesnt handle it too
  end
  else if (Key = VK_UP) then
  begin
    if (ListBox1.ItemIndex > 0) then
      ListBox1.ItemIndex := ListBox1.ItemIndex - 1;
    Key := 0;
  end;
end;

procedure TfrmFinder.ListBox1DblClick(Sender: TObject);
begin
  SelectProject;
end;

procedure TfrmFinder.PopulateList;
var
  ProjectGroup: IOTAProjectGroup;
  i: Integer;
  FileName: string;
begin
  if Assigned(BorlandIDEServices) then
  begin
    ListBox1.Items.BeginUpdate;
    try
      ListBox1.Clear;

      ProjectGroup := (BorlandIDEServices as IOTAModuleServices).MainProjectGroup;
      if ProjectGroup <> nil then
      begin
        for i := 0 to ProjectGroup.ProjectCount - 1 do
        begin
          FileName := ExtractFileName(ProjectGroup.Projects[i].FileName);

          // Search for edit text in filenames
          if (editSearch.Text = '') or (Pos(UpperCase(editSearch.Text), UpperCase(FileName)) > 0) then
            ListBox1.AddItem(FileName, Pointer(i));

        end;

        if ListBox1.Count > 0 then
          ListBox1.ItemIndex := 0;
      end;
    finally
      ListBox1.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmFinder.SelectProject;
var
  ProjectGroup: IOTAProjectGroup;
  ProjectIndex : Integer;
begin
  ProjectGroup := (BorlandIDEServices as IOTAModuleServices).MainProjectGroup;

  if (ProjectGroup <> nil) and (ListBox1.ItemIndex > -1) then
  begin
    ProjectIndex := Integer(ListBox1.Items.Objects[ListBox1.ItemIndex]);
    if ProjectIndex < ProjectGroup.ProjectCount then
      ProjectGroup.ActiveProject := ProjectGroup.Projects[ProjectIndex];
  end;

  Close;
end;

end.

