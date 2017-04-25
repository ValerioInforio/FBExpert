program FBExpert;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDMFBExpert in 'uDMFBExpert.pas' {dmFBExpert: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFBExpert, dmFBExpert);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
