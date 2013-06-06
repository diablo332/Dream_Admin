unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    TreeView1: TTreeView;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    procedure TreeView1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
if Edit1.Text<>'' then
begin
Form1.ServerSocket1.Close;
Form1.ServerSocket1.Port := StrToInt(Form2.Edit1.Text);
Form1.ServerSocket1.Open;
Label2.Caption:='Сервер включен';
end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
Label1.Caption:='Сервер отключен';
Form1.ServerSocket1.Close;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
Form2.Hide;
form1.Show;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
 Button1.Click;
end;
if not (key in ['0'..'9']) then key:=#0;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form2.Hide;
form1.Show;
end;

procedure TForm2.TreeView1Click(Sender: TObject);
begin
if TreeView1.Selected<>nil then
begin
if TreeView1.Selected.Text='Сеть' then
begin
GroupBox1.Visible:=true;
//Frame81.Visible:=false;
//Frame51.Visible:=false;
//Frame71.Visible:=false;
//Label2.Caption:='Общие настройки';
end else
begin
if TreeView1.Selected.Text='1' then
begin
GroupBox1.Visible:=false;
//Frame81.Visible:=false;
//Frame51.Visible:=false;
//Frame71.Visible:=false;
//Label2.Caption:='Общие настройки';
end else
begin

end;
end;
end;
end;

end.
