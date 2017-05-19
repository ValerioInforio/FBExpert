object frmTabela: TfrmTabela
  Left = 0
  Top = 55
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmTabela'
  ClientHeight = 360
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  PrintScale = poNone
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object PCLPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 623
    Height = 360
    ActivePage = TSFields
    Align = alClient
    TabOrder = 0
    object TSFields: TTabSheet
      Caption = 'Fields'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 615
        Height = 332
        Align = alClient
        Ctl3D = True
        DataSource = DSTableStructure
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'RECNO'
            Title.Caption = '#'
            Width = 22
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_NAME'
            Title.Caption = 'Field Name'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_TYPENAME'
            Title.Caption = 'Field Type'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_PRECISION'
            Title.Alignment = taRightJustify
            Title.Caption = 'Size'
            Width = 32
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_SCALE'
            Title.Alignment = taRightJustify
            Title.Caption = 'Scale'
            Width = 32
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_LENGTH'
            Title.Alignment = taRightJustify
            Title.Caption = 'Length'
            Width = 40
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'NOT_NULL'
            Title.Alignment = taCenter
            Title.Caption = 'Not Null'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TABLE_NAME'
            Width = 500
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_POSITION'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_ATTRIBUTES'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_DATATYPE'
            Visible = True
          end>
      end
    end
  end
  object DSTableStructure: TDataSource
    DataSet = FDMetaInfoQuery
    Left = 424
    Top = 200
  end
  object FDMetaInfoQuery: TFDMetaInfoQuery
    OnCalcFields = FDMetaInfoQueryCalcFields
    Connection = dmFBExpert.FDCSQLite
    MetaInfoKind = mkTableFields
    ObjectName = 'ACATBITE'
    Left = 200
    Top = 200
    object FDMetaInfoQueryRECNO: TIntegerField
      FieldName = 'RECNO'
      ReadOnly = True
    end
    object FDMetaInfoQueryCATALOG_NAME: TWideStringField
      FieldName = 'CATALOG_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQuerySCHEMA_NAME: TWideStringField
      FieldName = 'SCHEMA_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQueryTABLE_NAME: TWideStringField
      FieldName = 'TABLE_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQueryCOLUMN_NAME: TWideStringField
      FieldName = 'COLUMN_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQueryCOLUMN_POSITION: TIntegerField
      FieldName = 'COLUMN_POSITION'
      ReadOnly = True
    end
    object FDMetaInfoQueryCOLUMN_DATATYPE: TIntegerField
      FieldName = 'COLUMN_DATATYPE'
      ReadOnly = True
    end
    object FDMetaInfoQueryCOLUMN_TYPENAME: TWideStringField
      FieldName = 'COLUMN_TYPENAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQueryCOLUMN_ATTRIBUTES: TLongWordField
      FieldName = 'COLUMN_ATTRIBUTES'
      ReadOnly = True
    end
    object FDMetaInfoQueryCOLUMN_PRECISION: TIntegerField
      FieldName = 'COLUMN_PRECISION'
      ReadOnly = True
    end
    object FDMetaInfoQueryCOLUMN_SCALE: TIntegerField
      FieldName = 'COLUMN_SCALE'
      ReadOnly = True
    end
    object FDMetaInfoQueryCOLUMN_LENGTH: TIntegerField
      FieldName = 'COLUMN_LENGTH'
      ReadOnly = True
    end
    object FDMetaInfoQueryNOT_NULL: TStringField
      FieldKind = fkCalculated
      FieldName = 'NOT_NULL'
      Size = 1
      Calculated = True
    end
  end
end
