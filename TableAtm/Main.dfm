object frmMain: TfrmMain
  Left = 0
  Top = 0
  BiDiMode = bdLeftToRight
  BorderStyle = bsDialog
  Caption = 'TableAtm'
  ClientHeight = 334
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    302
    334)
  PixelsPerInch = 96
  TextHeight = 16
  object lblATMVersion: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 123
    Width = 145
    Height = 24
    AutoSize = False
    Layout = tlCenter
  end
  object lblATMVersionCaption: TLabel
    AlignWithMargins = True
    Left = 154
    Top = 93
    Width = 145
    Height = 24
    AutoSize = False
    Caption = ':ATM Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object lblSQLVersion: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 93
    Width = 145
    Height = 24
    Alignment = taRightJustify
    AutoSize = False
    Layout = tlCenter
  end
  object lblSQLVersionCaption: TLabel
    AlignWithMargins = True
    Left = 154
    Top = 123
    Width = 145
    Height = 24
    AutoSize = False
    Caption = ':SQL Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object lblCompatibility: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 153
    Width = 145
    Height = 24
    Alignment = taRightJustify
    AutoSize = False
    Layout = tlCenter
  end
  object lblCompatibilityCaption: TLabel
    AlignWithMargins = True
    Left = 154
    Top = 153
    Width = 145
    Height = 24
    AutoSize = False
    Caption = ':Compatibility'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object lblAtmCfg: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 63
    Width = 55
    Height = 16
    Caption = 'lblAtmCfg'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lblAtmCfgClick
  end
  object cbDBShares: TCheckBox
    AlignWithMargins = True
    Left = 3
    Top = 183
    Width = 145
    Height = 24
    Caption = 'cbDBShares'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object cbConvertATMDocs: TCheckBox
    AlignWithMargins = True
    Left = 3
    Top = 213
    Width = 145
    Height = 24
    Caption = 'cbConvertATMDocs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object cbAliasList: TComboBox
    AlignWithMargins = True
    Left = 3
    Top = 33
    Width = 296
    Height = 24
    TabOrder = 2
  end
  object cbLang: TComboBox
    AlignWithMargins = True
    Left = 221
    Top = 3
    Width = 78
    Height = 24
    TabOrder = 3
    OnChange = cbLangChange
    Items.Strings = (
      'Hebrew'
      'English')
  end
  object btnCancel: TButton
    Left = 15
    Top = 247
    Width = 120
    Height = 25
    Anchors = []
    Caption = 'Cancel'
    TabOrder = 4
  end
  object btnGo: TButton
    Left = 166
    Top = 247
    Width = 120
    Height = 25
    Anchors = []
    Caption = 'Go'
    TabOrder = 5
  end
end
