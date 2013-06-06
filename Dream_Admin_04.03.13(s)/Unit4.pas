unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sComboBox, sLabel, sEdit, sButton;

type
  TForm4 = class(TForm)
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sEdit1: TsEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sComboBox1: TsComboBox;
    procedure sButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure sEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure sComboBox1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
  private
  lline,coup:integer;
  aline:TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1, Unit2, Unit3;

{$R *.dfm}

procedure TForm4.FormHide(Sender: TObject);
begin
  aline.Free;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  lline:=0;
  coup:=0;
  aline:=TStringList.Create;
end;

procedure TForm4.sButton1Click(Sender: TObject);
var
i:integer;
b:boolean;
begin
for I := 0 to Form1.sListView1.Items.Count - 1 do
begin
if aline.IndexOf(inttostr(i))<0 then
begin
Form1.sListView1.Items[i].Selected:=false;
end;
end;

b:=false;
while (lline<=form1.sListView1.Items.Count-1)and(b=false) do
begin
if sComboBox1.ItemIndex=0 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].Caption))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[0]))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[1]))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[2]))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[3]))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[4]))>0) then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
if sComboBox1.ItemIndex=1 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].Caption))>0)then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
if sComboBox1.ItemIndex=2 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[0]))>0)then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
if sComboBox1.ItemIndex=3 then
begin
if(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[1]))>0) then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
if sComboBox1.ItemIndex=4 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[2]))>0) then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
  if sComboBox1.ItemIndex=5 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[3]))>0)then
begin
b:=true;
end else
begin
  lline:=lline+1;
end;
end else
begin
  if sComboBox1.ItemIndex=6 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[lline].SubItems[4]))>0)then
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
end;

end;
 if lline>form1.sListView1.Items.Count-1 then
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
 if coup<=form1.sListView1.Items.Count then
begin
coup:=coup+1;
  aline.Add(inttostr(lline));

end;
  Form1.sListView1.Items[lline].Selected:=true;

end;
if lline>=form1.sListView1.Items.Count-1 then
begin
  lline:=0;
end else
begin
  lline:=lline+1;
end;

end;

end;

procedure TForm4.sButton2Click(Sender: TObject);
var
i:integer;
begin
for I := 0 to Form1.sListView1.Items.Count - 1 do
begin
if sComboBox1.ItemIndex=0 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].Caption))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[0]))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[1]))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[2]))>0) or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[3]))>0)or
(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[4]))>0) then
begin
coup:=coup+1;
Form1.sListView1.Items[i].Selected:=true;
end;
end else
begin
if sComboBox1.ItemIndex=1 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].Caption))>0)then
begin
coup:=coup+1;
Form1.sListView1.Items[i].Selected:=true;
end;
end else
begin
if sComboBox1.ItemIndex=2 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[0]))>0)then
begin
coup:=coup+1;
Form1.sListView1.Items[i].Selected:=true;
end;
end else
begin
if sComboBox1.ItemIndex=3 then
begin
if(pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[1]))>0) then
begin
coup:=coup+1;
Form1.sListView1.Items[i].Selected:=true;
end;
end else
begin
if sComboBox1.ItemIndex=4 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[2]))>0) then
begin
coup:=coup+1;
Form1.sListView1.Items[i].Selected:=true;
end;
end else
begin
 if sComboBox1.ItemIndex=5 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[3]))>0) then
begin
coup:=coup+1;
Form1.sListView1.Items[i].Selected:=true;
end;
end else
begin
  if sComboBox1.ItemIndex=6 then
begin
if (pos(ansilowercase(trim(sEdit1.Text)),ansilowercase(form1.sListView1.Items[i].SubItems[4]))>0) then
begin
coup:=coup+1;
Form1.sListView1.Items[i].Selected:=true;
end;
end;
end;
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

procedure TForm4.sButton3Click(Sender: TObject);
begin
Form4.Hide;
Form1.show;
sComboBox1.ItemIndex:=0;
sEdit1.Text:='';
end;

procedure TForm4.sComboBox1Click(Sender: TObject);
begin
  coup:=0;
end;

procedure TForm4.sEdit1KeyPress(Sender: TObject; var Key: Char);
var
i:integer;
begin
  if key=#13 then
  begin
    sButton1.Click;
  end else
  begin
    lline:=0;
    coup:=0;
    for I := 0 to Form1.sListView1.Items.Count - 1 do
    begin
      Form1.sListView1.Items[i].Selected:=false;
    end;
  end;
end;

end.
