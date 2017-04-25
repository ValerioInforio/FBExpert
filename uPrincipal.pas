unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList;

type
  TfrmPrincipal = class(TForm)
    PNLDatabases: TPanel;
    Panel1: TPanel;
    TVDatabases: TTreeView;
    ImageList: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure TVDatabasesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarDatabases;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uDMFBExpert;

procedure TfrmPrincipal.CarregarDatabases;
var
  DSDatabases: TDataSet;
  DatabaseNode: TTreeNode;
begin
  DSDatabases := dmFBExpert.GetDatabases;
  TVDatabases.Items.Clear;
  if not(DSDatabases.IsEmpty) then
    begin
      DSDatabases.First;

      while not(DSDatabases.Eof) do
        begin
          DatabaseNode := TVDatabases.Items.AddChild(nil, DSDatabases.FieldByName('ALIAS').AsString);
//          DatabaseNode.Enabled  := False;
          DSDatabases.Next;
        end;


    end;


end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  CarregarDatabases;
end;

procedure TfrmPrincipal.TVDatabasesClick(Sender: TObject);
begin
  ShowMessage(TVDatabases.Selected.Text);
  ShowMessage(TVDatabases.Selected.Index.ToString());
end;

end.