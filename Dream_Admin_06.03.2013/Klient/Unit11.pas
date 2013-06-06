unit Unit11;

interface

uses
  Windows,Classes,SysUtils,TlHelp32;
  //, JwaAclApi, JwaAccCtrl
  type
  NTStatus = cardinal;
  PPListStruct = ^PListStruct;
 PListStruct  = ^TListStruct;
 TListStruct  = record
  pNext: PListStruct;
  pData: pointer;
  ItemCount: dword;
 end;

   PProcessRecord = ^TProcessRecord;
  TProcessRecord = packed record
    Visible: boolean;
    SignalState: dword;
    Present: boolean;
    ProcessId: dword;
    ParrentPID: dword;
    pEPROCESS: dword;
    ProcessName: array [0..255] of Char;
  end;
  PSYSTEM_HANDLE_INFORMATION = ^SYSTEM_HANDLE_INFORMATION;
SYSTEM_HANDLE_INFORMATION = packed record
   ProcessId: dword;
   ObjectTypeNumber: byte;
   Flags: byte;
   Handle: word;
   pObject: pointer;
   GrantedAccess: dword;
   end;

PSYSTEM_HANDLE_INFORMATION_EX = ^SYSTEM_HANDLE_INFORMATION_EX;
SYSTEM_HANDLE_INFORMATION_EX = packed record
   NumberOfHandles: dword;
   Information: array [0..0] of SYSTEM_HANDLE_INFORMATION;
   end;
   PClientID = ^TClientID;
TClientID = packed record
 UniqueProcess:cardinal;
 UniqueThread:cardinal;
end;

PUnicodeString = ^TUnicodeString;
  TUnicodeString = packed record
    Length: Word;
    MaximumLength: Word;
    Buffer: PWideChar;
end;

PVM_COUNTERS = ^VM_COUNTERS;
VM_COUNTERS = packed record
   PeakVirtualSize,
   VirtualSize,
   PageFaultCount,
   PeakWorkingSetSize,
   WorkingSetSize,
   QuotaPeakPagedPoolUsage,
   QuotaPagedPoolUsage,
   QuotaPeakNonPagedPoolUsage,
   QuotaNonPagedPoolUsage,
   PagefileUsage,
   PeakPagefileUsage: dword;
  end;

PIO_COUNTERS = ^IO_COUNTERS;
IO_COUNTERS = packed record
   ReadOperationCount,
   WriteOperationCount,
   OtherOperationCount,
   ReadTransferCount,
   WriteTransferCount,
   OtherTransferCount: LARGE_INTEGER;
  end;


PSYSTEM_THREADS = ^SYSTEM_THREADS;
SYSTEM_THREADS = packed record
  KernelTime,
  UserTime,
  CreateTime: LARGE_INTEGER;
  WaitTime: dword;
  StartAddress: pointer;
  ClientId: TClientId;
  Priority,
  BasePriority,
  ContextSwitchCount: dword;
  State: dword;
  WaitReason: dword;
 end;

 PPROCESS_BASIC_INFORMATION = ^PROCESS_BASIC_INFORMATION;
PROCESS_BASIC_INFORMATION = packed record
   ExitStatus: BOOL;
   PebBaseAddress: pointer;
   AffinityMask: PULONG;
   BasePriority: dword;
   UniqueProcessId: ULONG;
   InheritedFromUniqueProcessId: ULONG;
  end;

  PSYSTEM_PROCESSES = ^SYSTEM_PROCESSES;
SYSTEM_PROCESSES = packed record
   NextEntryDelta,
   ThreadCount: dword;
   Reserved1 : array [0..5] of dword;
   CreateTime,
   UserTime,
   KernelTime: LARGE_INTEGER;
   ProcessName: TUnicodeString;
   BasePriority: dword;
   ProcessId,
   InheritedFromProcessId,
   HandleCount: dword;
   Reserved2: array [0..1] of dword;
   VmCounters: VM_COUNTERS;
   IoCounters: IO_COUNTERS; // Windows 2000 only
   Threads: array [0..0] of SYSTEM_THREADS;
  end;

  const// SYSTEM_INFORMATION_CLASS
  SystemHandleInformation              	=	16;
  ProcessBasicInformation = 0;
  CONST  //Статус константы

  THREAD_SUSPEND_RESUME = $0002;
  STATUS_SUCCESS              = NTStatus($00000000);
  STATUS_ACCESS_DENIED        = NTStatus($C0000022);
  STATUS_INFO_LENGTH_MISMATCH = NTStatus($C0000004);
  SEVERITY_ERROR              = NTStatus($C0000000);
  Function ZwQuerySystemInformation(ASystemInformationClass: dword;
                                  ASystemInformation: Pointer;
                                  ASystemInformationLength: dword;
                                  AReturnLength:PCardinal): NTStatus;
                                  stdcall;external 'ntdll.dll';
  Function ZwQueryInformationProcess(
                                ProcessHandle:THANDLE;
                                ProcessInformationClass:DWORD;
                                ProcessInformation:pointer;
                                ProcessInformationLength:ULONG;
                                ReturnLength: PULONG):NTStatus;stdcall;
                                external 'ntdll.dll';
function ProtectObject(Handle : THandle) : Boolean;                                
function SetProcessPriority( Priority : Integer ) : Integer;
function GetProcessAccount(PID : integer) : string;
function GetProcessAccount2(PID : integer) : string;
function GetProcessOwner(dwProcessID: DWORD; lpBuffer: PChar; nBufferLength: DWORD): boolean;
function EnableDebugPrivilege():Boolean;
//function EnableDACL(ProcId:Cardinal):Boolean;
procedure DisableDebugPrivileges;
procedure GetHandlesProcessList(var nproc,rproc,pidp:TStringList);
function GetMyParentID(var ParentID: string): DWord;
function GetNameByPid(Pid: dword): string;
procedure SetSuspendState (PID : DWORD; Resume : Boolean);
function OpenThread (dwDesiredAccess : DWORD; bInheritHandle : BOOL; dwThreadId : DWORD) : THandle; stdcall; external 'kernel32.dll';
var
Info_: PSYSTEM_HANDLE_INFORMATION_EX;
implementation

uses Unit1;





function ProtectObject(Handle : THandle) : Boolean;
var SD : TSecurityDescriptor;
ACL : array[0..1023] of Byte;
begin
  Result := False;
  if not InitializeSecurityDescriptor(@SD, SECURITY_DESCRIPTOR_REVISION) then
  begin
    Exit;
  end;
  FillChar(ACL, SizeOf(ACL), 0);
  if not InitializeAcl(_ACL((@ACL)^), SizeOf(ACL), 2) then
  begin
    Exit;
  end;
  if not SetSecurityDescriptorDacl(@SD, True, @ACL, False) then
  begin
    Exit;
  end;
  if not SetKernelObjectSecurity(Handle, DACL_SECURITY_INFORMATION, @SD) then
  begin
    Exit;
  end;
  Result := True;
end;



 procedure SetDebugPrivilege (Enabled : Boolean);
var hToken : THandle;
   TokenPriv, PrevTokenPriv : TOKEN_PRIVILEGES;
   Tmp : Cardinal;
begin
 OpenProcessToken (GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken);
 LookupPrivilegeValue (nil, 'SeDebugPrivilege', TokenPriv.Privileges[0].Luid);
 TokenPriv.PrivilegeCount := 1;
 TokenPriv.Privileges[0].Attributes := 0;
 if Enabled then TokenPriv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
 Tmp := 0;
 PrevTokenPriv := TokenPriv;
 AdjustTokenPrivileges (hToken, False, TokenPriv, SizeOf(PrevTokenPriv), PrevTokenPriv, Tmp);
 CloseHandle (hToken);
end;

type
 PPSID = ^PSID;
 PPACL = ^PACL;

function GetSecurityInfo(handle: THandle; ObjectType: DWORD;
 SecurityInfo: DWORD; ppsidOwner, ppsidGroup: PPSID;
 ppDacl, ppSacl: PPACL; var ppSecurityDescriptor: PSecurityDescriptor): DWORD; stdcall; external 'advapi32.dll';

//const SE_KERNEL_OBJECT = 6;

function GetProcessAccount(PID : integer) : string;
var
 h : THandle;
 sd : PSecurityDescriptor;
 snu : SID_NAME_USE;
 DomainName, UserName : PChar;
 UserNameSize, DomainNameSize : cardinal;
 sid : PSid;
begin
 Result := '';
 SetDebugPrivilege (True);
 h := OpenProcess(PROCESS_ALL_ACCESS, True, PID);
// SE_OBJECT_TYPE
 if GetSecurityInfo (h, 6, OWNER_SECURITY_INFORMATION, @sid, nil, nil, nil, sd) = ERROR_SUCCESS then
 begin
   UserNameSize := 1024; GetMem (UserName, UserNameSize);
   DomainNameSize := 1024; GetMem (DomainName, DomainNameSize);
   if LookupAccountSid(nil, sid, UserName, UserNameSize, DomainName, DomainNameSize, snu) then Result := UserName;
   LocalFree (Integer(sd));
   FreeMem (UserName);
   FreeMem (DomainName);
 end;
end;

function ProcessIdToSessionId(dwProcessId: DWORD; var pSessionId: DWORD): BOOL; stdcall; external 'kernel32.dll';
function WTSQuerySessionInformationA(hServer: THandle; SessionId: DWORD;
  WTSInfoClass: DWORD; var ppBuffer: Pointer; var pBytesReturned: DWORD): BOOL; stdcall; external 'wtsapi32.dll';

  procedure WTSFreeMemory(pMemory: Pointer); stdcall; external 'wtsapi32.dll';
const
   WTS_CURRENT_SERVER_HANDLE = THandle(0);
   WTSUserName = 5;

function GetProcessAccount2(PID : integer) : string;
var
  SesID, Size : DWORD;
  Buf : Pointer;
begin
  Result := '';
  if not ProcessIdToSessionId(PID, SesID) then Exit;
  if not WTSQuerySessionInformationA(WTS_CURRENT_SERVER_HANDLE,
                                     SesId, WTSUserName,
                                     Buf, Size) then Exit;
  Result := PChar(Buf);
  WTSFreeMemory (Buf);
end;

{
function EnableDACL(ProcId:Cardinal):Boolean;
var
  hProcess: Cardinal;
begin
  // Открываем процесс. Запрашиваем доступ на изменение DACL
  hProcess:=OpenProcess(WRITE_DAC,false,ProcId);
  if hProcess <> 0 then begin

    // Устанавливаем указатель на DACL равным nil - объект незащищен
    SetSecurityInfo(hProcess,SE_KERNEL_OBJECT,DACL_SECURITY_INFORMATION,nil,nil,nil,nil);
//GetCurrentUserAndDomain(hProcess,User,chuser,Domain,chDomain) ;

    CloseHandle(hProcess);
    result:=true;
  end
  else
  begin
   // RaiseLastOSError;
    result:=false;
  end;
end;  }













function EnableDebugPrivilege():Boolean;
var
 hToken: dword;
 SeDebugNameValue: Int64;
 tkp: TOKEN_PRIVILEGES;
 ReturnLength: dword;
begin
 Result:=false;
 //Добавляем привилегию SeDebugPrivilege
 //Получаем токен нашего процесса
 OpenProcessToken(INVALID_HANDLE_VALUE, TOKEN_ADJUST_PRIVILEGES
                  or TOKEN_QUERY, hToken);
 //Получаем LUID привилегии
 if not LookupPrivilegeValue(nil, 'SeDebugPrivilege', SeDebugNameValue) then
  begin
   CloseHandle(hToken);
   exit;
  end;
 tkp.PrivilegeCount := 1;
 tkp.Privileges[0].Luid := SeDebugNameValue;
 tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
 //Добавляем привилегию к процессу
 AdjustTokenPrivileges(hToken, false, tkp, SizeOf(TOKEN_PRIVILEGES),
                       tkp, ReturnLength);
 if GetLastError() <> ERROR_SUCCESS then exit;
 Result:=true;
end;

 {procedure EnableDebugPrivileges; // Получить привилегии отладчика
var
  hToken: THandle;
  tp: TTokenPrivileges;
  DebugNameValue: Int64;
  ret: Cardinal;
begin
  OpenProcessToken(GetCurrentProcess,TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,hToken); // Получаем маркер доступа текущего процесса
  // Получаем значение отладочных привилегий
  LookupPrivilegeValue(nil,'SeDebugPrivilege',DebugNameValue);
  tp.PrivilegeCount := 1; // Включаем отладочные привилегии
  tp.Privileges[0].Luid := DebugNameValue;
  tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  // Применяем обновленные привилегии
  AdjustTokenPrivileges(hToken,False,tp,sizeof(tp),nil,ret);
end; }
procedure DisableDebugPrivileges; // Отключить привилегии отладчика
var
  hToken: THandle;
  tp: TTokenPrivileges;
  DebugNameValue: Int64;
  ret: Cardinal;
begin
  OpenProcessToken(GetCurrentProcess,TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,hToken);
  LookupPrivilegeValue(nil,'SeDebugPrivilege',DebugNameValue);
  tp.PrivilegeCount := 1;
  tp.Privileges[0].Luid := DebugNameValue;
  tp.Privileges[0].Attributes := 0; // Отключаем отладочные привилегии
  AdjustTokenPrivileges(hToken,False,tp,sizeof(tp),nil,ret);
end;



Function GetInfoTable(ATableType:dword):Pointer;
var
 mSize: dword;
 mPtr: pointer;
 St: NTStatus;
begin
 Result := nil;
 mSize := $256000;
 repeat
   mPtr := VirtualAlloc(nil, mSize, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE);
   if mPtr = nil then Exit;
   St := ZwQuerySystemInformation(ATableType, mPtr, mSize, nil);
   if St = STATUS_INFO_LENGTH_MISMATCH then
     begin //надо больше памяти
        VirtualFree(mPtr, 0, MEM_RELEASE);
        mSize := mSize * 2;
      end;
 until St <> STATUS_INFO_LENGTH_MISMATCH;
 if St = STATUS_SUCCESS
   then Result := mPtr
//   else VirtualFree(mPtr, 0, MEM_RELEASE);
end;
function GetNameByPid(Pid: dword): string;
var
 hProcess, Bytes: dword;
 Info: PROCESS_BASIC_INFORMATION;
 ProcessParametres: pointer;
 ImagePath: TUnicodeString;
 ImgPath: array[0..MAX_PATH] of WideChar;
begin
 Result := '';
 ZeroMemory(@ImgPath, MAX_PATH * SizeOf(WideChar));
 hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, Pid);
 if ZwQueryInformationProcess(hProcess, ProcessBasicInformation, @Info,
                              SizeOf(PROCESS_BASIC_INFORMATION), nil) = STATUS_SUCCESS then
  begin
   if ReadProcessMemory(hProcess, pointer(dword(Info.PebBaseAddress) + $10),
                        @ProcessParametres, SizeOf(pointer), Bytes) and
      ReadProcessMemory(hProcess, pointer(dword(ProcessParametres) + $38),
                        @ImagePath, SizeOf(TUnicodeString), Bytes)  and
      ReadProcessMemory(hProcess, ImagePath.Buffer, @ImgPath,
                        ImagePath.Length, Bytes) then
        begin
          Result := ExtractFilePath(WideCharToString(ImgPath))+ExtractFileName(WideCharToString(ImgPath));
        end;
   end;
 CloseHandle(hProcess);
end;

procedure SetSuspendState (PID : DWORD; Resume : Boolean);
var
  hSnap, hThread : THandle;
  te32 : THREADENTRY32;
begin
  hSnap := CreateToolhelp32Snapshot (TH32CS_SNAPTHREAD, 0);
  te32.dwSize := SizeOf(te32);
  if Thread32First (hSnap, te32) then
  repeat
    if te32.th32OwnerProcessID = PID then
    begin
      hThread := OpenThread (THREAD_SUSPEND_RESUME, False, te32.th32ThreadID);
      if Resume then ResumeThread (hThread)
      else SuspendThread (hThread);       
      CloseHandle (hThread);
    end;
  until not Thread32Next (hSnap, te32);
  CloseHandle (hSnap);
end;

function GetMyParentID(var ParentID: string): DWord;
var
 ProcEntry: TProcessEntry32;
 hSnapshot: THandle;
 CurrID: string;
 _OK: Boolean;
begin
 hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
 if hSnapshot <> INVALID_HANDLE_VALUE then
  try
   ProcEntry.dwSize := SizeOf(ProcEntry);
   _OK := Process32First(hSnapshot, ProcEntry);
   if _OK then
    begin
     CurrID := ParentID;
     SetLastError(ERROR_SUCCESS);
     while _OK do
      if ProcEntry.th32ProcessID = strtoint(CurrID) then
       begin
        ParentID := inttostr(ProcEntry.th32ParentProcessID);
        Break;
       end
      else _OK := Process32Next(hSnapshot, ProcEntry);
    end;
   Result := GetLastError;
  finally
   CloseHandle(hSnapshot);
  end
 else Result := GetLastError;
end;
 procedure PrintError;
var errcode: Cardinal;
begin
  errcode := GetLastError; // Получаем код последней ошибки
  MessageBox(0,PChar('Код:' + IntToStr(errcode) + ' - ' +
              SysErrorMessage(errcode)),
             'Ошибка!',MB_ICONERROR + MB_SETFOREGROUND);
end;

function GetProcessOwner(dwProcessID: DWORD; lpBuffer: PChar; nBufferLength: DWORD): boolean;
type
PTOKEN_USER = ^TOKEN_USER;
TOKEN_USER = record 
User: SID_AND_ATTRIBUTES; 
end; 

var 
hProcess, 
hToken : THANDLE; 
tinfo : array[0..255]of byte; 
dwTmp: DWORD; 
snu: SID_NAME_USE; 
lpDomain: array[0..127]of char; 
cbUser,
cbDomain: DWORD; 
begin 
result:= false;
hProcess:= OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ or OWNER_SECURITY_INFORMATION, FALSE, dwProcessID); 
if (hProcess = 0) then exit; 

hToken:= 0;
if OpenProcessToken(hProcess, TOKEN_QUERY or TOKEN_ADJUST_PRIVILEGES, hToken) then
try 
if GetTokenInformation(hToken, TokenUser, @tinfo[0], sizeof(tinfo), dwTmp) then 
if LookupAccountSid(nil, PTOKEN_USER(@tinfo[0]).User.Sid, lpBuffer, cbUser, lpDomain, cbDomain, snu) then 
result:= (cbUser <= nBufferLength); 
finally 
CloseHandle(hToken); 
end;
PrintError;
CloseHandle(hProcess);
end;

const
  ppIdle : Integer = -1;
  ppNormal : Integer = 0;
  ppHigh : Integer = 1;
  ppRealTime : Integer = 2;

function SetProcessPriority( Priority : Integer ) : Integer;
var
  H : THandle;
begin
  Result := ppNormal;
  H := GetCurrentProcess();
  if ( Priority = ppIdle ) then
    SetPriorityClass( H, IDLE_PRIORITY_CLASS )
  else
  if ( Priority = ppNormal ) then
    SetPriorityClass( H, NORMAL_PRIORITY_CLASS )
  else
  if ( Priority = ppHigh ) then
    SetPriorityClass( H, HIGH_PRIORITY_CLASS )
  else
  if ( Priority = ppRealTime ) then
    SetPriorityClass( H, REALTIME_PRIORITY_CLASS );
  case GetPriorityClass( H ) of
    IDLE_PRIORITY_CLASS : Result := ppIdle;
    NORMAL_PRIORITY_CLASS : Result := ppNormal;
    HIGH_PRIORITY_CLASS : Result := ppHigh;
    REALTIME_PRIORITY_CLASS : Result := ppRealTime;
  end;
end;



procedure GetHandlesProcessList(var nproc,rproc,pidp:TStringList);
var
 Info: PSYSTEM_HANDLE_INFORMATION_EX;
 r: dword;
 OldPid: dword;
 str,pda:string;
 i,g1,g2:integer;
begin
//lpro.Sorted:=true;
  OldPid := 0;
  Info := GetInfoTable(SystemHandleInformation);
  if Info = nil then Exit;
  r:=0;
 //if (Info<>Info_)or (Info^.NumberOfHandles<>colprocunir1) then
//begin
  // nproc.Clear;
  // rlist.Clear;
  i:=0;
  while (r<=Info^.NumberOfHandles)do
begin

    if Info^.Information[r].ProcessId <> OldPid then
     begin
       OldPid := Info^.Information[r].ProcessId;
       //integer(OldPid)
      // if (maspid[integer(OldPid)]=0)and (integer(OldPid)>0) then
        //                                        begin
         //maspid[integer(OldPid)]:=integer(OldPid);
         i:=i+1;
         //rproc.Count:=i;
          if rproc.Count<i then
                   begin
                 rproc.Add('');
                 nproc.Add('');
                   end;
        if rproc.Strings[i-1]<>inttostr(OldPid) then
              begin
              str:=trim(GetNameByPid(OldPid));
       pda:=trim(ParamStr(0));
           if (str<>'')and(str<>pda) then
           begin
           //rproc.Duplicates:=dupIgnore;
            rproc.Insert(i-1,inttostr(OldPid));
           nproc.Insert(i-1,str);
           //SetSuspendState (OldPid, false);
            if rproc.Strings[i]='' then
            begin
            rproc.Delete(i);
            nproc.Delete(i);
           // i:=i-1;
            end;
            // if pidp.IndexOf(inttostr(oldpid))<0 then
         // begin
        //  pidp.add(inttostr(oldpid));
       // if (OldPid<>GetCurrentProcessId) and (OldPid<>936) then
       //   begin
        //SetSuspendState (OldPid, true);
        //  end;
         // end;
         // rproc.Strings[i-1]:=inttostr(OldPid);
          //nproc.Strings[i-1]:=str;

         // SetSuspendState (OldPid, False);
           end else
           begin
             i:=i-1;
           end;

              end;
       {

        begin
        nproc.Add(str);
        rproc.Add(inttostr(oldpid));
       if pidp.IndexOf(inttostr(oldpid))<0 then
          begin
        SetSuspendState (OldPid, False);
          end;

        end;    }
                                               //  end;

    end;
        r:=r+1;
end;
// Info_:=Info;
 //colprocunir1:=Info^.NumberOfHandles;
//end;
  while rproc.Count>i do
      begin
     rproc.Delete(i);
          nproc.Delete(i);
      end;
      //colprocunir1:=Info^.NumberOfHandles;
 VirtualFree(Info, 0, MEM_RELEASE);
end;

end.
