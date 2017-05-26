unit uDMFBExpert;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.IBDef, FireDAC.Phys.IBBase, FireDAC.Phys.IB,
  Datasnap.DBClient, Datasnap.Provider;

type
  TdmFBExpert = class(TDataModule)
    FDCSQLite: TFDConnection;
    FDConexao: TFDConnection;
    FDQDatabases: TFDQuery;
    DSDatabases: TDataSource;
    DSPDatabases: TDataSetProvider;
    CDSDatabases: TClientDataSet;
    FDMetaInfoQuery: TFDMetaInfoQuery;
    FDQGeneric: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function  GetDatabases(): TDataSet;
    function  GetDatabase(ID: Integer): TDataSet;
    function  GetTableStructure(Connection: TFDConnection; TableName: String): TDataSet;
    procedure DeleteDatabase(ID: Integer);
    function  ReadFieldAttributes(Connection: TFDConnection; TableName, FieldName: String): TDataSet;
  end;

var
  dmFBExpert: TdmFBExpert;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmFBExpert.DataModuleCreate(Sender: TObject);
begin
  FDCSQLite.Close();
  FDCSQLite.Params.Values['Database'] :=  ExtractFilePath(Application.ExeName) + 'FBExpert.db';
end;

procedure TdmFBExpert.DeleteDatabase(ID: Integer);
begin
  GetDatabase(ID);
  FDQDatabases.Delete;
end;

function TdmFBExpert.GetDatabase(ID: Integer): TDataSet;
begin
  FDQDatabases.Close();
  FDQDatabases.SQL.Text := ' SELECT * FROM DATABASES ' +
                           '  WHERE ID = ' + ID.ToString;
  FDQDatabases.Open();
  FDQDatabases.FetchAll();

  Result := FDQDatabases;
end;

function TdmFBExpert.GetDatabases(): TDataSet;
begin
  FDQDatabases.Close();
  FDQDatabases.SQL.Text := ' SELECT * FROM DATABASES ';
  FDQDatabases.Open();
  FDQDatabases.FetchAll();

  Result := FDQDatabases;
end;

function TdmFBExpert.GetTableStructure(Connection: TFDConnection;
  TableName: String): TDataSet;
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
  Result := FDMetaInfoQuery;
end;

function TdmFBExpert.ReadFieldAttributes(Connection: TFDConnection; TableName,
  FieldName: String): TDataSet;
begin
  FDQGeneric.Connection := Connection;

  FDQGeneric.Close();
  FDQGeneric.SQL.Text := ' SELECT RDB$RELATION_FIELDS.RDB$FIELD_SOURCE AS DOMINIO, ' +
                         '        RDB$FIELDS.RDB$NULL_FLAG AS NAO_NULO, ' +
                         '        (SELECT COUNT(RDB$INDEX_NAME) FROM RDB$INDICES ' +
                         '           LEFT JOIN RDB$INDEX_SEGMENTS ON RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME  ' +
                         '           LEFT JOIN RDB$RELATION_CONSTRAINTS ON RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
                         '          WHERE RDB$INDICES.RDB$RELATION_NAME = RDB$RELATION_FIELDS.RDB$RELATION_NAME ' +
                         '            AND RDB$INDEX_SEGMENTS.RDB$FIELD_NAME = RDB$RELATION_FIELDS.RDB$FIELD_NAME ' +
                         '            AND RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE = ' + ('PRIMARY KEY').QuotedString + ') AS PK ' +
                         '   FROM RDB$RELATION_FIELDS ' +
                         '  INNER JOIN RDB$FIELDS ON (RDB$FIELDS.RDB$FIELD_NAME = RDB$RELATION_FIELDS.RDB$FIELD_SOURCE) ' +
                         '  WHERE RDB$RELATION_FIELDS.RDB$RELATION_NAME = ' + TableName.QuotedString() +
                         '    AND RDB$RELATION_FIELDS.RDB$FIELD_NAME = ' + FieldName.QuotedString();
  FDQGeneric.Open();
  FDQGeneric.FetchAll();

  Result := FDQGeneric;
end;

end.
