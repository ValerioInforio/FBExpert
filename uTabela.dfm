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
        DataSource = DSTableStructure
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object DSTableStructure: TDataSource
    DataSet = CDSTableStructure
    Left = 424
    Top = 200
  end
  object CDSTableStructure: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 304
    Top = 200
  end
end
