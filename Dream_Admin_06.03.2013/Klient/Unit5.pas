unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrame5 = class(TFrame)
    Button7: TButton;
    Button6: TButton;
    Button5: TButton;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame5.Edit1Change(Sender: TObject);
var k,len,stk: integer;
edc,ipv,ipc:string;
begin
len:=0;
for k := 1 to Length(edit1.Text) do
begin
  if edit1.Text[k]='.' then
  begin
     len:=len+1;
  end;

end;

if len=3 then
begin
edc:=Edit1.Text+'.';
ipv:='';
 for k := 0 to 3 do
   begin
   stk:=1;
     ipc:=copy(edc,1,pos('.',edc)-1);
     if ipc<>'' then
       begin
     while (ipc[stk]='0')and (stk<length(ipc)) do
     begin
       ipc:=copy(ipc,stk+1,length(ipc)-1);

     end;
       end;

      if ipc<>'' then
       begin
     if strtoint(ipc)>255 then
     begin
       ipv:=ipv+'.0';
     end else
     begin
       ipv:=ipv+'.'+ipc;
     end;

delete(edc,1,length(copy(edc,1,pos('.',edc)-1))+1);
     end else
     begin
       ipv:='.0'+edc;
     end;
   end;
   Edit1.Text:=copy(ipv,2,length(ipv)-1);
end else
begin
Edit1.Text:='0.0.0.0';
end;
end;

end.
