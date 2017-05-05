unit uTabela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmTabela = class(TForm)
    PCLPrincipal: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTabela: TfrmTabela;

implementation

{$R *.dfm}

end.
