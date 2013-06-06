unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

uses Unit1,Unit4 , Unit6, Unit7, Unit8;

{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
begin
//vidproc:='fgf';
if cnfpas.Strings[1]=MD5DigestToStr(MD5String(Edit1.Text)) then
begin
if vidproc='procterm' then
  begin
   bproc:=true;
   Form1.N8.Click;
   bproc:=false;
  end;
  if vidproc='sp1click' then
  begin
   bproc:=true;
   Form1.SpeedButton1.Click;
   bproc:=false;
  end;
  if vidproc='sp2click' then
  begin
   bproc:=true;
   Form1.SpeedButton2.Click;
   bproc:=false;
  end;
  if vidproc='sp3click' then
  begin
   bproc:=true;
   Form1.SpeedButton3.Click;
   bproc:=false;
  end;
  if vidproc='sp4click' then
  begin
   bproc:=true;
   Form1.SpeedButton4.Click;
   bproc:=false;
  end;
  if vidproc='sp5click' then
  begin
   bproc:=true;
   Form1.SpeedButton5.Click;
   bproc:=false;
  end;
  if vidproc='sp6click' then
  begin
   bproc:=true;
   Form1.SpeedButton6.Click;
   bproc:=false;
  end;
  if vidproc='sp7click' then
  begin
   bproc:=true;
   Form1.SpeedButton7.Click;
   bproc:=false;
  end;
  if vidproc='ch1click' then
  begin
   bproc:=true;
   Form1.Frame61.CheckBox2Click(sender);
   bproc:=false;
  end;
  if vidproc='ch2click' then
  begin
   bproc:=true;
   Form1.Frame71.CheckBox1.OnClick(Sender);
   bproc:=false;
  end;
   if vidproc='b5click' then
  begin
   bproc:=true;
   Form1.Frame51.Button5.Click;
   bproc:=false;
  end;
  if vidproc='b6click' then
  begin
   bproc:=true;
   Form1.Frame51.Button6.Click;
   bproc:=false;
  end;
  if vidproc='b7click' then
  begin
   bproc:=true;
   Form1.Frame51.Button7.Click;
   bproc:=false;
  end;
  Edit1.Text:='';
Form10.HIDE;
end else
begin
Edit1.Text:='';
Application.MessageBox('¬ведЄн не верный пароль!', 'Dream Admin   ', MB_OK or MB_ICONEXCLAMATION);
end;

end;

procedure TForm10.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
 Button1.Click;
end;
end;

procedure TForm10.FormShow(Sender: TObject);
begin
Edit1.Text:='';
end;

end.
