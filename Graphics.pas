unit Graphics;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,
  Data.DB, VCLTee.TeeData;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Chart1: TChart;
    Label3: TLabel;
    Edit4: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    psi: TLabel;
    tetta: TLabel;
    gamma: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit5: TEdit;
    Label11: TLabel;
    Series1: TFastLineSeries;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Label13: TLabel;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Label14: TLabel;
    Label15: TLabel;
    Edit16: TEdit;
    Vn: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Chart2: TChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Chart3: TChart;
    Series5: TLineSeries;
    Series8: TLineSeries;
    Chart4: TChart;
    Series9: TLineSeries;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Edit19: TEdit;
    Edit20: TEdit;
    Label22: TLabel;
    Edit21: TEdit;
    Edit22: TEdit;
    Label23: TLabel;
    Edit23: TEdit;
    Label24: TLabel;
    Edit24: TEdit;
    Chart5: TChart;
    Series10: TLineSeries;
    Series11: TLineSeries;
    Series12: TLineSeries;
    Chart6: TChart;
    Series13: TLineSeries;
    Chart7: TChart;
    Series14: TLineSeries;
    Edit25: TEdit;
    Label25: TLabel;
    Series15: TLineSeries;
    Chart8: TChart;
    Series16: TLineSeries;
    Series17: TLineSeries;
    Series18: TLineSeries;
    procedure Button1Click(Sender: TObject);
    procedure EditKeyPress(Sender:TObject; var Key:char);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

//Input control to support only floating point numeric data

procedure TForm1.EditKeyPress(Sender:TObject; var Key:char);
  begin
  //Check if input (Key) is in allowed range of symbols
    if not (Key in[#8,'.','-','0'..'9']) then
      begin
      ShowMessage('Invalid key: '+Key);
      Key:=#0; //#0 = empty symbol
      end
      //Check if we have more than 1 "-" or "."
    else if (((Key='.') or (Key='-'))and(Pos(Key,(Sender as TEdit).Text) >0)) then
      begin
      ShowMessage('Invalid key: twice ' +Key);
      Key:=#0;
      end
      //Check if we're trying to input "-" not in the beginning
    else if (Key='-') and ((Sender as TEdit).SelStart<>0) then
    begin
    ShowMessage('Minus allowed only in beginning of text');
    Key:=#0;
    end;


  end;




{$R *.dfm}
//This procedure should not be working since we're not creating TForm1 object but TBorder one
procedure TForm1.Button1Click(Sender: TObject);
begin
  close;
end;

end.
