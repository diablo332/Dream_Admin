unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls,Registry;

type
  TFrame6 = class(TFrame)
    CheckBox2: TCheckBox;
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Unit1, Unit10;

{$R *.dfm}


procedure TFrame6.CheckBox2Click(Sender: TObject);
var
reg:TRegistry;
begin
vidproc:='ch1click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
reg:=treginifile.create();
reg.rootkey:=HKEY_CURRENT_USER;
reg.openkey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
if CheckBox2.Checked=true then
begin
reg.WriteString('Dr.Admin', Application.ExeName);
end else
begin
 if reg.ValueExists('Dr.Admin') then
begin
reg.DeleteValue('Dr.Admin');
//reg.WriteString('Dr.Admin', '');
end;

end;

reg.Free;
end else
begin
  Form10.Show;
end;
end;

end.
