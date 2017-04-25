unit uDMFBExpert;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmFBExpert = class(TDataModule)
    FDCSQLite: TFDConnection;
    FDConexao: TFDConnection;
    FDQDatabases: TFDQuery;
    DataSource1: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDatabases: TDataSet;
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
  FDCSQLite.Open();
end;

function TdmFBExpert.GetDatabases: TDataSet;
begin
  FDQDatabases.Close();
  FDQDatabases.SQL.Text := ' SELECT * FROM DATABASES ';
  FDQDatabases.Open();
  FDQDatabases.FetchAll();

  Result := FDQDatabases;
end;

end.