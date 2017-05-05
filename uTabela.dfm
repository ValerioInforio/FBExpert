object frmTabela: TfrmTabela
  Left = 0
  Top = 0
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
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object PCLPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 623
    Height = 360
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 607
    ExplicitHeight = 322
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ExplicitWidth = 599
      ExplicitHeight = 294
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 615
        Height = 332
        Align = alClient
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
end
