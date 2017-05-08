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
  TNodeType = (tntDatabase, tntTable);

  TTreeNodeProperties = class(TTreeNode)
  public
    NodeType : TNodeType;
    NodeName : String;
  end;
  TfrmPrincipal = class(TForm)
    PNLDatabases: TPanel;
    TVDatabases: TTreeView;
    ImageList: TImageList;
    DataSource1: TDataSource;
    FDMemTable1: TFDMemTable;
    MainMenu1: TMainMenu;
    Database1: TMenuItem;
    View1: TMenuItem;
    DBExplorer1: TMenuItem;
    RegisterDatabase1: TMenuItem;
    PopupMenu1: TPopupMenu;
    DatabaseRegistrationInfo1: TMenuItem;
    UnregisterDatabase1: TMenuItem;
    UnregisterDatabase2: TMenuItem;
    PNLPrincipal: TPanel;
    estando1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TVDatabasesDblClick(Sender: TObject);
    procedure DBExplorer1Click(Sender: TObject);
    procedure RegisterDatabase1Click(Sender: TObject);
    procedure DatabaseRegistrationInfo1Click(Sender: TObject);
    procedure UnregisterDatabase1Click(Sender: TObject);
    procedure UnregisterDatabase2Click(Sender: TObject);
    procedure estando1Click(Sender: TObject);
  private
    { Private declarations }
    ListFDConnection: TObjectList<TFDConnection>;
    ListIDDatabases : TList<Integer>;
  public
    { Public declarations }
    procedure CarregarDatabases();
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uDMFBExpert, uRegistrarDatabase, uTabela;

procedure TfrmPrincipal.CarregarDatabases();
var
  DSDatabases: TDataSet;
  DatabaseNode: TTreeNodeProperties;
  FDConnection: TFDConnection;
begin
  DSDatabases := dmFBExpert.GetDatabases();
  TVDatabases.Items.Clear;

  ListFDConnection := TObjectList<TFDConnection>.Create();
  ListIDDatabases  := TList<Integer>.Create();
  if not(DSDatabases.IsEmpty) then
    begin
      DSDatabases.First();

      while not(DSDatabases.Eof) do
        begin
          DatabaseNode := (TTreeNodeProperties (TVDatabases.Items.AddChild(nil, DSDatabases.FieldByName('ALIAS').AsString)));
          DatabaseNode.NodeType := tntDatabase;

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
          ListIDDatabases.Add(DSDatabases.FieldByName('ID').AsInteger);

          DSDatabases.Next();
        end;


    end;


end;

procedure TfrmPrincipal.DatabaseRegistrationInfo1Click(Sender: TObject);
begin
  frmRegistrarDatabase := TfrmRegistrarDatabase.Create(Application, ListIDDatabases[TVDatabases.Selected.Index]);
  frmRegistrarDatabase.ShowModal();
  frmRegistrarDatabase.Free();
  CarregarDatabases();
end;

procedure TfrmPrincipal.DBExplorer1Click(Sender: TObject);
begin
  PNLDatabases.Visible := not PNLDatabases.Visible;
end;

procedure TfrmPrincipal.estando1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmTabela, frmTabela);
  frmTabela.Parent :=  PNLPrincipal;
  frmTabela.Show();
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  CarregarDatabases();
end;

procedure TfrmPrincipal.RegisterDatabase1Click(Sender: TObject);
begin
  frmRegistrarDatabase := TfrmRegistrarDatabase.Create(Application, 0);
  frmRegistrarDatabase.ShowModal();
  frmRegistrarDatabase.Free();
  CarregarDatabases();
end;

procedure TfrmPrincipal.TVDatabasesDblClick(Sender: TObject);
var
  I: Integer;
  J: Integer;
  Tables: TStringList;
//  MenuNode: TTreeNode;
//  TableNode: TTreeNode;
  MenuNode: TTreeNodeProperties;
  TableNode: TTreeNodeProperties;
begin
  if TTreeNodeProperties(TVDatabases.Selected).NodeType = tntDatabase then
     begin
      if not TVDatabases.Selected.HasChildren then
         begin
           Tables := TStringList.Create();
           ListFDConnection[TVDatabases.Selected.Index].GetTableNames('', '', '', Tables); //Kind: TKTable

           MenuNode :=  (TTreeNodeProperties (TVDatabases.Items.addChild(TVDatabases.Selected, 'Tables (' + Tables.Count.ToString() + ')')));
           MenuNode.ImageIndex := 0;
           for I := 0 to (Tables.Count - 1) do
             begin
               TableNode := (TTreeNodeProperties (TVDatabases.Items.addChild(MenuNode, Tables[i])));
               TableNode.NodeType := tntTable;
               TableNode.NodeName := Tables[i];
               TableNode.ImageIndex := 1;
             end;
         end;
     end;
  if TTreeNodeProperties(TVDatabases.Selected).NodeType = tntTable then
     ShowMessage('Deu');
end;

procedure TfrmPrincipal.UnregisterDatabase1Click(Sender: TObject);
begin
  dmFBExpert.DeleteDatabase(ListIDDatabases[TVDatabases.Selected.Index]);
  CarregarDatabases();
end;

procedure TfrmPrincipal.UnregisterDatabase2Click(Sender: TObject);
begin
  dmFBExpert.DeleteDatabase(ListIDDatabases[TVDatabases.Selected.Index]);
  CarregarDatabases();
end;

end.
