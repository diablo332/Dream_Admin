program D_A;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas',
  Unit5 in 'Unit5.pas' {Frame5: TFrame},
  Unit6 in 'Unit6.pas' {Frame6: TFrame},
  Unit7 in 'Unit7.pas' {Frame7: TFrame},
  Unit8 in 'Unit8.pas' {Frame8: TFrame},
  Unit9 in 'Unit9.pas' {Frame9: TFrame},
  Unit10 in 'Unit10.pas' {Form10},
  Unit11 in 'Unit11.pas',
  Unit12 in 'Unit12.pas' {Form12},
  Unit13 in 'Unit13.pas';

{$R *.res}

begin
CreateMutex(nil,false,'{6B035483-D313-46BF-89E4-585ED6A8EABD}');
       if (GetLastError=ERROR_ALREADY_EXISTS)or(GetLastError=ERROR_ACCESS_DENIED) then
begin     
 Application.Terminate;     
 Exit;
end;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm12, Form12);
  Application.Run;
end.
