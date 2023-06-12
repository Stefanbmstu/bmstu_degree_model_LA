program Model_LA;

uses
  Vcl.Forms,
  Graphics in 'Graphics.pas' {Form1},
  LA_class in 'LA_class.pas';

{$R *.res}

var
KB:TBorder;
KC:TController;
KS:TStorage;
begin
  Application.Initialize;
  KS:=TStorage.Create;
  KC:=TController.Create;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TBorder, KB);
  KB.Initials();
  KC.PB:=KB;
  KC.PS:=KS;
  KB.PC:=KC;
  KS.PC:=KC;
  Application.Run;
end.
