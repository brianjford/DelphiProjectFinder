unit Finder;

interface

uses
  Winapi.ShellAPI, Winapi.Windows,
  System.SysUtils, System.Classes,
  Vcl.Menus, Vcl.Dialogs, Vcl.ActnList, Vcl.ComCtrls,
  ToolsAPI, FinderForm;

implementation

type
  TMethodContainer = class(TObject)
    procedure Click(Sender: TObject);
  end;

var
  NTAServices: INTAServices;
  FinderMenuItem: TMenuItem;
  aMethodContainer: TMethodContainer;

procedure TMethodContainer.Click(Sender: TObject);
begin
  frmFinder := TfrmFinder.Create(nil);
  frmFinder.ShowModal;
  FreeAndNil(frmFinder);
end;

procedure Initialize(Sender: TObject);
begin
  if Supports(BorlandIDEServices, INTAServices, NTAServices) then
  begin
    aMethodContainer := TMethodContainer.Create;

    FinderMenuItem := TMenuItem.Create(nil);
    FinderMenuItem.Name := 'ProjectFinderMenuItem';
    FinderMenuItem.Caption := 'Project Finder';
    FinderMenuItem.ImageIndex := 12;
    FinderMenuItem.OnClick := aMethodContainer.Click;
    FinderMenuItem.ShortCut := Ord('G') or scCtrl or scAlt;  // Ctrl+Alt+G for hotkey

    NTAServices.AddActionMenu('ToolsMenu', nil, FinderMenuItem, False, True);
  end;
end;

procedure Finalize(Sender: TObject);
begin
  FinderMenuItem.Free;
  aMethodContainer.Free;
end;

initialization
  Initialize(nil);

finalization
  Finalize(nil);

end.

