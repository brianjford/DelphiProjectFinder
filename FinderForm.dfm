object frmFinder: TfrmFinder
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Search Project...'
  ClientHeight = 208
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object editSearch: TEdit
    Left = 8
    Top = 8
    Width = 233
    Height = 21
    TabOrder = 0
    OnChange = editSearchChange
  end
  object btnSearch: TButton
    Left = 247
    Top = 8
    Width = 75
    Height = 22
    Caption = 'Search'
    Default = True
    TabOrder = 1
    OnClick = btnSearchClick
  end
  object btnClose: TButton
    Left = 247
    Top = 39
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 39
    Width = 233
    Height = 158
    ItemHeight = 13
    TabOrder = 3
    OnDblClick = ListBox1DblClick
  end
end
