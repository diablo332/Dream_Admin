unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
  lline,coup:integer;
    aline:TStringList;
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
var
i:integer;
b:boolean;
begin
for I := 0 to Form1.ListView2.Items.Count - 1 do
begin
if aline.IndexOf(inttostr(i))<0 then
begin
Form1.ListView2.Items[i].Selected:=false;
end;
end;

b:=false;
while (lline<=form1.ListView2.Items.Count-1)and(b=false) do
begin
if ComboBox1.ItemIndex=0 then
begin
if (pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].Caption))>0)or
(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].SubItems[0]))>0)or
(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].SubItems[1]))>0)or
(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].SubItems[2]))>0) then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
if ComboBox1.ItemIndex=1 then
begin
if (pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].Caption))>0)then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
if ComboBox1.ItemIndex=2 then
begin
if (pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].SubItems[0]))>0)then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
if ComboBox1.ItemIndex=3 then
begin
if(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].SubItems[1]))>0) then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
  if ComboBox1.ItemIndex=4 then
begin
if(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[lline].SubItems[2]))>0) then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end;
end;
end;
end;
end;

end;
 if lline>form1.ListView2.Items.Count-1 then
begin
if coup=0 then
begin
Application.MessageBox('Ничего не найдено!', 'Поиск   ', MB_OK or MB_ICONEXCLAMATION);
end;
aline.Clear;
  lline:=0;
end else
begin
if b=true then
begin
 if coup<=form1.ListView2.Items.Count then
begin
coup:=coup+1;
  aline.Add(inttostr(lline));

end;
  Form1.ListView2.Items[lline].Selected:=true;

end;
if lline>=form1.ListView2.Items.Count-1 then
begin
  lline:=0;
end else
begin
  lline:=lline+1;
end;

end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
i:integer;
begin
for I := 0 to Form1.ListView2.Items.Count - 1 do
begin
if ComboBox1.ItemIndex=0 then
begin
if (pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].Caption))>0)or
(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].SubItems[0]))>0)or
(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].SubItems[1]))>0)or
(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].SubItems[2]))>0) then
begin
coup:=coup+1;
Form1.ListView2.Items[i].Selected:=true;
end;
end else
begin
if ComboBox1.ItemIndex=1 then
begin
if (pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].Caption))>0)then
begin
coup:=coup+1;
Form1.ListView2.Items[i].Selected:=true;
end;
end else
begin
if ComboBox1.ItemIndex=2 then
begin
if (pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].SubItems[0]))>0)then
begin
coup:=coup+1;
Form1.ListView2.Items[i].Selected:=true;
end;
end else
begin
if ComboBox1.ItemIndex=3 then
begin
if(pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].SubItems[1]))>0) then
begin
coup:=coup+1;
Form1.ListView2.Items[i].Selected:=true;
end;
end else
begin
if ComboBox1.ItemIndex=4 then
begin
if (pos(ansilowercase(trim(Edit1.Text)),ansilowercase(form1.ListView2.Items[i].SubItems[2]))>0) then
begin
coup:=coup+1;
Form1.ListView2.Items[i].Selected:=true;
end;
end else
begin

end;
end;
end;
end;
end;

end;
if coup=0 then
begin
 Application.MessageBox('Ничего не найдено!', 'Поиск   ', MB_OK or MB_ICONEXCLAMATION);
end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
Form2.Hide;
Form1.show;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
var
i:integer;
begin
if key=#13 then
begin
  Button1.Click;
end else
begin
lline:=0;
for I := 0 to Form1.ListView2.Items.Count - 1 do
begin
//Form1.ListView2.Selected[i]:=false;
end;
end;
end;

procedure TForm2.FormHide(Sender: TObject);
begin
aline.Free;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
lline:=0;
coup:=0;
aline:=TStringList.Create;
end;

end.
