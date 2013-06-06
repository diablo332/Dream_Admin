unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, PSAPI, TlHelp32, StdCtrls, ComCtrls, ExtCtrls, ScktComp,
  Menus, shellapi, Buttons, unit4,registry, Grids, ValEdit, Unit5,
  Unit6, Unit7, Unit8, ImgList;

type
  TForm1 = class(TForm)
   // XPManifest1: TXPManifest;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ClientSocket1: TClientSocket;
    Timer2: TTimer;
    Timer1: TTimer;
    Label5: TLabel;
    N3: TMenuItem;
    N4: TMenuItem;
    PopupMenu2: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    TrayIcon1: TTrayIcon;
    PopupMenu3: TPopupMenu;
    N8: TMenuItem;
    ImageList1: TImageList;
    PopupMenu4: TPopupMenu;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    ImageList3: TImageList;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    ListView2: TListView;
    TabSheet2: TTabSheet;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    ListView1: TListView;
    TabSheet3: TTabSheet;
    Shape7: TShape;
    Shape8: TShape;
    Label3: TLabel;
    SpeedButton6: TSpeedButton;
    ListView3: TListView;
    TabSheet4: TTabSheet;
    Shape5: TShape;
    Shape6: TShape;
    Label2: TLabel;
    Label6: TLabel;
    Frame81: TFrame8;
    Frame71: TFrame7;
    Frame61: TFrame6;
    Frame51: TFrame5;
    TreeView1: TTreeView;
    ImageList2: TImageList;
    ImageList4: TImageList;
    SpeedButton7: TSpeedButton;
    N12: TMenuItem;
    N13: TMenuItem;
    procedure update_m;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure snif;
    procedure Timer1Timer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
//    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Frame81Button1Click(Sender: TObject);
    procedure Frame81Edit1Change(Sender: TObject);
    procedure Frame81Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Frame81Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Frame71CheckBox1Click(Sender: TObject);
    procedure Frame51Button5Click(Sender: TObject);
    procedure Frame51Button6Click(Sender: TObject);
    procedure Frame51Button7Click(Sender: TObject);
    procedure ListView2ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView2Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView2Click(Sender: TObject);
    procedure Frame61CheckBox2Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure ListView3ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView3Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure TrayIcon1DblClick(Sender: TObject);
//    procedure Timer2Timer(Sender: TObject);

  private
  WndMethod: TWndMethod;
  sizm,dte,crc32,put_p,put_p2,username,file_name,file_path,
  ogran_list,rlist,rproc,otch_zap,s_users:TStringList;
  SL:TStringList;//передача запускавшихся процессов
  GFPL,dataf:TStringList;//передача запускавшихся процессов
   ColumnToSort,ColumnToSort2,compix,compix2,sostcol,sostcol2,sizeg:integer;
  bisset:boolean;
    { Private declarations }
  public

    { Public declarations }
  end;
var
  Form1: TForm1;
  vidproc:string;
  capwin:Pchar;
  bproc:boolean;
  clicking,cnfpas:TStringList;
  nproc:TStringList;
  fstrm,configpas,fstrm2:TStream;
  colprocunir1,koun:integer;
  chch2:boolean;
  teststr:string;
implementation

uses Unit2, Unit3, Unit10, Unit11, Unit9, Unit12, Unit13;

{$R *.dfm}
 function HideProcess(pid: DWORD; HideOnlyFromTaskManager: BOOL): BOOL; stdcall;
 external 'guard.dll';
 function KillTask(ppocid:string):boolean;
const
PROCESS_TERMINATE=$0001;
var
FS:THandle;
termbool:boolean;
begin
//EnableDebugPrivilege;
termbool:=false;
result:=termbool;

fs:=OpenProcess(PROCESS_TERMINATE, false, strtoint(ppocid));
    if fs > 0 then
     begin
     while TerminateProcess(fs, 0) do
                 begin
       termbool:=true;
                 end;
                 //CloseHandle(fs);
      // FreeResource(fs);
//       CloseHandle(fs);

     end;
     result:=termbool;
      CloseHandle(fs);
     //FreeResource(fs);

//DisableDebugPrivileges;
end;

 type
 PTOKEN_USER = ^TOKEN_USER;
 _TOKEN_USER = record
   User : TSidAndAttributes;
 end;
 TOKEN_USER = _TOKEN_USER;

function GetCurrentUserAndDomain (var pid:Thandle;
      szUser : PChar; var chUser: DWORD; szDomain :PChar; var chDomain : DWORD
 ):Boolean;
var
 hToken : THandle;
 cbBuf{,h}  : Cardinal;
 ptiUser : PTOKEN_USER;
 snu    : SID_NAME_USE;
begin
 Result:=false;
 // Получаем маркер доступа текущего потока нашего процесса
// h:=GetCurrentThread();
{ if not OpenThreadToken(pid,TOKEN_QUERY,true,hToken)
  then begin
   if GetLastError()<> ERROR_NO_TOKEN then exit;
   // В случее ошибки - получаем маркер доступа нашего процесса.

  end;   }

   if not OpenProcessToken(pid,TOKEN_QUERY,hToken)
    then exit;
 // Вывываем GetTokenInformation для получения размера буфера
 if not GetTokenInformation(hToken, TokenUser, nil, 0, cbBuf)
  then if GetLastError()<> ERROR_INSUFFICIENT_BUFFER
   then begin
    CloseHandle(hToken);
    exit;
   end;

 if cbBuf = 0 then exit;

 // Выделяем память под буфер
 GetMem(ptiUser,cbBuf);

 // В случае удачного вызова получим указатель на TOKEN_USER
 if
 //GetUserName(szUser,chUser)
 GetTokenInformation(hToken,TokenUser,ptiUser,cbBuf,cbBuf)
  then begin
   // Ищем имя пользователя и его домен по его SID
   if LookupAccountSid(nil,ptiUser.User.Sid,szUser,chUser,szDomain,chDomain,snu)
    then
    Result:=true;
  end;

 // Освобождаем ресурсы
 CloseHandle(hToken);
 FreeMem(ptiUser);
end;



//получение Caption по PID
{function ProcessWndEnumerator(hwnd:THandle;param:DWORD):BOOL;stdcall;
var pid:DWORD;
lpBuffer: PChar;
begin
 Result:=true;
 GetWindowThreadProcessId(hwnd,pid);//помоему там var-параметр, если нет то добавьте взятие адреса
 if pid=param then
  begin
 GetMem(capwin, 255);
   if GetWindowText(hwnd,capwin,255)>0 then
begin
  //ShowMessage(inttostr(hwnd) + '  '+ExtractFileName(pe.szExeFile)+' '+string(lpBuffer));

end else
begin
  capwin:='Невозможно получить';
end;
result:=false;
   //значит окно нужного процесса
  end;
end;} 

procedure Tform1.update_m;
var
 //pe: TProcessEntry32;
 // ph, snap: THandle; //дескрипторы процесса и снимка
//  mh: hmodule; //дескриптор модуля
 // procs: array[0..$FFF] of dword; //массив для хранения дескрипторов процессов
  //count, cm: cardinal; //количество процессов
  TheIcon: TIcon;
  i,j: integer;
//  Bitm: TStream;
  //ModName: array[0..max_path] of char; //имя модуля
  h{,hToken}:Thandle;
f:TMemoryStream;
str,c,d,str2,s,sus:string;
b,otchbool:boolean;
Domain, User : array [0..50] of Char;
 chDomain,chUser,hProcess : Cardinal;
  key,a,lv:integer;
mem,s2:string;
bs:TStringList;
Bitm:Tstream;
 UserNameLen : Dword;
 begin //Если WinNT/2000/XP
//  sl.Create;
//i:=0;
{while i<=ListBox1.Items.Count-1 do
begin
if ListBox1.Selected[i] then
begin
clickind.add(ListBox1.Items[i]);
end;
i:=i+1;
end;   }
       // EnableDebugPrivilege;
      //EnableDebugPrivileges;

     GetHandlesProcessList(nproc,rlist,rproc);
     // DisableDebugPrivileges;
     otchbool:=false;
     //clicking.Text:=rlist.Text;
    //  if rproc.Text<>rlist.Text then
    if rlist.Text<>rproc.Text then
begin

//SetPriorityClass(Application.Handle, REALTIME_PRIORITY_CLASS);
                                                    //  begin
      i:=0;
      while (i<=nproc.Count - 1)do
           begin
           if (rproc.IndexOf(rlist.Strings[i])<0) then
                                                            begin
       //    if rproc.IndexOf(nproc.Strings[0])<0 then
//begin
//SetSuspendState (strtoint(rlist.Strings[i]), True);
       str:=ansilowercase(nproc.Strings[i]);
       b:=false;
       if pos(':',str)>0 then
          begin
          if str[pos(':',str)-1]='?' then
            begin
             nproc.Delete(i);
             b:=true;
            end else
            begin
       delete(str,1,pos(':',str)-2);
            end;
          end else
          begin
           if pos('systemroot',str)>0 then
           begin
           delete(str,1,pos('systemroot',str)+10);
           str:='c:\windows\'+str;
           end;
           // str:='C:'+str;
          end;
         if b=false then
           begin
       nproc.Strings[i]:=str;
           end;
//end;

if FileExists(nproc.Strings[i]) then
                                        begin

       d:=MD5DigestToStr(MD5File(nproc.Strings[i]));
        c:=inttostr(FileCRC32(nproc.Strings[i]));
        j:=ogran_list.IndexOf(d);
        b:=false;
// EnableDebugPrivilege;
h:=OpenProcess(PROCESS_QUERY_INFORMATION, false, strtoint(rlist.Strings[i]));
if h>0 then
begin
chDomain:=50;
 chUser :=50;
 UserNameLen :=255 ;
// GetUserName(Pchar(str),UserNameLen);
 if not GetCurrentUserAndDomain(h,User,chuser,Domain,chDomain)  then
 begin
sus:=GetProcessAccount(strtoint(rlist.Strings[i]));
while sus='' do
begin
sus:=GetProcessAccount2(strtoint(rlist.Strings[i]));
end;
{ if trim(sus)='' then
  begin
  sus:=GetProcessAccount2(strtoint(rlist.Strings[i]));
//sus:='Не определено';
  end;                                              }
 end else
 begin
   sus:=user;
 end;
end;
  CloseHandle(h);
  FreeModule(h);
//GetProcessOwner(strtoint(rlist.Strings[i]), user, sizeof(user));

 //DisableDebugPrivileges;
 //while j<=ListView1.Items.Count - 1 do
//begin
//and(c=ListView1.Items[j].SubItems[3])
      if (j>-1)then
      begin
      if pos(string(sus),s_users[j])<=0 then
         begin
        // SetProcessPriority(2);
      if killtask(rlist.Strings[i])=true then
                          begin

                   //  rlist.Strings[i]:='0';
           //         rlist.Delete(i);
         //rproc.Delete(rproc.IndexOf(rlist.Strings[i]));
             //       nproc.Delete(i);
                            b:=true;
                          end;
         end;
                         if b=true then
                                 begin

                           nproc.Delete(i);
                            rlist.Delete(i);
                             i:=i-1;
                                 end;
  //      SetSuspendState(strtoint(rlist.Strings[i]), True);
          {if killtask(rlist.Strings[i])=1 then
                begin
                maspid[strtoint(rlist.Strings[i])]:=0;
                nproc.Delete(i);
                rlist.Delete(i);
      //     if vpr.IndexOf(rlist.Strings[i])>-1 then
        //           begin
         // vpr.Delete(vpr.IndexOf(rlist.Strings[i]));
           //        end;
                  b:=true;
                end else
                begin
                maspid[strtoint(rlist.Strings[i])]:=0;
                nproc.Delete(i);
                rlist.Delete(i);
                b:=true;
                end;            }
      end;
// j:=j+1;
//end;
              if b=false then
                              begin
// SetSuspendState(strtoint(rlist.Strings[i]), True);
 str2:=ExtractFilePath(nproc.Strings[i]);
str:=ExtractFileName(nproc.Strings[i]);
                                crc32.Add(c);
                                    dte.Add(d);
                                    f:= TMemoryStream.Create;
                                      f.LoadFromFile(nproc.Strings[i]);
                                       sizm.Add(inttostr(f.Size));
                                      // s_users.Add('');
         j:=otch_zap.IndexOf(d);
         if j<0 then
           begin

             otch_zap.Add(d);
         //  ListView3.Items.BeginUpdate;
             with ListView3.Items.Add do
             begin
             Caption:=str2;
             SubItems.add(str);
             SubItems.add(inttostr(f.Size));
             SubItems.add(d);
             SubItems.add(c);
             SubItems.add(sus);
             end;
             otchbool:=true;
                  TheIcon:= TIcon.Create;
           TheIcon.Handle:= ExtractIcon(hinstance,Pchar(str2+str),0);
           ListView3.SmallImages:=ImageList3;
if TheIcon.Handle>0 then
begin
ImageList3.AddIcon(TheIcon);
ListView3.Items[ListView3.Items.Count-1].ImageIndex:=koun;
koun:=koun+1;
end else
begin
ImageList3.AddImage(ImageList2,0);
ListView3.Items[ListView3.Items.Count-1].ImageIndex:=koun;
koun:=koun+1;
//ListView3.SmallImages:=ImageList2;
//ListView3.Items[i].ImageIndex:=0;
end;
TheIcon.Free;
           end;
                                       f.Free;
                                       //ListBox1.Items.Add(nproc.Strings[i]);
                                    //SetSuspendState(strtoint(rlist.Strings[i]), True);
                                  file_name.Add(str);
                                  file_path.Add(str2);
                                  //put_p.Add(nproc.Strings[i]);
                                rproc.Add(rlist.Strings[i]);
                                username.Add(sus);

                              end;

                                          end;

                                                              end;

  //   if b=false then
     //  begin
   // SetSuspendState(strtoint(rlist.Strings[i]), True);
  //     end;
    i:=i+1;

           end;

if rproc.Text<>rlist.Text then
begin
          i:=0;
    while (i<=rproc.Count - 1)do
           begin
           if rlist.IndexOf(rproc.Strings[i])<0 then
            begin
            rproc.Delete(i);
            file_name.Delete(i);
            file_path.Delete(i);
           // put_p.Delete(i);
            crc32.Delete(i);
            dte.Delete(i);
            sizm.Delete(i);
            username.Delete(i);
            end;
           i:=i+1;
           end;
end;
      //ListView2.SortType:=stData;
  if rproc.Text<>put_p2.Text then
begin
  Bitm:=TFileStream.Create('ico.dbc',fmCreate);
  Bitm.WriteComponent(ImageList3);
  Bitm.Free;
//Bitm:=TFileStream.Create('ic.dbc',fmOpenRead);
//try
  //Bitm.WriteComponent(ImageList3);
//except

//end;
 //Bitm.Free;


put_p2.Text:=rproc.Text;
ListView2.Items.Clear;
ListView2.Items.BeginUpdate;
 i:=0;
 j:=0;
 ImageList1.Clear;
while (i<=put_p2.Count - 1)do
begin
//ListView2.SortType:=stData;


with ListView2.Items.Add do
begin
 //ListView2.Items[ListView2.Items.Count-1].
  //ImageIndex:=i;
 Caption:=file_path.Strings[i];
 SubItems.Add(file_name.Strings[i]);
SubItems.Add(rproc.Strings[i]);
SubItems.Add(username.Strings[i]);
 end;
 TheIcon:= TIcon.Create;
TheIcon.Handle:= ExtractIcon(hinstance,Pchar(ListView2.Items[i].Caption+ListView2.Items[i].SubItems[0]),0);
if TheIcon.Handle>0 then
begin
ListView2.SmallImages:=ImageList1;
ImageList1.AddIcon(TheIcon);
ListView2.Items[i].ImageIndex:=j;
j:=j+1;
end else
begin
ImageList1.AddImage(ImageList2,0);
ListView2.Items[i].ImageIndex:=j;
j:=j+1;
//ListView2.SmallImages:=ImageList2;
//ListView2.Items[i].ImageIndex:=0;
end;
TheIcon.Free;
   i:=i+1;
end;

ListView2.Items.EndUpdate;

if otchbool=true then
begin
//ListView3.Items.EndUpdate;
////////////
bs:=TStringList.Create;
s:='';
 key:=0;
while not((key>=32)) do
begin
Randomize;
key:=random(256);
end;
bs.Add(inttostr(ListView3.Items.Count+key*2)+chr(key));
for j := 0 to ListView3.Items.Count-1 do
begin
 key:=0;
while key<32 do
begin
Randomize;
key:=random(256);
end;
lv:=0;
while lv<=5 do
begin
if lv=0 then
 begin
mem:=ListView3.Items[j].Caption;
 end else
 begin
 mem:=ListView3.Items[j].SubItems[lv-1];
 end;
i:=1;
lv:=lv+1;
b:=false;
while (b=false)and(i<=Length(mem)) do
begin
a:=ord(mem[i]);
if (a+key)<=255 then
begin
a:=a+key;

if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while (key+a<32)do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;

end else
begin
if (a+key)>255 then
begin
a:=a+key-255;
if a<32 then
begin
key:=0;
a:=ord(mem[i]);
//and(key=0)
while ((key+a)-255<32) do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;
end;
end;
i:=i+1
end;
if b=false then
begin
s:=s+inttostr(length(mem)*2)+chr(1)+s2;
s2:='';
end else
begin
s2:='';
s:='';
end;
end;
bs.Add(s+chr(key));
s:='';
end;
fstrm2.Free;
bs.SaveToFile(extractfilepath(paramstr(0))+'report.dbc');
bs.Free;
fstrm2:=TFileStream.Create(extractfilepath(paramstr(0))+'report.dbc', fmOpenRead and fmShareExclusive);
////////////
end;

i:=0;
    while (i<=clicking.Count - 1)do
           begin
           j:=0;
    while (j<=ListView2.Items.Count - 1)do
           begin
           if ListView2.Items[j].SubItems[1]=clicking.Strings[i] then
                  begin

               ListView2.Items[j].Selected:=true;

                  end else
                  begin
                if clicking.IndexOf(ListView2.Items[j].SubItems[1])<0 then
                                     begin
               ListView2.Items[j].Selected:=false;
                                     end;
                  end;

            j:=j+1;
           end;

//if clicking.IndexOf(vpr.Strings[i])>-1 then
//begin
//ListBox1.Selected[clickind.IndexOf(vpr.Strings[i])]:=true;
//end;
i:=i+1;
           end;
//put_p.Text:=nproc.Text;
end;

                                                           // end;
      //sizm.Clear;
        // dte.Clear;
         //crc32.Clear;
         //put_p.Clear;
// nproc.Free;
 // rlist.Free;
// nproc.Clear;
// rlist.Clear;
    //  ListBox1.Items.Clear;
     // ListBox1.Items.Text:=sl.Text;
       // clickind.Sorted:=true;
     //clickind.CaseSensitive:=true;
     {for j := 0 to ListBox1.Items.Count-1 do
      begin
    for I := 0 to clickind.Count-1 do
      begin
        if ListBox1.Items[j]=clickind.Strings[i] then
           begin
ListBox1.Selected[j]:=true;
           end;
      end;
      end;}
      //end;

end;




     end;
function GetProcessId(pName: PChar): dword;
var
    Snap        :   dword;
    Process     :   PROCESSENTRY32;
    buffer      :   array[0..MAX_PATH] of char;
    hProcess    :   HWND;
begin
    Result := 0;
    Snap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if Snap <> INVALID_HANDLE_VALUE then
    begin
        Process.dwSize := SizeOf(TPROCESSENTRY32);
        if Process32First(Snap, Process) then
        repeat
            hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ , false,
                Process.th32ProcessID);
            if hProcess <> 0 then
            Begin
                GetModuleFileNameEx(hProcess,0,buffer,256);
                CloseHandle(hProcess);
                if lstrcmpi(buffer, pName) = 0 then
                begin
                    Result := Process.th32ProcessID;
                    CloseHandle(Snap);
                    Exit;
                end;
            End;
        until not Process32Next(Snap, Process);
        CloseHandle(Snap);
    end;
end;







procedure TForm1.Button1Click(Sender: TObject);
var
i,ii,key,j,a,lv:integer;
mem,s,s2:string;
bs:TStringList;
b:boolean;
begin

for ii := 0 to ListView2.Items.Count - 1 do
begin
//if ListView2.Selected[ii]=true then
begin
bs:=TStringList.Create;
  mem:='';
  //s:=trim(ListView2.Items[ii]);
  if (s<>'') then
begin
while s[Length(s)]<>'\' do
begin
mem:=s[Length(s)]+mem;
delete(s,Length(s),1);
end;
end;
with ListView1.Items.Add do
begin
caption:=s;
  SubItems.Add(mem);
    SubItems.Add(sizm.Strings[ii]);
    SubItems.Add(dte.Strings[ii]);
end;
s:='';
 key:=0;
while not((key>=32)) do
begin
Randomize;
key:=random(256);
end;
bs.Add(inttostr(ListView1.Items.Count+key*2)+chr(key));
for j := 0 to ListView1.Items.Count-1 do
begin
 key:=0;
while key<32 do
begin
Randomize;
key:=random(256);
end;
for lv := 0 to 3 do
begin
if lv=0 then
 begin
mem:=ListView1.Items[j].Caption;
 end else
 begin
 mem:=ListView1.Items[j].SubItems[lv-1];
 end;
i:=1;
b:=false;
while (b=false)and(i<=Length(mem)) do
begin
a:=ord(mem[i]);
if (a+key)<=255 then
begin
a:=a+key;

if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while (key+a<32)do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
end else
begin
s2:=s2+chr(a);
end;

end else
begin
if (a+key)>255 then
begin
a:=a+key-255;
if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while ((key+a)-255<32)and(key=0) do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
end else
begin
s2:=s2+chr(a);
end;
end;
end;
i:=i+1
end;
s:=s+inttostr(length(mem)*2)+chr(1)+s2;
s2:='';
end;
bs.Add(s+chr(key));
s:='';
end;
bs.SaveToFile(extractfilepath(paramstr(0))+'base.dbc');
bs.Free;
end;
end;

end;

procedure TForm1.Button9Click(Sender: TObject);
var
sysimagelist:uint;
sfi:TSHFileInfo;
begin
ListView1.LargeImages:=TImageList.Create(self);
ListView1.SmallImages:=TImageList.Create(self);
sysimagelist:=SHGetFileInfo('',0,sfi, sizeof(TSHFileinfo),SHGFI_SYSICONINDEX or SHGFI_LARGEICON);
if sysimagelist<>0 then
begin
ListView1.LargeImages.Handle:=sysimagelist;
ListView1.LargeImages.ShareImages:=true;
end;
sysimagelist:=SHGetFileInfo('',0,sfi, sizeof(TSHFileinfo),SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
if sysimagelist<>0 then
begin
ListView1.SmallImages.Handle:=sysimagelist;
ListView1.SmallImages.ShareImages:=true;
end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
//if access=false then
//begin
//access := True;
//DeviceIoControl(hDriver, Cardinal(4), nil, 0, nil, 0, TrId, nil);
//UnloadDriver(DrvName);
//end else
//begin
//access := True;

//DeviceIoControl(hDriver, Cardinal(4), nil, 0, nil, 0, TrId, nil);
//LoadDriver(DrvName);
//end;
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Label6.Caption:='Подключение выполненно!';
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Label6.Caption:='Подключение к серверу отсутствует!';
end;

procedure TForm1.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
ErrorCode:=0;
Label6.Caption:='Подключение к серверу отсутствует!';
Frame51.Button5.Click;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
procedure cl(var s:string; ch:char);
    begin
    delete(s,1,pos(ch,s));
    end;
var
  sSoket,s,otrez:string;
  i:integer;
  de: Integer;
  ce: Integer;
begin
  sSoket:= Socket.ReceiveText;

  if copy(sSoket, 1, 19)='getforbiddenprocess' then
  begin
    ClientSocket1.Socket.SendText('ok_gfpl');
    sSoket:='';
  end;

  if copy(sSoket, 1, 7)='givproc' then
  begin
    SL := TStringList.Create;
    for I := 0 to ListView3.Items.Count - 1 do
    begin
      s :=ListView3.Items[i].Caption + #8;
      s := s + ListView3.Items[i].SubItems[0] + #8;
      s := s + ListView3.Items[i].SubItems[1] + #8;
      s := s + ListView3.Items[i].SubItems[2] + #8;
      s := s + ListView3.Items[i].SubItems[3] + #8;
      s := s + ListView3.Items[i].SubItems[4] + #8;
      SL.Add(s);
      s:='';
    end;
    ClientSocket1.Socket.SendText('ok_proc'+inttostr(SL.Count)+#8);
  sSoket:='';
  end;

  if copy(sSoket, 1, 7)='ok_gfpl' then
  begin
    delete(sSoket,1,7);
    sizeg := strtoint(copy(sSoket,1,pos(#8,sSoket)-1));
    ClientSocket1.Socket.SendText('ok_givproc0'+#8);
    SL := TStringList.Create;
    ogran_list.Clear;
    dataf.Clear;
     sSoket:='';
  end;

    if copy(sSoket, 1, 2)='st' then
  begin
    Delete(sSoket,1,2);
    if SL.Count<sizeg then
      begin
        i := strtoint(copy(sSoket,1,pos(#8,sSoket)-1));
        i := i + 1;
        delete(sSoket,1, pos(#8,sSoket));
        s := sSoket;
        cl(s,#8);
        cl(s,#8);
        cl(s,#8);
        s := copy(s,1,pos(#8,s)-1);
        if ogran_list.IndexOf(s) < 0 then
          begin
            dataf.Add(sSoket);
            ogran_list.Add(s);
//            bisset := true;
          end;
        SL.Add(sSoket);
        ClientSocket1.Socket.SendText('ok_givproc' +
        inttostr(i) + #8);
      end else
      begin
//        if bisset = true then
//          begin
        ListView1.Items.BeginUpdate;
        i:=0;
        bisset := false;
        ListView1.Items.Clear;
          while dataf.Count > i do
          begin
              otrez := dataf.Strings[i];
              with ListView1.Items.Add do
              begin
                caption := copy(otrez,1,pos(#8,otrez)-1);
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                de:=dte.IndexOf(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                ce:=crc32.IndexOf(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                s_users.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
              end;
              if de >= 0 then
                begin
                  rproc.Delete(de);
                  sizm.Delete(de);
                  dte.Delete(de);
                  crc32.Delete(de);
                  username.Delete(de);
                  file_name.Delete(de);
                  file_path.Delete(de);
                end;
               inc(i);
          end;
    ListView1.Items.EndUpdate;
//          end;
//    nconect:=-1;
//    proc_or_f := true;
//    Timer1.Enabled := true;
    SL.Free;
//    Dataf.SaveToFile(extractfilepath(paramstr(0))+'report.dbc');
      end;
  end;

  if copy(sSoket, 1, 10)='ok_givproc' then
  begin
    delete(sSoket,1,10);
    i := strtoint(copy(sSoket,1,pos(#8,sSoket)-1));
    if i<Sl.Count then
      begin
        ClientSocket1.Socket.SendText('st' + inttostr(i) + #8 + SL.Strings[i]);
      end else
      begin
        ClientSocket1.Socket.SendText('st');
        sl.Free;
      end;
    sSoket:='';
  end;
if copy(sSoket, 1, 7)='vklotsl' then
begin
Timer2.Enabled:=TRUE;
sSoket:='';
end;
if copy(sSoket, 1, 7)='otkotsl' then
begin
Timer2.Enabled:=FALSE;
sSoket:='';
end;
if copy(sSoket, 1, 7)='addproc' then
begin
delete(sSoket,1,7);
sSoket:='';
end;
if copy(sSoket, 1, 4)='show' then
begin
ShowWindow(Handle, SW_SHOW);
end;
if copy(sSoket, 1, 4)='hide' then
begin
ShowWindow(Handle, SW_HIDE);
end;
if copy(sSoket, 1, 7)='shellex' then
begin
delete(sSoket,1,7);
WinExec(pChar(sSoket), SW_SHOW);
sSoket:='';
end;
end;

procedure TForm1.FormActivate(Sender: TObject);
{var
Bitm:TStream;
begin  }
begin

{if FileExists(ExtractFilePath(paramstr(0))+'im.dbc') then
begin
ImageList3.Clear;
Bitm:=TFileStream.Create('im.dbc',fmCreate);
Bitm.ReadComponent(ImageList3);
 Bitm.Free;
end;}
//ShowWindow(Form1.Handle, SW_HIDE);
//SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOSIZE);

ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ShowWindow(Form1.Handle,SW_HIDE);
ShowWindow(Application.Handle, SW_HIDE);
abort;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
t_in:TIniFile;
szn,s,prov,cp:String;
cpoc,i,j,a,key,lv,lv2:integer;
bs:TStringList;
mas:array of integer;
reg:TRegistry;
rgn: HRGN;
  r: TRect;
  Bitm:Tstream;
  errcod:integer;
begin
ProtectObject(GetCurrentProcess);
ProtectObject(GetCurrentThread);
EnableDebugPrivilege;
bproc:=false;
dataf := TStringList.Create;
      rlist:=TStringList.Create;
      nproc:=TStringList.Create;
clicking:=TStringList.Create;
//vpr:=TStringList.Create;
ogran_list:=TStringList.Create;
username:=TStringList.Create;
file_name:=TStringList.Create;
file_path:=TStringList.Create;
otch_zap:=TStringList.Create;
s_users:=TStringList.Create;
colprocunir1:=0;
koun:=0;

//  reg.Free;
    //reg:=treginifile.create();
 // reg.rootkey:=HKEY_CURRENT_USER;
//reg.openkey('\Software\Dr.Admin', false);
//if reg.ValueExists('Dr.Admin') then
 // begin
 // if reg.readString('Dr.Admin')='none' then
  // begin
//reg.CloseKey;
//Frame71.CheckBox1.Checked:=false;
//Frame71.Label1.Caption:='';
  // end else
  // begin
   //reg.CloseKey;
//Frame71.CheckBox1.Checked:=true;
   //LoadLibrary(pchar(ExtractFileDir(Application.ExeName)+'\'+'HideDLL.dll'));
//HideProcess(GetCurrentProcessId, true); //это спрячет текущий процесс
  // end;
  //end else
  //begin
//reg.CloseKey;
//Frame71.CheckBox1.Checked:=true;
  // LoadLibrary(pchar(ExtractFileDir(Application.ExeName)+'\'+'HideDLL.dll'));
//HideProcess(GetCurrentProcessId, true); //это спрячет текущий процесс
  //end;
  cnfpas:=TStringList.Create;
           rproc:=TStringList.Create;
//sss:=extractfilepath(paramstr(0));
//
  if FileExists(extractfilepath(paramstr(0))+'config.dbc') then
begin
//extractfilepath(paramstr(0))+

 cnfpas.LoadFromFile(extractfilepath(paramstr(0))+'config.dbc');

 errcod:=IOResult;
 if   errcod<>0 then
  begin
  errcod:=0;
configpas.Free;
configpas:=TFileStream.Create(extractfilepath(paramstr(0))+'config.dbc', fmOpenRead and fmShareExclusive);
  end;


 if cnfpas.Count>0 then
begin
 if cnfpas.Strings[0]='yes' then
 begin
 bproc:=true;
Frame71.CheckBox1.Checked:=true;
bproc:=false;

 end else
 begin
if cnfpas.Strings[0]='none' then
begin
bproc:=true;
Frame71.CheckBox1.Checked:=false;
bproc:=false;
end else
begin

bproc:=true;
  Frame71.CheckBox1.Checked:=true;
  bproc:=false;
end;
 end;
end else
begin
cnfpas.Add('yes');
cnfpas.Add('D41D8CD98F00B204E9800998ECF8427E');
cnfpas.SaveToFile(extractfilepath(paramstr(0))+'config.dbc');
 bproc:=true;
 Frame71.CheckBox1.Checked:=true;
bproc:=false;
end;
end else
begin
cnfpas.Add('yes');
cnfpas.Add('D41D8CD98F00B204E9800998ECF8427E');
 cnfpas.SaveToFile(extractfilepath(paramstr(0))+'config.dbc');
 bproc:=true;
 Frame71.CheckBox1.Checked:=true;
bproc:=false;
end;
 reg:=treginifile.create();
  reg.rootkey:=HKEY_LOCAL_MACHINE;
reg.openkey('\Software\Microsoft\Windows\CurrentVersion\Run', false);
if reg.ValueExists('Dr.Admin') then
  begin

  if reg.readString('Dr.Admin')='' then
   begin
   //ShowMessage('11');
reg.CloseKey;
bproc:=true;
Frame61.CheckBox2.Checked:=false;
chch2:=false;
bproc:=false;
   end else
   begin
reg.CloseKey;
bproc:=true;
Frame61.CheckBox2.Checked:=true;
bproc:=false;
chch2:=true;
   end;
  end else
  begin

reg.CloseKey;
bproc:=true;
Frame61.CheckBox2.Checked:=false;
bproc:=false;
  end;

sostcol:=0;
sostcol2:=0;
sizm:=TStringList.Create;
dte:=TStringList.Create;
crc32:=TStringList.Create;
bproc:=true;
Frame51.Button5.Click;
bproc:=false;
/////////////////////Style
//r := Listbox1.ClientRect;
  //rgn := CreateRoundRectRgn(r.Left, r.top, r.right, r.bottom, 20, 20);
  //Listbox1.BorderStyle := bsNone;
  //Listbox1.Perform(EM_GETRECT, 0, lparam(@r));
  //InflateRect(r, -5, -5);
 // Listbox1.Perform(EM_SETRECTNP, 0, lparam(@r));
//  SetWindowRgn(Listbox1.Handle, rgn, true);
/////////////////////
put_p:=TStringList.Create;
put_p2:=TStringList.Create;
 bs:=TStringList.Create;
//extractfilepath(paramstr(0))+
ImageList4.Clear;
if FileExists(ExtractFilePath(paramstr(0))+'icx.dbc') then
begin
ListView1.SmallImages:=ImageList4;
//ImageList1.Clear;
   Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'icx.dbc',fmOpenRead);
    errcod:=IOResult;
 if   errcod<>0 then
  begin
  errcod:=0;
Bitm.Free;
Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'icx.dbc',fmOpenRead);
  end;

  Bitm.ReadComponent(ImageList4);
  Bitm.Free;
end else
begin
  Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'icx.dbc',fmCreate);
 errcod:=IOResult;
 if   errcod<>0 then
  begin
  errcod:=0;
Bitm.Free;
  Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'icx.dbc',fmCreate);
  end;
  Bitm.WriteComponent(ImageList4);
  Bitm.Free;

  end;


  if FileExists(extractfilepath(paramstr(0))+'base.dbc') then
begin
//extractfilepath(paramstr(0))+
 bs.LoadFromFile(extractfilepath(paramstr(0))+'base.dbc');
 errcod:=IOResult;
 if   errcod<>0 then
  begin
  errcod:=0;
Bs.Free;
bs.LoadFromFile(extractfilepath(paramstr(0))+'base.dbc');
  end;

 ListView1.Items.Clear;
if trim(bs.Text)<>'' then
begin
  szn:=bs.Strings[0];
  prov:=copy(szn,1,Length(szn)-1);
  i:=Length(szn);
cpoc:=(strtoint(prov)-ord(szn[i])*2);
for I := 1 to cpoc  do
   begin

 szn:=bs.Strings[i];
 if bs.Strings[i]<>'' then
begin

  for lv2 := 0 to 6 do
begin
  lv:=strtoint(copy(szn,1,pos(#1,szn)-1))div 2;
 delete(szn,1,pos(#1,szn));

 key:=ord(szn[Length(szn)]);
 for j := 1 to lv do
begin
a:=ord(szn[j]);
if (a-key)<=0 then
begin
a:=255+a-key;
s:=s+chr(a);
end else
begin
if (a-key)>0 then
begin
 a:=a-key;
s:=s+chr(a);
end;
end;
end;
 delete(szn,1,lv);
 SetLength(mas,lv2+1);
 mas[lv2]:=lv;
end;
//ListView1.SortType:=stNone;
with ListView1.Items.Add do
begin
cp:=copy(s,1,mas[0]);
caption:=cp;
cp:=copy(s,mas[0]+1,mas[1]);
  SubItems.Add(cp);
cp:=copy(s,mas[0]+mas[1]+1,mas[2]);
  SubItems.Add(cp);
  cp:=copy(s,mas[0]+mas[1]+mas[2]+1,mas[3]);
  SubItems.Add(cp);
  ogran_list.Add(cp);
  cp:=copy(s,mas[0]+mas[1]+mas[2]+mas[3]+1,mas[4]);
  SubItems.Add(cp);
  cp:=copy(s,mas[0]+mas[1]+mas[2]+mas[3]+mas[4]+1,mas[5]);
  SubItems.Add(cp);
  s_users.Add(cp);
  cp:=copy(s,mas[0]+mas[1]+mas[2]+mas[3]+mas[4]+mas[5]+1,mas[6]);
  ImageIndex:=strtoint(cp);
//   ImageIndex:=i2;
s:='';
end;
//ListView1.Items[i].ImageIndex:=i;


s:='';
end;
   end;

 end;
end else
begin
//extractfilepath(paramstr(0))+
  bs.SaveToFile(extractfilepath(paramstr(0))+'base.dbc');
end;
  bs.Free;
fstrm:=TFileStream.Create(extractfilepath(paramstr(0))+'base.dbc', fmOpenRead and fmShareExclusive);
//configpas:=TFileStream.Create('config.dbc', fmOpenRead and fmShareExclusive);
 bs:=TStringList.Create;
//extractfilepath(paramstr(0))+
if FileExists(ExtractFilePath(paramstr(0))+'ico.dbc') then
begin
ListView3.SmallImages:=ImageList3;
//ImageList1.Clear;
   Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'ico.dbc',fmOpenRead);
   if   GetLastError<>0 then
  begin
Bitm.Free;
   Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'ico.dbc',fmOpenRead);
  end;
  Bitm.ReadComponent(ImageList3);
   Bitm.Free;

  koun:=ImageList3.Count;
end else
begin
  Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'ico.dbc',fmCreate);
   if   GetLastError<>0 then
  begin
Bitm.Free;
   Bitm:=TFileStream.Create(ExtractFilePath(paramstr(0))+'ico.dbc',fmOpenRead);
  end;
  Bitm.WriteComponent(ImageList3);
  Bitm.Free;
end;


  if FileExists(extractfilepath(paramstr(0))+'report.dbc') then
begin
//extractfilepath(paramstr(0))+

 bs.LoadFromFile(extractfilepath(paramstr(0))+'report.dbc');
  if   GetLastError<>0 then
  begin
Bs.Free;
bs.LoadFromFile(extractfilepath(paramstr(0))+'report.dbc');
  end;
 ListView3.Items.Clear;
if trim(bs.Text)<>'' then
begin
  szn:=bs.Strings[0];
  prov:=copy(szn,1,Length(szn)-1);
  i:=Length(szn);
cpoc:=(strtoint(prov)-ord(szn[i])*2);
for I := 1 to cpoc  do
   begin

 szn:=bs.Strings[i];
 if bs.Strings[i]<>'' then
begin

  for lv2 := 0 to 5 do
begin
  lv:=strtoint(copy(szn,1,pos(#1,szn)-1))div 2;
 delete(szn,1,pos(#1,szn));

 key:=ord(szn[Length(szn)]);
 for j := 1 to lv do
begin
a:=ord(szn[j]);
if (a-key)<=0 then
begin
a:=255+a-key;
s:=s+chr(a);
end else
begin
if (a-key)>0 then
begin
 a:=a-key;
s:=s+chr(a);
end;
end;
end;
 delete(szn,1,lv);
 SetLength(mas,lv2+1);
 mas[lv2]:=lv;
end;
with ListView3.Items.Add do
begin
cp:=copy(s,1,mas[0]);
caption:=cp;
cp:=copy(s,mas[0]+1,mas[1]);
  SubItems.Add(cp);
cp:=copy(s,mas[0]+mas[1]+1,mas[2]);
  SubItems.Add(cp);
  cp:=copy(s,mas[0]+mas[1]+mas[2]+1,mas[3]);
  SubItems.Add(cp);
otch_zap.Sorted:=true;
  otch_zap.Duplicates:=dupIgnore;
  otch_zap.Add(cp);
  cp:=copy(s,mas[0]+mas[1]+mas[2]+mas[3]+1,mas[4]);
  SubItems.Add(cp);
  cp:=copy(s,mas[0]+mas[1]+mas[2]+mas[3]+mas[4]+1,mas[5]);
  SubItems.Add(cp);

s:='';
end;
ListView3.Items[ListView3.Items.Count -1].ImageIndex:=ListView3.Items.Count -1;


s:='';
end;
   end;

 end;
 ListView3.Items.BeginUpdate;
  ListView3.Items.endUpdate;
end else
begin
//extractfilepath(paramstr(0))+
  bs.SaveToFile(extractfilepath(paramstr(0))+'report.dbc');
end;
  bs.Free;
fstrm2:=TFileStream.Create(extractfilepath(paramstr(0))+'report.dbc', fmOpenRead and fmShareExclusive);


 //ShowWindow(Form1.Handle,SW_HIDE);
//ShowWindow(Application.Handle, SW_HIDE);

end;


procedure TForm1.FormShow(Sender: TObject);
begin
//TreeView1.Items[0][0].Expand(True)
TreeView1.Items.GetFirstNode.Item[0].Selected:=true;
//if f = false then
//Begin
//f := True;
//access := False;
//if PrtCode = PROTECT_OK then
//Begin
 //GetCurrentProcessId;

//End
//else
//Begin
  //access := True;
//End;
//End;
end;
function KillDll(aDllName: string): Boolean;
var 
  hDLL: THandle; 
  aName: array[0..10] of char; 
  FoundDLL: Boolean; 
begin 
  StrPCopy(aName, aDllName); 
  FoundDLL := False; 
  repeat
    hDLL := GetModuleHandle(aName); 
    if hDLL = 0 then 
      Break; 
    FoundDLL := True; 
    FreeLibrary(hDLL); 
  until False; 
end;

procedure TForm1.Frame51Button5Click(Sender: TObject);
begin
vidproc:='b5click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
ClientSocket1.Close;
ClientSocket1.Address := Frame51.Edit1.Text;
ClientSocket1.Port := StrToInt(Frame51.Edit2.Text);
ClientSocket1.Open;
end else
begin
 Form10.Show;
end;
end;

procedure TForm1.Frame51Button6Click(Sender: TObject);
begin
vidproc:='b6click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
   ClientSocket1.Close;
   Label6.Caption:='Подключение к серверу отсутствует!';
end else
begin
 Form10.Show;
end;
end;

procedure TForm1.Frame51Button7Click(Sender: TObject);
begin
vidproc:='b7click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin

end else
begin
 Form10.Show;
end;
end;

procedure TForm1.Frame61CheckBox2Click(Sender: TObject);
begin
  Frame61.CheckBox2Click(Sender);
end;

procedure TForm1.Frame71CheckBox1Click(Sender: TObject);
begin
vidproc:='ch2click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
if Frame71.CheckBox1.Checked=true then
begin
cnfpas.Strings[0]:='yes';
Frame71.Label1.Caption:='';
//extractfilepath(paramstr(0))+
//Timer4.Enabled:=true;

end else
begin
//Timer4.Enabled:=false;

cnfpas.Strings[0]:='none';
Frame71.Label1.Caption:='Требуется перезапустить Dream Admin';
//KillDll();
end;
configpas.Free;
//extractfilepath(paramstr(0))+
cnfpas.SaveToFile(extractfilepath(paramstr(0))+'config.dbc');
configpas:=TFileStream.Create(extractfilepath(paramstr(0))+'config.dbc', fmOpenRead and fmShareExclusive);
//ShowMessage('ololo');
//Application.MessageBox('Настройки программы', 'Для вступления настроек в силу необходимо перезапустить программу!', MB_OK or MB_ICONEXCLAMATION);

end else
begin
  Form10.Show;
end;
end;

procedure TForm1.Frame81Button1Click(Sender: TObject);
var
s:string;
begin
//Edit1.Text:=MD5DigestToStr(MD5String(Edit1.Text));

if (Frame81.Edit2.Text=Frame81.Edit3.Text) then
begin
if (Frame81.Edit2.Enabled=true)
and(Frame81.Edit3.Enabled=true)then
 begin  
cnfpas.Strings[1]:=MD5DigestToStr(MD5String(Frame81.Edit2.Text));
configpas.Free;
if not(FileExists('config.dbc')) then
begin
cnfpas.Strings[0]:='yes';
end;
cnfpas.SaveToFile('config.dbc');
configpas:=TFileStream.Create(extractfilepath(paramstr(0))+'config.dbc', fmOpenRead and fmShareExclusive);
Frame81.Edit2.Text:='';
Frame81.Edit3.Text:='';

if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E') then
begin
Frame81.Edit1.Enabled:=false;
Frame81.Edit2.Enabled:=true;
Frame81.Edit3.Enabled:=true;
end else
begin
Frame81.Edit1.Enabled:=true;
Frame81.Edit2.Enabled:=false;
Frame81.Edit3.Enabled:=false;
end;
Application.MessageBox('Пароль установлен.', 'Dream Admin   ', MB_OK or MB_ICONEXCLAMATION);
 end else
 begin
 Frame81.Edit1.Text:='';
   Application.MessageBox('Введите старый пароль!', 'Dream Admin   ', MB_OK or MB_ICONEXCLAMATION); 
 end;
end else
begin
Frame81.Edit2.Text:='';
Frame81.Edit3.Text:='';
   Application.MessageBox('Новый пароль и его подтверждение не совпадают!', 'Dream Admin   ', MB_OK or MB_ICONEXCLAMATION);
end;

//ShowMessage(MD5DigestToStr(MD5String(Frame81.Edit1.Text)));

end;

procedure TForm1.Frame81Edit1Change(Sender: TObject);
begin
if cnfpas.Strings[1]=MD5DigestToStr(MD5String(Frame81.Edit1.Text)) then
begin
Frame81.Edit1.Enabled:=false;
Frame81.Edit2.Enabled:=true;
Frame81.Edit3.Enabled:=true;
Frame81.Edit1.Text:='';
Application.MessageBox('Соответствие выполненно.', 'Dream Admin   ', MB_OK or MB_ICONEXCLAMATION);
end;
end;

procedure TForm1.Frame81Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
  Frame81.Button1.Click;
end;
end;

procedure TForm1.Frame81Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
  Frame81.Button1.Click;
end;
end;

procedure TForm1.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
var
i,j,in1:integer;
cap,fpth,razm,mdd,crcc:string;
b:boolean;
begin
ColumnToSort := Column.Index;
(Sender as TCustomListView).AlphaSort;
if ColumnToSort=0 then
begin
if ColumnToSort<>sostcol then
begin
compix:=1;
sostcol:=ColumnToSort;
end;
if compix=0 then
begin
compix:=1;
end else
begin
if compix=1 then
begin
compix:=0;
end;
end;
end else
begin
if ColumnToSort<>2 then
begin
if ColumnToSort<>sostcol then
begin
compix:=1;
sostcol:=ColumnToSort;
end;
if compix=0 then
begin
compix:=1;
end else
begin
if compix=1 then
begin
compix:=0;
end;
end;
end else
begin
if ColumnToSort<>sostcol then
begin
compix:=1;
sostcol:=ColumnToSort;
end;
if compix=0 then
begin
compix:=1;
ListView1.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to ListView1.Items.Count-2 do
   if strtoint(ListView1.Items[i].SubItems[1]) > strtoint(ListView1.Items[i+1].SubItems[1]) then
    begin
     cap := ListView1.Items[i].Caption ;
          fpth:=ListView1.Items[i].SubItems[0];
          razm:= ListView1.Items[i].SubItems[1] ;
                    mdd:= ListView1.Items[i].SubItems[2] ;
                                        crcc:= ListView1.Items[i].SubItems[3] ;
                                        in1:=ListView1.Items[i].ImageIndex;
ListView1.Items[i].Caption:= ListView1.Items[i+1].Caption ;
    ListView1.Items[i].SubItems[0]:=ListView1.Items[i+1].SubItems[0] ;
          ListView1.Items[i].SubItems[1]:= ListView1.Items[i+1].SubItems[1] ;
                    ListView1.Items[i].SubItems[2]:= ListView1.Items[i+1].SubItems[2] ;
                          ListView1.Items[i].SubItems[3]:= ListView1.Items[i+1].SubItems[3] ;
                          ListView1.Items[i].ImageIndex:=ListView1.Items[i+1].ImageIndex;
ListView1.Items[i+1].Caption:=cap;
      ListView1.Items[i+1].SubItems[0]:=fpth;
          ListView1.Items[i+1].SubItems[1]:= razm ;
                    ListView1.Items[i+1].SubItems[2]:= mdd ;
                          ListView1.Items[i+1].SubItems[3]:= crcc ;
                          ListView1.Items[i+1].ImageIndex:=in1;
     b:= false;
    end;

 until b;
 ListView1.Items.EndUpdate;

end else
begin
if compix=1 then
begin
compix:=0;
ListView1.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to ListView1.Items.Count-2 do
   if strtoint(ListView1.Items[i].SubItems[1]) < strtoint(ListView1.Items[i+1].SubItems[1]) then
    begin
     cap := ListView1.Items[i+1].Caption ;
          fpth:=ListView1.Items[i+1].SubItems[0];
          razm:= ListView1.Items[i+1].SubItems[1] ;
                    mdd:= ListView1.Items[i+1].SubItems[2] ;
                                        crcc:= ListView1.Items[i+1].SubItems[3] ;
                                        in1:=ListView1.Items[i+1].ImageIndex;
ListView1.Items[i+1].Caption:= ListView1.Items[i].Caption ;
    ListView1.Items[i+1].SubItems[0]:=ListView1.Items[i].SubItems[0] ;
          ListView1.Items[i+1].SubItems[1]:= ListView1.Items[i].SubItems[1] ;
                    ListView1.Items[i+1].SubItems[2]:= ListView1.Items[i].SubItems[2] ;
                          ListView1.Items[i+1].SubItems[3]:= ListView1.Items[i].SubItems[3] ;
                               ListView1.Items[i+1].ImageIndex:=ListView1.Items[i].ImageIndex;
ListView1.Items[i].Caption:=cap;
      ListView1.Items[i].SubItems[0]:=fpth;
          ListView1.Items[i].SubItems[1]:= razm ;
                    ListView1.Items[i].SubItems[2]:= mdd ;
                          ListView1.Items[i].SubItems[3]:= crcc ;
                              ListView1.Items[i].ImageIndex:=in1;
     b:= false;
    end;

 until b;
 ListView1.Items.EndUpdate;

end;
end;



end;
end;

end;

procedure TForm1.ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
ix,i: Integer;
begin

if ColumnToSort = 0 then
begin
ListView1.SortType:=stBoth;
if compix=0 then
begin
Compare := CompareText(Item1.Caption,Item2.Caption);
end else
begin
if compix=1 then
begin
 Compare := -CompareText(Item1.Caption,Item2.Caption);
end;                                                                     
end;

end
else begin
if ColumnToSort <> 2 then
begin
ListView1.SortType:=stBoth;
if compix=0 then
begin
ix := ColumnToSort - 1;
Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
 end else
begin
if compix=1 then
begin
ix := ColumnToSort - 1;
Compare := -CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
end;
end;
end else
begin
//Compare :=0;
end;
end;
end;

procedure TForm1.ListView2Click(Sender: TObject);
var
i:integer;
begin
i:=0;
clicking.Clear;
while i<=ListView2.Items.Count-1 do
begin
if ListView2.Items[i].Selected=true then
begin
 clicking.Add(ListView2.Items[i].SubItems[1]);
end;
 i:=i+1;
end;

end;

procedure TForm1.ListView2ColumnClick(Sender: TObject; Column: TListColumn);
var
i,j,i1,j1,in1,in2:integer;
cap,fpth,razm,mdd,crcc:string;
b:boolean;
begin
ColumnToSort2 := Column.Index;
(Sender as TCustomListView).AlphaSort;
if ColumnToSort2=0 then
begin
if ColumnToSort2<>sostcol2 then
begin
compix2:=1;
sostcol2:=ColumnToSort2;
end;
if compix2=0 then
begin
compix2:=1;
end else
begin
if compix2=1 then
begin
compix2:=0;
end;
end;
end else
begin
if ColumnToSort2<>2 then
begin
if ColumnToSort2<>sostcol2 then
begin
compix2:=1;
sostcol2:=ColumnToSort2;
end;
if compix2=0 then
begin
compix2:=1;
end else
begin
if compix2=1 then
begin
compix2:=0;
end;
end;
end else
begin
if ColumnToSort2<>sostcol2 then
begin
compix2:=1;
sostcol2:=ColumnToSort2;
end;
if compix2=0 then
begin
compix2:=1;
ListView2.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to ListView2.Items.Count-2 do
   if strtoint(ListView2.Items[i].SubItems[1]) > strtoint(ListView2.Items[i+1].SubItems[1]) then
    begin
     cap := ListView2.Items[i].Caption ;
          fpth:=ListView2.Items[i].SubItems[0];
          razm:= ListView2.Items[i].SubItems[1] ;
                    mdd:= ListView2.Items[i].SubItems[2] ;
                                 in1:=ListView2.Items[i].ImageIndex;
                                       // crcc:= ListView1.Items[i].SubItems[3] ;
ListView2.Items[i].Caption:= ListView2.Items[i+1].Caption ;
    ListView2.Items[i].SubItems[0]:=ListView2.Items[i+1].SubItems[0] ;
          ListView2.Items[i].SubItems[1]:= ListView2.Items[i+1].SubItems[1] ;
                    ListView2.Items[i].SubItems[2]:= ListView2.Items[i+1].SubItems[2] ;
                        ListView2.Items[i].ImageIndex:=ListView2.Items[i+1].ImageIndex;
                         // ListView1.Items[i].SubItems[3]:= ListView1.Items[i+1].SubItems[3] ;
ListView2.Items[i+1].Caption:=cap;
      ListView2.Items[i+1].SubItems[0]:=fpth;
          ListView2.Items[i+1].SubItems[1]:= razm ;
                    ListView2.Items[i+1].SubItems[2]:= mdd ;
                    ListView2.Items[i+1].ImageIndex:=in1;
                         // ListView1.Items[i+1].SubItems[3]:= crcc ;
     b:= false;
    end;

 until b;
 ListView2.Items.EndUpdate;

end else
begin
if compix2=1 then
begin
compix2:=0;
ListView2.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to ListView2.Items.Count-2 do
   if strtoint(ListView2.Items[i].SubItems[1]) < strtoint(ListView2.Items[i+1].SubItems[1]) then
    begin
     cap := ListView2.Items[i+1].Caption ;
          fpth:=ListView2.Items[i+1].SubItems[0];
          razm:= ListView2.Items[i+1].SubItems[1] ;
                    mdd:= ListView2.Items[i+1].SubItems[2] ;
                    in2:=ListView2.Items[i+1].ImageIndex;
                                      //  crcc:= ListView2.Items[i+1].SubItems[3] ;
ListView2.Items[i+1].Caption:= ListView2.Items[i].Caption ;
    ListView2.Items[i+1].SubItems[0]:=ListView2.Items[i].SubItems[0] ;
          ListView2.Items[i+1].SubItems[1]:= ListView2.Items[i].SubItems[1] ;
                    ListView2.Items[i+1].SubItems[2]:= ListView2.Items[i].SubItems[2] ;
ListView2.Items[i+1].ImageIndex:=ListView2.Items[i].ImageIndex;
                          //ListView1.Items[i+1].SubItems[3]:= ListView1.Items[i].SubItems[3] ;
ListView2.Items[i].Caption:=cap;
      ListView2.Items[i].SubItems[0]:=fpth;
          ListView2.Items[i].SubItems[1]:= razm ;
                    ListView2.Items[i].SubItems[2]:= mdd ;
                    ListView2.Items[i].ImageIndex:=in2;
                        //  ListView2.Items[i].SubItems[3]:= crcc ;
     b:= false;
    end;

 until b;
 ListView2.Items.EndUpdate;

end;
end;
i1:=0;
   while (i1<=clicking.Count - 1)do
           begin
           j1:=0;
    while (j1<=ListView2.Items.Count - 1)do
           begin
           if ListView2.Items[j1].SubItems[1]=clicking.Strings[i1] then
                  begin
               ListView2.Items[j1].Selected:=true;
                  end else
                  begin
                  if clicking.IndexOf(ListView2.Items[j1].SubItems[1])<0 then
                                     begin
               ListView2.Items[j1].Selected:=false;
                                     end;
                  end;

            j1:=j1+1;
           end;
           i1:=i1+1;
           end;


end;
end;

end;

procedure TForm1.ListView2Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
ix,i: Integer;
begin

if ColumnToSort2 = 0 then
begin
ListView2.SortType:=stBoth;
if compix2=0 then
begin
Compare := CompareText(Item1.Caption,Item2.Caption);
end else
begin
if compix2=1 then
begin
 Compare := -CompareText(Item1.Caption,Item2.Caption);
end;                                                                     
end;

end
else begin
if ColumnToSort2 <> 2 then
begin
ListView2.SortType:=stBoth;
if compix2=0 then
begin
ix := ColumnToSort2 - 1;
Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
 end else
begin
if compix2=1 then
begin
ix := ColumnToSort2 - 1;
Compare := -CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
end;
end;
end else
begin
//Compare :=0;
end;
end;
end;

procedure TForm1.ListView3ColumnClick(Sender: TObject; Column: TListColumn);
var
i,j,in1:integer;
cap,fpth,razm,mdd,crcc:string;
b:boolean;
begin
ColumnToSort := Column.Index;
(Sender as TCustomListView).AlphaSort;
if ColumnToSort=0 then
begin
if ColumnToSort<>sostcol then
begin
compix:=1;
sostcol:=ColumnToSort;
end;
if compix=0 then
begin
compix:=1;
end else
begin
if compix=1 then
begin
compix:=0;
end;
end;
end else
begin
if ColumnToSort<>2 then
begin
if ColumnToSort<>sostcol then
begin
compix:=1;
sostcol:=ColumnToSort;
end;
if compix=0 then
begin
compix:=1;
end else
begin
if compix=1 then
begin
compix:=0;
end;
end;
end else
begin
if ColumnToSort<>sostcol then
begin
compix:=1;
sostcol:=ColumnToSort;
end;
if compix=0 then
begin
compix:=1;
ListView3.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to ListView3.Items.Count-2 do
   if strtoint(ListView3.Items[i].SubItems[1]) > strtoint(ListView3.Items[i+1].SubItems[1]) then
    begin
     cap := ListView3.Items[i].Caption ;
          fpth:=ListView3.Items[i].SubItems[0];
          razm:= ListView3.Items[i].SubItems[1] ;
                    mdd:= ListView3.Items[i].SubItems[2] ;
                                        crcc:= ListView3.Items[i].SubItems[3] ;
                                        in1:=ListView3.Items[i].ImageIndex;
ListView3.Items[i].Caption:= ListView3.Items[i+1].Caption ;
    ListView3.Items[i].SubItems[0]:=ListView3.Items[i+1].SubItems[0] ;
          ListView3.Items[i].SubItems[1]:= ListView3.Items[i+1].SubItems[1] ;
                    ListView3.Items[i].SubItems[2]:= ListView3.Items[i+1].SubItems[2] ;
                          ListView3.Items[i].SubItems[3]:= ListView3.Items[i+1].SubItems[3] ;
                          ListView3.Items[i].ImageIndex:=ListView3.Items[i+1].ImageIndex;
ListView3.Items[i+1].Caption:=cap;
      ListView3.Items[i+1].SubItems[0]:=fpth;
          ListView3.Items[i+1].SubItems[1]:= razm ;
                    ListView3.Items[i+1].SubItems[2]:= mdd ;
                          ListView3.Items[i+1].SubItems[3]:= crcc ;
                          ListView3.Items[i+1].ImageIndex:=in1;
     b:= false;
    end;

 until b;
 ListView3.Items.EndUpdate;

end else
begin
if compix=1 then
begin
compix:=0;
ListView3.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to ListView3.Items.Count-2 do
   if strtoint(ListView3.Items[i].SubItems[1]) < strtoint(ListView3.Items[i+1].SubItems[1]) then
    begin
     cap := ListView3.Items[i+1].Caption ;
          fpth:=ListView3.Items[i+1].SubItems[0];
          razm:= ListView3.Items[i+1].SubItems[1] ;
                    mdd:= ListView3.Items[i+1].SubItems[2] ;
                                        crcc:= ListView3.Items[i+1].SubItems[3] ;
                                        in1:=ListView3.Items[i+1].ImageIndex;
ListView3.Items[i+1].Caption:= ListView3.Items[i].Caption ;
    ListView3.Items[i+1].SubItems[0]:=ListView3.Items[i].SubItems[0] ;
          ListView3.Items[i+1].SubItems[1]:= ListView3.Items[i].SubItems[1] ;
                    ListView3.Items[i+1].SubItems[2]:= ListView3.Items[i].SubItems[2] ;
                          ListView3.Items[i+1].SubItems[3]:= ListView3.Items[i].SubItems[3] ;
                               ListView3.Items[i+1].ImageIndex:=ListView3.Items[i].ImageIndex;
ListView3.Items[i].Caption:=cap;
      ListView3.Items[i].SubItems[0]:=fpth;
          ListView3.Items[i].SubItems[1]:= razm ;
                    ListView3.Items[i].SubItems[2]:= mdd ;
                          ListView3.Items[i].SubItems[3]:= crcc ;
                              ListView3.Items[i].ImageIndex:=in1;
     b:= false;
    end;

 until b;
 ListView3.Items.EndUpdate;

end;
end;



end;
end;

end;


procedure TForm1.ListView3Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
ix,i: Integer;
begin

if ColumnToSort = 0 then
begin
ListView1.SortType:=stBoth;
if compix=0 then
begin
Compare := CompareText(Item1.Caption,Item2.Caption);
end else
begin
if compix=1 then
begin
 Compare := -CompareText(Item1.Caption,Item2.Caption);
end;
end;

end
else begin
if ColumnToSort <> 2 then
begin
ListView1.SortType:=stBoth;
if compix=0 then
begin
ix := ColumnToSort - 1;
Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
 end else
begin
if compix=1 then
begin
ix := ColumnToSort - 1;
Compare := -CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
end;
end;
end else
begin
//Compare :=0;
end;
end;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
Form3.Hide;
Form2.Hide;
form12.show;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
SpeedButton7.Click;
end;

procedure TForm1.N13Click(Sender: TObject);
var
i:integer;
begin
for i := 0 to ListView2.Items.Count - 1 do
begin
if ListView2.Items[i].Selected=true then
begin
winexec(Pchar('explorer /select, '+ListView2.Items[i].caption+ListView2.Items[i].SubItems[0])
,SW_Restore);
end;
end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
SpeedButton1.Click;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
SpeedButton2.Click;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
Form3.Hide;
Form12.Hide;
form2.show;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
SpeedButton5.Click;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
Form2.Hide;
Form12.Hide;
//ShowWindow(Form3.Handle,SW_NORMAL);
//setwindows
//BringWindowToTop(Form3.Handle);
Form3.Show;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
vidproc:='procterm';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
TrayIcon1.Animate:=false;

//DisableDebugPrivileges;
Application.Terminate;
end else
begin
Form10.SHOW;
end;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
SpeedButton6.Click;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
i,ii,key,j,a,lv,de,ce,ptp:integer;
mem,s,s2,d,c,siz:string;
bs:TStringList;
b,t:boolean;
Bitm:Tstream;
begin
vidproc:='sp1click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin

for ii := 0 to ListView2.Items.Count - 1 do
begin
if ListView2.Items[ii].Selected=true then
begin
bs:=TStringList.Create;
  mem:='';
 // s:=trim(ListView2.Items[ii]);
  {if (s<>'') then
begin
while s[Length(s)]<>'\' do
begin
mem:=s[Length(s)]+mem;
delete(s,Length(s),1);
end;
end;
 }


 with ListView2.Items[ii] do
 begin
 s:=trim(caption);
 mem:=trim(SubItems[0]);
 end;

if ((s+mem)<>ansilowercase(trim(paramstr(0)))) then
begin
//ptp:=rproc.IndexOf(clickind.Strings[ii]);
ptp:=rproc.IndexOf(ListView2.Items[ii].SubItems[1]);
if ptp>-1 then
begin
t:=false;
i:=0;
if ogran_list.IndexOf(dte.Strings[ptp])>-1  then
begin
  t:=true;
end;


    //put_p.Delete(ii);
    if t=false then
begin
     ImageList2.AddImage(ImageList1,ListView2.Items[ii].ImageIndex);
     siz:=sizm.Strings[ptp];
     d:=dte.Strings[ptp];
     c:=crc32.Strings[ptp];
     Form10.Hide;
    case Application.MessageBox(Pchar('Внимание! Вы имеете возможность выбрать пользователей, '+
'которым будет разрешен запуск программы "'+mem+'" . При нажатии кнопки "Нет", программа будет запрешена '+
'всем пользователям системы. Выбрать пользователей?'),
 'Правила запуска программ   ',
 MB_YESNOCANCEL or MB_ICONEXCLAMATION) of
 mrYes:begin
 with ListView1.Items.Add do
begin
ListView1.SortType:=stNone;
caption:=s;
  SubItems.Add(mem);
    SubItems.Add(siz);
    SubItems.Add(d);
    ogran_list.Add(d);
    SubItems.Add(c);
    s:=usr_fun+';';
s_users.Add(s);
    SubItems.Add(s);

        ImageList4.AddImage(ImageList2,ImageList2.Count-1);
        ImageList2.Delete(ImageList2.Count-1);
    ImageIndex:=ImageList4.Count-1;
end;

       end;
mrNo:begin
with ListView1.Items.Add do
begin
ListView1.SortType:=stNone;
caption:=s;
  SubItems.Add(mem);
    SubItems.Add(siz);
    SubItems.Add(d);
    ogran_list.Add(d);
    SubItems.Add(c);
    s:='Никому;';
s_users.Add(s);
    SubItems.Add(s);

        ImageList4.AddImage(ImageList2,ImageList2.Count-1);
        ImageList2.Delete(ImageList2.Count-1);
    ImageIndex:=ImageList4.Count-1;
end;

     end;
     mrCancel:begin
             ImageList2.Delete(ImageList2.Count-1);
       t:=true;
     end;
    end;
end;
//ShowMessage(ListView1.Items[ListView1.Items.count-1].SubItems[4]);
if t=false then
begin
ListView1.SmallImages:=ImageList4;

ListView1.SortType:=stBoth;
de:=dte.IndexOf(d);
  ce:=crc32.IndexOf(c);
 while (de>-1) and (ce>-1) do
   begin
rproc.Delete(de);
  sizm.Delete(de);
      dte.Delete(de);
         crc32.Delete(de);
            username.Delete(de);
              file_name.Delete(de);
                file_path.Delete(de);
 de:=dte.IndexOf(d);
  ce:=crc32.IndexOf(c);
   end;



 Bitm:=TFileStream.Create('icx.dbc',fmCreate);
  Bitm.WriteComponent(ImageList4);
  Bitm.Free;
s:='';
 key:=0;
while not((key>=32)) do
begin
Randomize;
key:=random(256);
end;
bs.Add(inttostr(ListView1.Items.Count+key*2)+chr(key));
for j := 0 to ListView1.Items.Count-1 do
begin
 key:=0;
while key<32 do
begin
Randomize;
key:=random(256);
end;
lv:=0;
while lv<=6 do
begin
if lv=0 then
 begin
mem:=ListView1.Items[j].Caption;
 end else
 begin
 if lv=6 then
begin
 mem:=inttostr(ListView1.Items[j].ImageIndex);
end else
begin
 mem:=ListView1.Items[j].SubItems[lv-1];
end;
 end;
i:=1;
lv:=lv+1;
b:=false;
while (b=false)and(i<=Length(mem)) do
begin
a:=ord(mem[i]);
if (a+key)<=255 then
begin
a:=a+key;

if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while (key+a<32)do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;

end else
begin
if (a+key)>255 then
begin
a:=a+key-255;
if a<32 then
begin
key:=0;
a:=ord(mem[i]);
//and(key=0)
while ((key+a)-255<32) do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;
end;
end;
i:=i+1
end;
if b=false then
begin
s:=s+inttostr(length(mem)*2)+chr(1)+s2;
s2:='';
end else
begin
s2:='';
s:='';
end;
end;
bs.Add(s+chr(key));
s:='';
end;
fstrm.Free;
bs.SaveToFile(extractfilepath(paramstr(0))+'base.dbc');
bs.Free;
fstrm:=TFileStream.Create(extractfilepath(paramstr(0))+'base.dbc', fmOpenRead and fmShareExclusive);
end;
end;
end;
end;
end;
end else
begin
Form10.SHOW;
end;

end;


procedure TForm1.SpeedButton2Click(Sender: TObject);
var
i:integer;
begin
vidproc:='sp2click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
i:=0;
while i<=ListView2.Items.Count - 1 do
begin
if ListView2.Items[i].Selected=true then
begin
if KillTask(rproc.Strings[rproc.indexof(ListView2.Items[i].SubItems[1])])=false then
begin
  Application.MessageBox('Не удалось снять процесс.', 'Dream Admin   ', MB_OK);
end else
begin
 // maspid[strtoint(rlist.Strings[i])]:=0;
 // maspid[strtoint(rproc.Strings[de])]:=0;
//rproc.Delete(i);
 // sizm.Delete(i);
     // dte.Delete(i);
       //  crc32.Delete(i);
          //  username.Delete(i);
           //   file_name.Delete(i);
              //  file_path.Delete(i);
end;
end;
i:=i+1;
end;

end else
begin
  Form10.Show;
end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
vidproc:='sp3click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
Timer1.Enabled:=true;
end else
begin
  Form10.Show;
end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
vidproc:='sp4click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
Timer1.Enabled:=false;
end else
begin
  Form10.Show;
end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var
i,j,key,a,lv,idi,s_u:integer;
mem,s,s2:string;
bs:TStringList;
b:boolean;
bitm:TStream;
begin
vidproc:='sp5click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
if ListView1.ItemIndex>=0 then
begin
if ListView1.Items.Count>0 then
begin
i:=0;
while i<=ListView1.Items.Count-1 do
begin
if ListView1.Items[i].Selected=True then
begin
idi:=ListView1.Items[i].ImageIndex;
ImageList4.Delete(idi);
s_u:=ogran_list.IndexOf(ListView1.Items[i].SubItems[2]);
ogran_list.Delete(s_u);
s_users.Delete(s_u);
ListView1.Items[i].Delete;

for j := 0 to ListView1.Items.Count - 1 do
begin
  if ListView1.Items[j].ImageIndex>idi then
begin
ListView1.Items[j].ImageIndex:=ListView1.Items[j].ImageIndex-1;
end;

end;
 i:=i-1;
end;
 i:=i+1;
end;
  Bitm:=TFileStream.Create('icx.dbc',fmCreate);
  Bitm.WriteComponent(ImageList4);
  Bitm.Free;
end;
 //ListView1.Items.BeginUpdate;
  //ListView1.Items.EndUpdate;



//ListView1.DeleteSelected;
  bs:=TStringList.Create;
key:=0;
while key<32 do
begin
Randomize;
key:=random(256);
end;
bs.Add(inttostr(ListView1.Items.Count+key*2)+chr(key));
for j := 0 to ListView1.Items.Count-1 do
begin
 key:=0;
while key<32 do
begin
Randomize;
key:=random(256);
end;
lv:=0;
while lv<=6 do
begin
if lv=0 then
 begin
mem:=ListView1.Items[j].Caption;
 end else
 begin
 if lv=6 then
begin
 mem:=inttostr(ListView1.Items[j].ImageIndex);
end else
begin
 mem:=ListView1.Items[j].SubItems[lv-1];
end;
 end;
i:=1;
lv:=lv+1;
b:=false;
while (b=false)and(i<=Length(mem)) do
begin
a:=ord(mem[i]);
if (a+key)<=255 then
begin
a:=a+key;

if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while (key+a<32)do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;

end else
begin
if (a+key)>255 then
begin
a:=a+key-255;
if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while ((key+a)-255<32)and(key=0) do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;
end;
end;
i:=i+1
end;
if b=false then
begin
s:=s+inttostr(length(mem)*2)+chr(1)+s2;
s2:='';
end else
begin
s2:='';
s:='';
end;
end;
bs.Add(s+chr(key));
s:='';
end;
fstrm.Free;
bs.SaveToFile(extractfilepath(paramstr(0))+'base.dbc');
bs.Free;
fstrm:=TFileStream.Create(extractfilepath(paramstr(0))+'base.dbc', fmOpenRead and fmShareExclusive);
end;
end else
begin
  Form10.Show;
end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var
ii,ptp,i,j,key,lv,a,de,ce:integer;
bs:TStringList;
mem,s,d,c,s2,sss:string;
b,t:boolean;
Bitm:Tstream;
begin
vidproc:='sp6click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin
///////////
for ii := 0 to ListView3.Items.Count - 1 do
begin
if ListView3.Items[ii].Selected=true then
begin
bs:=TStringList.Create;
  //mem:='';
 // s:=trim(ListView2.Items[ii]);
  {if (s<>'') then
begin
while s[Length(s)]<>'\' do
begin
mem:=s[Length(s)]+mem;
delete(s,Length(s),1);
end;
end;
 }
// with ListView3.Items[ii] do
 //begin
// s:=trim(caption);
// mem:=trim(SubItems[0]);
// end;

if ((trim(ListView3.Items[ii].Caption+ListView3.Items[ii].SubItems[0]))<>
ansilowercase(trim(paramstr(0)))) then
begin
//ptp:=rproc.IndexOf(clickind.Strings[ii]);
//ptp:=rproc.IndexOf(ListView3.Items[ii].SubItems[1]);
//if ptp>-1 then

t:=false;
i:=0;
if ogran_list.IndexOf(ListView3.Items[ii].SubItems[2])>-1  then
begin
  t:=true;
end;


    //put_p.Delete(ii);
    if t=false then
begin
ListView1.SmallImages:=ImageList4;
    case Application.MessageBox(Pchar('Внимание! Вы имеете возможность выбрать пользователей, '+
'которым будет разрешен запуск программы "'+ListView3.Items[ii].SubItems[0]+'" . При нажатии кнопки "Нет", программа будет запрешена '+
'всем пользователям системы. Выбрать пользователей?'),
 'Правила запуска программ   ',
 MB_YESNOCANCEL or MB_ICONEXCLAMATION) of
 mrYes:begin
 with ListView1.Items.Add do
begin
ListView1.SortType:=stNone;
caption:=ListView3.Items[ii].Caption ;
  SubItems.Add(ListView3.Items[ii].SubItems[0] );
    SubItems.Add(ListView3.Items[ii].SubItems[1]);
    SubItems.Add(ListView3.Items[ii].SubItems[2]);
    ogran_list.Add(ListView3.Items[ii].SubItems[2]);
    SubItems.Add(ListView3.Items[ii].SubItems[3]);
    sss:=usr_fun+';';
s_users.Add(sss);
    SubItems.Add(sss);
       ImageList4.AddImage(ImageList3,ListView3.Items[ii].ImageIndex);
        //ImageList4.AddImage(ImageList1,ListView3.Items[ii].ImageIndex);
    ImageIndex:=ImageList4.Count-1;
end;

       end;
mrNo:begin
with ListView1.Items.Add do
begin
ListView1.SortType:=stNone;
caption:=ListView3.Items[ii].Caption ;
  SubItems.Add(ListView3.Items[ii].SubItems[0] );
    SubItems.Add(ListView3.Items[ii].SubItems[1]);
    SubItems.Add(ListView3.Items[ii].SubItems[2]);
    ogran_list.Add(ListView3.Items[ii].SubItems[2]);
    SubItems.Add(ListView3.Items[ii].SubItems[3]);
    sss:='Никому;';
s_users.Add(sss);
    SubItems.Add(sss);
ImageList4.AddImage(ImageList3,ListView3.Items[ii].ImageIndex);    
    ImageIndex:=ImageList4.Count-1;
end;

     end;
     mrCancel:begin
       t:=true;
              end;
    end;
end;













 if t=false then
begin

//with ListView1.Items.Add do
//begin

    //ListView3.Items[ii].ImageIndex;
ListView1.SortType:=stBoth;
//d:=dte.Strings[ptp];
//c:=crc32.Strings[ptp];
de:=dte.IndexOf(ListView3.Items[ii].SubItems[2]);
ce:=crc32.IndexOf(ListView3.Items[ii].SubItems[3]);
 while (de>-1) and (ce>-1) do
   begin
//    ce:=crc32.IndexOf(c);
//put_p2.Delete(de);
//maspid[strtoint(rproc.Strings[ii])]:=0;
rproc.Delete(de);
  sizm.Delete(de);
      dte.Delete(de);
         crc32.Delete(de);
            username.Delete(de);
              file_name.Delete(de);
                file_path.Delete(de);
                //rproc.Delete(de);
 de:=dte.IndexOf(d);
  ce:=crc32.IndexOf(c);
   end;
//end;
  Bitm:=TFileStream.Create('icx.dbc',fmCreate);
  Bitm.WriteComponent(ImageList4);
  Bitm.Free;
s:='';
 key:=0;
while not((key>=32)) do
begin
Randomize;
key:=random(256);
end;
bs.Add(inttostr(ListView1.Items.Count+key*2)+chr(key));
for j := 0 to ListView1.Items.Count-1 do
begin
 key:=0;
while key<32 do
begin
Randomize;
key:=random(256);
end;
lv:=0;
while lv<=6 do
begin
if lv=0 then
 begin
mem:=ListView1.Items[j].Caption;
 end else
 begin
 if lv=6 then
begin
 mem:=inttostr(ListView1.Items[j].ImageIndex);
end else
begin
 mem:=ListView1.Items[j].SubItems[lv-1];
end;
 end;
i:=1;
lv:=lv+1;
b:=false;
while (b=false)and(i<=Length(mem)) do
begin
a:=ord(mem[i]);
if (a+key)<=255 then
begin
a:=a+key;

if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while (key+a<32)do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;

end else
begin
if (a+key)>255 then
begin
a:=a+key-255;
if a<32 then
begin
key:=0;
a:=ord(mem[i]);
//and(key=0)
while ((key+a)-255<32) do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;
end;
end;
i:=i+1
end;
if b=false then
begin
s:=s+inttostr(length(mem)*2)+chr(1)+s2;
s2:='';
end else
begin
s2:='';
s:='';
end;
end;
bs.Add(s+chr(key));
s:='';
end;
fstrm.Free;
bs.SaveToFile(extractfilepath(paramstr(0))+'base.dbc');
bs.Free;
fstrm:=TFileStream.Create(extractfilepath(paramstr(0))+'base.dbc', fmOpenRead and fmShareExclusive);
end;
end;
end;
end;


///////////
end else
begin
  Form10.Show;
end;

end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var
i,ii,key,j,a,lv,de,ce,ptp:integer;
mem,s,s2,d,c:string;
bs:TStringList;
b,t:boolean;
Bitm:Tstream;
begin
vidproc:='sp7click';
if (cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E')or (bproc=true) then
begin

for ii := 0 to ListView1.Items.Count - 1 do
begin
if ListView1.Items[ii].Selected=true then
begin
  mem:='';
 with ListView1.Items[ii] do
 begin
 s:=trim(caption);
 mem:=trim(SubItems[0]);
 end;
 t:=false;
Form10.Hide;
    case Application.MessageBox(Pchar('Внимание! Вы имеете возможность выбрать пользователей, '+
'которым будет разрешен запуск программы "'+mem+'" . При нажатии кнопки "Нет", программа будет запрешена '+
'всем пользователям системы. Выбрать пользователей?'),
 'Правила запуска программ   ',
 MB_YESNOCANCEL or MB_ICONEXCLAMATION) of
 mrYes:begin
    s:=usr_fun+';';
    ptp:=ogran_list.IndexOf(ListView1.Items[ii].SubItems[2]);
s_users.Strings[ptp]:=s;
    ListView1.Items[ii].SubItems[4]:=s;
       end;
mrNo:begin
    ptp:=ogran_list.IndexOf(ListView1.Items[ii].SubItems[2]);
    s:='Никому;';
s_users.Strings[ptp]:=s;
    ListView1.Items[ii].SubItems[4]:=s;
     end;
     mrCancel:begin
       t:=true;
     end;
    end;
   if t=false then
begin
d:=ListView1.Items[ii].SubItems[2];
c:=ListView1.Items[ii].SubItems[3];
de:=dte.IndexOf(d);
  ce:=crc32.IndexOf(c);
 while (de>-1) and (ce>-1) do
   begin
//    ce:=crc32.IndexOf(c);
//put_p2.Delete(de);
//maspid[strtoint(rproc.Strings[ii])]:=0;
rproc.Delete(de);
  sizm.Delete(de);
      dte.Delete(de);
         crc32.Delete(de);
            username.Delete(de);
              file_name.Delete(de);
                file_path.Delete(de);
                //rproc.Delete(de);
 de:=dte.IndexOf(d);
  ce:=crc32.IndexOf(c);
   end;
end;







end;
//ShowMessage(ListView1.Items[ListView1.Items.count-1].SubItems[4]);


end;
//////////
bs:=TStringList.Create;
s:='';
 key:=0;
while not((key>=32)) do
begin
Randomize;
key:=random(256);
end;
bs.Add(inttostr(ListView1.Items.Count+key*2)+chr(key));
for j := 0 to ListView1.Items.Count-1 do
begin
 key:=0;
while key<32 do
begin
Randomize;
key:=random(256);
end;
lv:=0;
while lv<=6 do
begin
if lv=0 then
 begin
mem:=ListView1.Items[j].Caption;
 end else
 begin
 if lv=6 then
begin
 mem:=inttostr(ListView1.Items[j].ImageIndex);
end else
begin
 mem:=ListView1.Items[j].SubItems[lv-1];
end;
 end;
i:=1;
lv:=lv+1;
b:=false;
while (b=false)and(i<=Length(mem)) do
begin
a:=ord(mem[i]);
if (a+key)<=255 then
begin
a:=a+key;

if a<32 then
begin
key:=0;
a:=ord(mem[i]);
while (key+a<32)do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;

end else
begin
if (a+key)>255 then
begin
a:=a+key-255;
if a<32 then
begin
key:=0;
a:=ord(mem[i]);
//and(key=0)
while ((key+a)-255<32) do
begin
Randomize;
key:=random(256);
end;
i:=0;
s2:='';
lv:=0;
b:=true;
end else
begin
s2:=s2+chr(a);
end;
end;
end;
i:=i+1
end;
if b=false then
begin
s:=s+inttostr(length(mem)*2)+chr(1)+s2;
s2:='';
end else
begin
s2:='';
s:='';
end;
end;
bs.Add(s+chr(key));
s:='';
end;
fstrm.Free;
bs.SaveToFile(extractfilepath(paramstr(0))+'base.dbc');
bs.Free;
fstrm:=TFileStream.Create(extractfilepath(paramstr(0))+'base.dbc', fmOpenRead and fmShareExclusive);

/////////
end else
begin
Form10.SHOW;
end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled:=true;

 if cnfpas.Strings[0]='yes' then
  begin

if GetModuleHandle(pchar(ExtractFilePath(paramstr(0))+'HideDLL.dll'))=0 then
begin
   LoadLibrary(pchar( ExtractFilePath(paramstr(0))+'HideDLL.dll'));
HideProcess(GetCurrentProcessId, false); //это спрячет текущий процесс
end;

  end;
update_m;
end;

procedure TForm1.snif;
var
d,c,i,iitem:integer;
begin
//i:=0;
//while I<=pidp.Count-1  do
//begin

end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
ShowWindow(Form1.Handle,SW_SHOW);
ShowWindow(Application.MainFormHandle, SW_SHOW);
SetForegroundWindow(form1.Handle);
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
ShowWindow(Form1.Handle,SW_HIDE);
ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.TreeView1Click(Sender: TObject);
begin
if TreeView1.Selected<>nil then
begin
if TreeView1.Selected.Text='Настройки' then
begin
Frame61.Visible:=true;
Frame81.Visible:=false;
Frame51.Visible:=false;
Frame71.Visible:=false;
Label2.Caption:='Общие настройки';
end else
begin
if TreeView1.Selected.Text='Сеть' then
begin
Frame61.Visible:=false;
Frame81.Visible:=false;
Frame71.Visible:=false;
Frame51.Visible:=true;
Label2.Caption:='Настройки сети';
end else
begin
if TreeView1.Selected.Text='Защита' then
begin
Frame71.Visible:=true;
Frame81.Visible:=false;
Frame61.Visible:=false;
Frame51.Visible:=false;
Label2.Caption:='Защита Dr.Admin';
end else
begin
if TreeView1.Selected.Text='Аутентификация' then
begin
Frame81.Visible:=true;
Frame71.Visible:=false;
Frame61.Visible:=false;
Frame51.Visible:=false;
Label2.Caption:='Защита паролем';
if cnfpas.Strings[1]='D41D8CD98F00B204E9800998ECF8427E' then
begin
 Frame81.Edit1.Enabled:=false;
  Frame81.Edit2.Enabled:=true;
  Frame81.Edit3.Enabled:=true;
end else
begin
  Frame81.Edit1.Enabled:=true;
  Frame81.Edit2.Enabled:=false;
  Frame81.Edit3.Enabled:=false;
end;
//reg.CloseKey;
//Frame61.CheckBox2.Checked:=false;
//reg.CloseKey;
//Frame61.CheckBox2.Checked:=true;
  end;



//if Frame71.CheckBox1.Checked=true then
//begin
//reg.WriteString('Dr.Admin', 'yes');
//Frame71.Label1.Caption:='';
  // LoadLibrary(pchar(ExtractFileDir(Application.ExeName)+'\'+'HideDLL.dll'));
//HideProcess(GetCurrentProcessId, true); //это спрячет текущий процесс
//end else
//begin
//reg.WriteString('Dr.Admin', 'none');
//Frame71.Label1.Caption:='Требуется перезапустить Dream Admin';
//KillDll();
//end;
//reg.Free;




end;
end;
end;
//ShowMessage(TreeView1.Selected.Text);
end;

end;

end.

