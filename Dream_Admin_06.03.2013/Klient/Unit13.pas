unit Unit13;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActiveX;
 const
  CLSID_DsObjectPicker: TGUID = (
    D1:$17d6ccd8; D2:$3b7b; D3:$11d2; D4:($b9,$e0,$00,$c0,$4f,$d8,$db,$f7));

  IID_IDsObjectPicker: TGUID = (
    D1:$0c87e64e; D2:$3b7a; D3:$11d2; D4:($b9,$e0,$00,$c0,$4f,$d8,$db,$f7));

  ANYSIZE_ARRAY = 1;

  CFSTR_DSOP_DS_SELECTION_LIST = 'CFSTR_DSOP_DS_SELECTION_LIST';

const
  DSOP_SCOPE_TYPE_TARGET_COMPUTER              = $00000033;
  DSOP_SCOPE_TYPE_USER_ENTERED_DOWNLEVEL_SCOPE = $00000200;

  DSOP_FILTER_USERS                            = $00000003;

  DSOP_DOWNLEVEL_FILTER_USERS                  = DWORD($80000001);

  DSOP_FLAG_SKIP_TARGET_COMPUTER_DC_CHECK      = $00000083;
 function usr_fun():String;
type
  LPLPWSTR = ^PWideChar;

  TDsOpUpLevelFilterFlags = record
    flBothModes: ULONG;
    flMixedModeOnly: ULONG;
    flNativeModeOnly: ULONG;
  end;

  TDsOpFilterFlags = record
    Uplevel: TDsOpUpLevelFilterFlags;
    flDownlevel: ULONG;
  end;

  PDsOpScopeInitInfo = ^TDsOpScopeInitInfo;
  TDsOpScopeInitInfo = record
    cbSize: ULONG;
    flType: ULONG;
    flScope: ULONG;
    FilterFlags: TDsOpFilterFlags;
    pwzDcName: PWideChar;
    pwzADsPath: PWideChar;
    hr: HRESULT;
  end;

  TDsOpInitInfo = record
    cbSize: ULONG;
    pwzTargetComputer: PWideChar;
    cDsScopeInfos: ULONG;
    aDsScopeInfos: PDsOpScopeInitInfo;
    flOptions: ULONG;
    cAttributesToFetch: ULONG;
    apwzAttributeNames: LPLPWSTR;
  end;

  TDsSelection = record
    pwzName: PWideChar;
    pwzADsPath: PWideChar;
    pwzClass: PWideChar;
    pwzUPN: PWideChar;
    pvarFetchedAttributes: POleVariant;
    flScopeType: ULONG;
  end;

  PDSSelectionList = ^TDsSelectionList;
  TDsSelectionList = record
    cItems: ULONG;
    cFetchedAttributes: ULONG;
    aDsSelection: array [0..ANYSIZE_ARRAY - 1] of TDsSelection;
  end;

  IDsObjectPicker = interface (IUnknown)
  ['{0c87e64e-3b7a-11d2-b9e0-00c04fd8dbf7}']

    function Initialize(const pInitInfo: TDsOpInitInfo): HRESULT; stdcall;
    function InvokeDialog(hwndParent: HWND; out ppdoSelections: IDataObject): HRESULT; stdcall;
  end;
var
  Text_us: TStringList;
implementation

uses Unit1;
 function InitObjectPicker(Picker: IDsObjectPicker): HRESULT;
var
  ScopeInit: array [0..0] of TDSOPScopeInitInfo; // ибъект который указывает что будем выбирать
  InitInfo: TDSOPInitInfo; // информация об инициализации
begin
  if nil = Picker then
    Result := E_INVALIDARG
  else
  begin
    ZeroMemory(@ScopeInit, SizeOf(ScopeInit)); //заполняем нулями
    ScopeInit[0].cbSize := SizeOf(TDSOPScopeInitInfo); // заполняем структуру TDSOPScopeInitInfo
    ScopeInit[0].flType := DSOP_SCOPE_TYPE_TARGET_COMPUTER;
    ScopeInit[0].flScope := DSOP_SCOPE_TYPE_USER_ENTERED_DOWNLEVEL_SCOPE;
    ScopeInit[0].FilterFlags.Uplevel.flBothModes := DSOP_FILTER_USERS;
    ScopeInit[0].FilterFlags.flDownlevel := DSOP_DOWNLEVEL_FILTER_USERS;

    ZeroMemory(@InitInfo, SizeOf(InitInfo));// заполняем структуру TDSOPInitInfo
    InitInfo.cbSize := SizeOf(InitInfo);
    InitInfo.cDsScopeInfos := SizeOf(ScopeInit) div SizeOf(TDSOPScopeInitInfo); 
    InitInfo.aDsScopeInfos := @ScopeInit;
    InitInfo.flOptions := DSOP_FLAG_SKIP_TARGET_COMPUTER_DC_CHECK;
// инициализируем объект выбора
    Result := Picker.Initialize(InitInfo);
  end;
end; 

function ProcessSelectedObjects(DatObj: IDataObject): HRESULT;
var
  StgMed: TStgMedium; //объект хранения данных
  FmtEtc: TFormatEtc;  //формат ыввода данных
  SelLst: PDSSelectionList;  //выбранные объекты
  Index: ULONG;
   str,pat,upn,nm:string;
begin 
//проверка на "дурака" 
 if nil = DatObj then 
    Result := E_INVALIDARG
  else 
  begin
    with FmtEtc do 
    begin 
//регистрируем формат вывода данных
      cfFormat := RegisterClipboardFormat(CFSTR_DSOP_DS_SELECTION_LIST); 
      ptd      := nil; 
      dwAspect := DVASPECT_CONTENT;
      lindex   := -1; 
      tymed    := TYMED_HGLOBAL;
    end; 
    Result := DatObj.GetData(FmtEtc, StgMed);
    if Succeeded(Result) then
    begin 
//получаем результат вызора в удобоваримом формате
      SelLst := PDsSelectionList(GlobalLock(StgMed.hGlobal));
// и если не nil обрабатываем его
      if SelLst <> nil then
      try
        Text_us.Clear;
        for Index := 0 to SelLst.cItems - 1 do
        begin
         // Text_us:= Text_us + //Format(
           // 'Object : %u'#13#10 +
            //'  Name : %s'#13#10 +
           // '  Class: %s'#13#10 +
            //'  Path : %s'#13#10 +
            //'  UPN  : %s'#13#10, [
            //Index,
            nm:=WideCharToString(SelLst.aDsSelection[Index].pwzName);
            //WideCharToString(SelLst.aDsSelection[Index].pwzClass),
            pat:=trim(WideCharToString(SelLst.aDsSelection[Index].pwzADsPath));
            upn:=trim(WideCharToString(SelLst.aDsSelection[Index].pwzUPN));
            str:='';
            if upn='' then
              begin
               if (nm[1] in ['0'..'9']) or (nm[1] in ['a'..'z'])
               or (nm[1] in ['A'..'Z']) then
                   begin
                   Text_us.Add(nm);
                   end else
                   begin
                while (pat[Length(pat)]<>'/')and(pos('/',pat)>0) do
                   begin
                   str:=pat[Length(pat)]+str;
                     Delete(pat,Length(pat),1);
                   end;
                   Text_us.Add(str);
                   end;

              end else
              begin
               str:=copy(upn,1,pos('@',upn)-1);
               Text_us.Add(str);
              end;
           // ]);
        end;
        //ShowMessage(Text);
      finally 
        GlobalUnlock(StgMed.hGlobal); 
      end 
      else
        Result := E_POINTER;

      ReleaseStgMedium(StgMed); 
    end; 
  end;
end;

function usr_fun():String;
var
  Picker: IDsObjectPicker;
  DatObj: IDataObject;
begin
//инициализируем COM+
  if Succeeded(CoInitialize(nil)) then
  try
// создаем Picker как объект COM+
    if Succeeded(CoCreateInstance(CLSID_DsObjectPicker, nil,
      CLSCTX_INPROC_SERVER, IID_IDsObjectPicker, Picker)) then
    try
//если инициализация Picker успешна вызываем сам диалог
      if Succeeded(InitObjectPicker(Picker)) then
        case Picker.InvokeDialog(Application.Handle, DatObj) of
          S_OK:
            try
//вызов диалога
Text_us:=TStringList.Create;
Text_us.Sorted:=true;
   Text_us.Duplicates:=dupIgnore;
   Text_us.Delimiter:=';';
              ProcessSelectedObjects(DatObj);
              result:=Text_us.DelimitedText;
              //Text_us.Free;
            finally
//освобождаем DatObj
              DatObj := nil;
            end;
          S_FALSE:
          begin
          Text_us.Free;
          result:='Никому';
          end;
            //ShowMessage('Ничего не выбрано');
        end;
    finally
      Picker := nil;
    end;
  finally
    CoUninitialize;
  end;
end;

end.
