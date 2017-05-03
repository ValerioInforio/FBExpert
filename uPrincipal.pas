unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.ExtCtrls, Vcl.ComCtrls, System.Generics.Collections,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    PNLDatabases: TPanel;
    Panel1: TPanel;
    TVDatabases: TTreeView;
    ImageList: TImageList;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    MainMenu1: TMainMenu;
    Database1: TMenuItem;
    View1: TMenuItem;
    DBExplorer1: TMenuItem;
    RegisterDatabase1: TMenuItem;
    PopupMenu1: TPopupMenu;
    DatabaseRegistrationInfo1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TVDatabasesDblClick(Sender: TObject);
    procedure DBExplorer1Click(Sender: TObject);
    procedure RegisterDatabase1Click(Sender: TObject);
    procedure DatabaseRegistrationInfo1Click(Sender: TObject);
  private
    { Private declarations }
    ListFDConnection: TObjectList<TFDConnection>;
  public
    { Public declarations }
    procedure CarregarDatabases;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uDMFBExpert, uRegistrarDatabase;

procedure TfrmPrincipal.CarregarDatabases;
var
  DSDatabases: TDataSet;
  DatabaseNode: TTreeNode;
  FDConnection: TFDConnection;
begin
  DSDatabases := dmFBExpert.GetDatabases;
  TVDatabases.Items.Clear;

  ListFDConnection := TObjectList<TFDConnection>.Create();
  if not(DSDatabases.IsEmpty) then
    begin
      DSDatabases.First();

      while not(DSDatabases.Eof) do
        begin
          DatabaseNode := TVDatabases.Items.AddChild(nil, DSDatabases.FieldByName('ALIAS').AsString);

          FDConnection := TFDConnection.Create(Self);
          FDConnection.DriverName := DSDatabases.FieldByName('DRIVER_ID').AsString;
          FDConnection.Params.Values['Database']  := DSDatabases.FieldByName('DATABASE').AsString;
          FDConnection.Params.Values['User_Name'] := DSDatabases.FieldByName('USER_NAME').AsString;
          FDConnection.Params.Values['Password']  := DSDatabases.FieldByName('PASSWORD').AsString;
          FDConnection.Params.Values['Protocol']  := DSDatabases.FieldByName('PROTOCOL').AsString;
          FDConnection.Params.Values['Server']    := DSDatabases.FieldByName('SERVER').AsString;
          FDConnection.Params.Values['Port']      := DSDatabases.FieldByName('PORT').AsString;
          FDConnection.Close();
          ListFDConnection.Add(FDConnection);

          DSDatabases.Next();
        end;


    end;


end;

procedure TfrmPrincipal.DatabaseRegistrationInfo1Click(Sender: TObject);
begin
  frmRegistrarDatabase := TfrmRegistrarDatabase.Create(Application, TVDatabases.Selected.Text);
  frmRegistrarDatabase.ShowModal;
end;

procedure TfrmPrincipal.DBExplorer1Click(Sender: TObject);
begin
  PNLDatabases.Visible := not PNLDatabases.Visible;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  CarregarDatabases;
end;

procedure TfrmPrincipal.RegisterDatabase1Click(Sender: TObject);
begin
  frmRegistrarDatabase := TfrmRegistrarDatabase.Create(Application, '');
  frmRegistrarDatabase.ShowModal;
end;

procedure TfrmPrincipal.TVDatabasesDblClick(Sender: TObject);
var
  I: Integer;
  J: Integer;
  Tables: TStringList;
  MenuNode: TTreeNode;
  TableNode: TTreeNode;
begin
  Tables := TStringList.Create();

  ListFDConnection[TVDatabases.Selected.Index].GetTableNames('', '', '', Tables);
  ListFDConnection[TVDatabases.Selected.Index].Offline();

  MenuNode :=  TVDatabases.Items.addChild(TVDatabases.Selected, 'Tables (' + Tables.Count.ToString() + ')');
      MenuNode.ImageIndex := 0;
  for I := 0 to (Tables.Count - 1) do
    begin
      TableNode := TVDatabases.Items.addChild(MenuNode, Tables[i]);
      TableNode.ImageIndex := 1;
    end;
end;

end.
