unit uTabela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids, FireDAC.Comp.Client,
  Vcl.DBGrids;

type
  TfrmTabela = class(TForm)
    PCLPrincipal: TPageControl;
    TSFields: TTabSheet;
    DBGrid1: TDBGrid;
    DSTableStructure: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; Connection: TFDConnection; TableName : String);
  end;

var
  frmTabela: TfrmTabela;

implementation

{$R *.dfm}

uses uDMFBExpert;

{ TfrmTabela }

constructor TfrmTabela.Create(AOwner: TComponent; Connection: TFDConnection; TableName: String);
begin
  inherited Create(AOwner);
  Caption := TableName;
  DSTableStructure.DataSet := dmFBExpert.GetTableStructure(Connection, TableName);
end;

end.
