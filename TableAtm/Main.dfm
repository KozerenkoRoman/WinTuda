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
  PixelsPerInch = 96
  TextHeight = 16
  object pnlInfo: TGridPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 281
    Align = alTop
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    Color = clBtnHighlight
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = lblATMVersion
        Row = 6
      end
      item
        Column = 1
        Control = lblATMVersionCaption
        Row = 3
      end
      item
        Column = 0
        Control = lblSQLVersion
        Row = 3
      end
      item
        Column = 1
        Control = lblSQLVersionCaption
        Row = 4
      end
      item
        Column = 0
        Control = lblCompatibility
        Row = 0
      end
      item
        Column = 1
        Control = lblCompatibilityCaption
        Row = 5
      end
      item
        Column = 0
        Control = cbDBShares
        Row = 6
      end
      item
        Column = 0
        Control = cbConvertATMDocs
        Row = 7
      end
      item
        Column = 0
        ColumnSpan = 2
        Control = cbAliasList
        Row = 1
      end
      item
        Column = 1
        Control = cbLang
        Row = 0
      end
      item
        Column = 0
        Control = btnCancel
        Row = 8
      end
      item
        Column = 1
        Control = btnGo
        Row = 8
      end
      item
        Column = 0
        ColumnSpan = 2
        Control = lblAtmCfg
        Row = 2
      end>
    ParentBiDiMode = False
    ParentBackground = False
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 40.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    DesignSize = (
      302
      281)
    object lblATMVersion: TLabel
      AlignWithMargins = True
      Left = 154
      Top = 183
      Width = 145
      Height = 24
      Align = alClient
      Alignment = taRightJustify
      AutoSize = False
      Layout = tlCenter
      ExplicitLeft = 109
      ExplicitTop = 9
      ExplicitWidth = 66
      ExplicitHeight = 13
    end
    object lblATMVersionCaption: TLabel
      AlignWithMargins = True
      Left = 154
      Top = 93
      Width = 145
      Height = 24
      Align = alClient
      AutoSize = False
      Caption = ':ATM Version'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 180
      ExplicitTop = -12
      ExplicitWidth = 137
      ExplicitHeight = 23
    end
    object lblSQLVersion: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 93
      Width = 145
      Height = 24
      Align = alClient
      Alignment = taRightJustify
      AutoSize = False
      Layout = tlCenter
      ExplicitLeft = 109
      ExplicitTop = 38
      ExplicitWidth = 64
      ExplicitHeight = 13
    end
    object lblSQLVersionCaption: TLabel
      AlignWithMargins = True
      Left = 154
      Top = 123
      Width = 145
      Height = 24
      Align = alClient
      AutoSize = False
      Caption = ':SQL Version'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 344
      ExplicitTop = 38
      ExplicitWidth = 61
      ExplicitHeight = 13
    end
    object lblCompatibility: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 145
      Height = 24
      Align = alClient
      Alignment = taRightJustify
      AutoSize = False
      Layout = tlCenter
      ExplicitLeft = 0
      ExplicitTop = 30
      ExplicitWidth = 135
    end
    object lblCompatibilityCaption: TLabel
      AlignWithMargins = True
      Left = 154
      Top = 153
      Width = 145
      Height = 24
      Align = alClient
      AutoSize = False
      Caption = ':Compatibility'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 342
      ExplicitTop = 67
      ExplicitWidth = 65
      ExplicitHeight = 13
    end
    object cbDBShares: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 183
      Width = 145
      Height = 24
      Align = alClient
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
      Align = alClient
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
      Align = alTop
      TabOrder = 2
    end
    object cbLang: TComboBox
      AlignWithMargins = True
      Left = 221
      Top = 3
      Width = 78
      Height = 24
      Align = alRight
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
    object lblAtmCfg: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 63
      Width = 296
      Height = 16
      Align = alTop
      Caption = 'lblAtmCfg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = lblAtmCfgClick
      ExplicitWidth = 55
    end
  end
end
