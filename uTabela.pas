unit uTabela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids, FireDAC.Comp.Client,
  Vcl.DBGrids, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmTabela = class(TForm)
    PCLPrincipal: TPageControl;
    TSFields: TTabSheet;
    DBGrid1: TDBGrid;
    DSTableStructure: TDataSource;
    FDMetaInfoQuery: TFDMetaInfoQuery;
    FDMetaInfoQueryRECNO: TIntegerField;
    FDMetaInfoQueryCATALOG_NAME: TWideStringField;
    FDMetaInfoQuerySCHEMA_NAME: TWideStringField;
    FDMetaInfoQueryTABLE_NAME: TWideStringField;
    FDMetaInfoQueryCOLUMN_NAME: TWideStringField;
    FDMetaInfoQueryCOLUMN_POSITION: TIntegerField;
    FDMetaInfoQueryCOLUMN_DATATYPE: TIntegerField;
    FDMetaInfoQueryCOLUMN_TYPENAME: TWideStringField;
    FDMetaInfoQueryCOLUMN_ATTRIBUTES: TLongWordField;
    FDMetaInfoQueryCOLUMN_PRECISION: TIntegerField;
    FDMetaInfoQueryCOLUMN_SCALE: TIntegerField;
    FDMetaInfoQueryCOLUMN_LENGTH: TIntegerField;
    FDMetaInfoQueryNOT_NULL: TStringField;
    procedure FDMetaInfoQueryCalcFields(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    function GetTableStructure(Connection: TFDConnection; TableName: String): TDataSet;
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
  GetTableStructure(Connection, TableName);
//  DSTableStructure.DataSet := dmFBExpert.GetTableStructure(Connection, TableName);
end;

procedure TfrmTabela.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check: Integer;
  R: TRect;
begin
  if Column.FieldName = 'NOT_NULL' then
     begin
       DBGrid1.Canvas.FillRect(Rect);
       Check := 0;
       if FDMetaInfoQuery.FieldByName('NOT_NULL').AsString.Equals('S') then
          Check := DFCS_CHECKED;
       R:=Rect;
       InflateRect(R,-2,-2); //Diminue o tamanho do CheckBox
       DrawFrameControl(DBGrid1.Canvas.Handle,R,DFC_BUTTON, DFCS_BUTTONCHECK or Check);
     end;
end;

procedure TfrmTabela.FDMetaInfoQueryCalcFields(DataSet: TDataSet);
var
  i : Integer;
  eAttrs: TFDDataAttributes;
  X: String;
begin
  i := FDMetaInfoQuery.FieldByName('COLUMN_ATTRIBUTES').AsInteger;
  eAttrs := TFDDataAttributes(Pointer(@i)^);

  if not(caAllowNull in eAttrs) then
     X := 'S'
  else
     X := 'N';
  FDMetaInfoQueryNOT_NULL.Value := X;
end;

function TfrmTabela.GetTableStructure(Connection: TFDConnection; TableName: String): TDataSet;
begin
  FDMetaInfoQuery.Connection := Connection;
  FDMetaInfoQuery.MetaInfoKind := mkTableFields;
  FDMetaInfoQuery.ObjectName := TableName;
  FDMetaInfoQuery.Open();
  FDMetaInfoQuery.FetchAll();
  FDMetaInfoQuery.Offline();

  {Set the Connection,
           MetaInfoKind and
           optionally the CatalogName,
                          SchemaName,
                          BaseObjectName,
                          and ObjectName properties and open the dataset.}

  {------------------------------------}
  {------------------------------------}
end;

end.
