unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp,WinSock, StdCtrls, Menus, ComCtrls, ImgList, ShellAPI,
  ExtCtrls, sSkinManager, sGroupBox, sTreeView, sListView, sPageControl, sButton;

type
  TSSDisconnect = class(TObject)
    private
      Procedure TreeWiewClear(TW:TTreeView);
      { Private declarations }
    public
      { Public declarations }
  end;
  TTreeVJob = class(TObject)
    private
//      Procedure ADDIP(check,notcheck:TStringList);
      Procedure ADD(TW:TTreeNodes; ind:integer;child:TStringList; ip:string);
      Procedure DEL(TW:TTreeNodes; ind:integer);
      Procedure SortChild(TW:TTreeNode; child:TStringList);
      Procedure FindSelect(TW:TTreeNodes; ind:integer);
      Procedure ChangeIcon(TW:TTreeNodes; ind:integer; child:TstringList);
      { Private declarations }
    public
      { Public declarations }
  end;
type
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    ImageList1: TImageList;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    sSkinManager1: TsSkinManager;
    sGroupBox1: TsGroupBox;
    sTreeView1: TsTreeView;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sListView1: TsListView;
    Timer1: TTimer;
    sTabSheet2: TsTabSheet;
    sListView2: TsListView;
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    PopupMenu2: TPopupMenu;
    L1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    PopupMenu3: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIcon1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure saveoffline();
    procedure sTreeView1Click(Sender: TObject);
    procedure sTreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure sListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure sListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure sListView2ColumnClick(Sender: TObject; Column: TListColumn);
    procedure sListView2Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  IDsObjectPicker = interface (IUnknown)
  ['{0c87e64e-3b7a-11d2-b9e0-00c04fd8dbf7}']
  end;
var
   Form1: TForm1;
  sizef,sizeg:integer;
  checkall,
  notcheck0,
  notcheck1,
  notcheck2,
  ConnectClients,
  Getf,md5h,dataf:TStringList;
  Getgfpl,md5hgfpl,datagfpl,ogran_list:TStringList;
  nconect,ncheck:integer;
  bisset, bissetg, proc_or_f:boolean;
  ColumnToSort,ColumnToSort2,compix,compix2,sostcol,sostcol2:integer;
implementation

uses Unit2, Unit3, Unit4, Unit5;

{$R *.dfm}


Procedure TSSDisconnect.TreeWiewClear(TW:TTreeView);
var
i:integer;
begin

  for I := 0 to TW.Items[0].Count - 1 do
  begin
  TW.Items.Delete(TW.Items.Item[0].item[0]);
  end;

   for I := 0 to TW.Items[1].Count - 1 do
  begin
  TW.Items.Delete(TW.Items.Item[1].item[0]);
  end;

  for I := 0 to TW.Items[2].Count - 1 do
  begin
  TW.Items.Delete(TW.Items.Item[2].item[0]);
  end;
end;

Procedure TTreeVJob.SortChild(TW:TTreeNode; child:TStringList);
var
  i:integer;
begin
  for I := 0 to TW.Count - 1 do
  begin
    TW.Item[i].Text := child.Strings[i];
  end;
end;

Procedure TTreeVJob.FindSelect(TW:TTreeNodes; ind:integer);
var
  i:integer;
begin
  for I := 0 to TW[ind].Count - 1 do
  begin
    if TW.Item[ind].item[i].Selected then
    begin
      Form1.sListView1.Items.Clear;
      md5h.Clear;
      md5hgfpl.Clear;
      dataf.Clear;
      datagfpl.Clear;
      if checkall.IndexOf(TW.Item[ind].item[i].Text)<0 then
      begin
        checkall.Add(TW.Item[ind].item[i].Text);
      end else
      begin
        checkall.Delete(checkall.IndexOf(TW.Item[ind].item[i].Text));
      end;
    end;
  end;
end;

Procedure TTreeVJob.ChangeIcon(TW:TTreeNodes; ind:integer; child:TstringList);
var
  i:integer;
begin
  for i := 0 to child.Count - 1 do
  begin
    if checkall.IndexOf(child.Strings[i])>=0 then
    begin
      TW[ind].Item[i].ImageIndex:=5;
      TW[ind].Item[i].SelectedIndex:=5;
    end else
    begin
      TW[ind].Item[i].ImageIndex:=6;
      TW[ind].Item[i].SelectedIndex:=6;
    end;
//    TW[ind].Expanded:=true;
  end;
end;

Procedure TTreeVJob.ADD(TW:TTreeNodes; Ind:integer;
                         child:TStringList; ip:string);
var
  i,j:integer;
begin
  if ip <> '' then
  begin
    i := child.Add(ip);
  end;
    for J := 0 to child.Count - 1 do
    begin  //Добавление в TreeView
      TW.AddChild(TW[ind],child.Strings[j]);
    end;
    SortChild(TW[ind],child);//Сортировка
//    for J := 0 to child.Count - 1 do
//    begin
////      if ip<>'' then
//      if checkall.IndexOf(ip)<0 then
//      begin
//        TW[ind].Item[j].ImageIndex:=6;
//        TW[ind].Item[j].SelectedIndex:=6;
//      end else
//      begin
//        TW[ind].Item[j].ImageIndex:=5;
//        TW[ind].Item[j].SelectedIndex:=5;
//      end;
//    end;

end;

Procedure TTreeVJob.Del(TW:TTreeNodes; ind:integer);
var
  i:integer;
begin
  for I := 0 to TW.Item[ind].Count - 1 do
    begin
      TW.Delete(TW.Item[ind].item[0]);
    end;
end;

procedure get_forbidden_processes;
begin

end;

procedure TForm1.saveoffline;
var
  F:TFileStream;
  i:integer;
  klients:TStringList;
begin
  klients:=TStringList.Create;
  klients.Sorted:=true;
  klients.Duplicates:=dupIgnore;
//  klients.AddStrings(offline);
//  klients.AddStrings(ip_com);
  for I := 0 to sTreeView1.Items[0].Count - 1 do
  begin
    sTreeView1.Items.Delete(sTreeView1.Items.Item[0].item[0]);
  end;

  for I := 0 to sTreeView1.Items[1].Count - 1 do
  begin
    sTreeView1.Items.Delete(sTreeView1.Items.Item[1].item[0]);
  end;

  for I := 0 to sTreeView1.Items[2].Count - 1 do
  begin
    sTreeView1.Items.Delete(sTreeView1.Items.Item[2].item[0]);
  end;

  for I := 0 to klients.Count - 1 do
  begin
    sTreeView1.Items.AddChild(sTreeView1.Items[0],klients.Strings[i]);
    sTreeView1.Items[0].Item[i].ImageIndex:=6;
    sTreeView1.Items[0].Item[i].SelectedIndex:=6;
  end;

  for I := 0 to klients.Count - 1 do
  begin
    sTreeView1.Items.AddChild(sTreeView1.Items[klients.Count+2],klients.Strings[i]);
    sTreeView1.Items[klients.Count+2].Item[i].ImageIndex:=6;
    sTreeView1.Items[klients.Count+2].Item[i].SelectedIndex:=6;
  end;

  F := TFileStream.Create(extractfilepath(paramstr(0))+'users.dbc',
       fmCreate or fmShareCompat);
  try
    f.WriteComponent(sTreeView1);
  finally
    f.Free;
  end;

end;



procedure TForm1.sButton1Click(Sender: TObject);
var
i:integer;
ss:string;
begin
  for i := 0 to sListView1.Items.Count - 1 do
    begin
      if sListView1.Items[i].Selected=true then
        begin

case Application.MessageBox(
Pchar('Внимание! Вы имеете возможность выбрать пользователей, '+
'которым будет разрешен запуск программы "'+
sListView1.Items[i].SubItems[0]+
'" . При нажатии кнопки "Нет", программа будет запрешена '+
'всем пользователям системы. Выбрать пользователей?'),
 'Правила запуска программ   ',
 MB_YESNOCANCEL or MB_ICONEXCLAMATION) of
 mrYes:begin
with sListView2.Items.Add do
begin
//sListView2.SortType:=stNone;
  caption:=sListView1.Items[i].Caption ;
  SubItems.Add(sListView1.Items[i].SubItems[0] );
  SubItems.Add(sListView1.Items[i].SubItems[1]);
  SubItems.Add(sListView1.Items[i].SubItems[2]);
  ogran_list.Add(sListView1.Items[i].SubItems[2]);
  SubItems.Add(sListView1.Items[i].SubItems[3]);
    ss := usr_fun+';';
//s_users.Add(sss);
    SubItems.Add(ss);
//       ImageList4.AddImage(ImageList3,ListView3.Items[ii].ImageIndex);
        //ImageList4.AddImage(ImageList1,ListView3.Items[ii].ImageIndex);
//    ImageIndex:=ImageList4.Count-1;
end;

       end;
mrNo:begin
with sListView2.Items.Add do
begin
//ListView1.SortType:=stNone;
caption:=sListView1.Items[i].Caption ;
  SubItems.Add(sListView1.Items[i].SubItems[0] );
    SubItems.Add(sListView1.Items[i].SubItems[1]);
    SubItems.Add(sListView1.Items[i].SubItems[2]);
    ogran_list.Add(sListView1.Items[i].SubItems[2]);
    SubItems.Add(sListView1.Items[i].SubItems[3]);
    ss:='Никому;';
//s_users.Add(sss);
    SubItems.Add(ss);
//ImageList4.AddImage(ImageList3,ListView3.Items[ii].ImageIndex);
//    ImageIndex:=ImageList4.Count-1;
end;

     end;
     mrCancel:begin
//       t:=true;
              end;
    end;



        end;
    end;
end;

procedure TForm1.sButton2Click(Sender: TObject);
var
i,s_u:integer;
begin
i := 0;
  while i<=sListView2.Items.Count-1 do
  begin
    if sListView2.Items[i].Selected=True then
    begin
      //idi:=ListView1.Items[i].ImageIndex;
      //ImageList4.Delete(idi);
      s_u:=ogran_list.IndexOf(sListView2.Items[i].SubItems[2]);
      ogran_list.Delete(s_u);
      //s_users.Delete(s_u);
      sListView2.Items[i].Delete;
      dec(i);
    end;
  inc(i);
  end;
end;

procedure TForm1.sButton3Click(Sender: TObject);
var
i,io:integer;
s:string;
begin
i := 0;
  while i<=sListView2.Items.Count-1 do
  begin
    if sListView2.Items[i].Selected = True then
    begin
case Application.MessageBox(
Pchar('Внимание! Вы имеете возможность выбрать пользователей, '+
'которым будет разрешен запуск программы "' +
sListView2.Items[i].SubItems[0]
+'" . При нажатии кнопки "Нет", программа будет запрешена '+
'всем пользователям системы. Выбрать пользователей?'),
 'Правила запуска программ   ',
 MB_YESNOCANCEL or MB_ICONEXCLAMATION) of
   mrYes:begin
      s:=usr_fun+';';
      sListView2.Items[i].SubItems[4]:=s;
         end;
    mrNo:begin
        s:='Никому;';
        sListView2.Items[i].SubItems[4]:=s;
         end;
    end;
    end;
  inc(i);
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShowWindow(Form1.Handle,SW_HIDE);
  ShowWindow(Application.Handle, SW_HIDE);
  abort;
end;

procedure TForm1.FormCreate(Sender: TObject);
  procedure add(TW:TTreeNodes; ind:integer; child:TstringList);
  var
    i:integer;
  begin
    for I := 0 to TW[ind].Count - 1 do
      begin
        child.Add(TW[ind].Item[i].Text);
        if TW[ind].Item[i].ImageIndex = 5 then
        begin
          checkall.Add(TW[ind].Item[i].Text);
        end;
      end;
  end;
  procedure cl(var s:string; ch:char);
    begin
    delete(s,1,pos(ch,s));
    end;

var
  c: array[0..128] of char;
  p: pchar;
  h: PHostEnt;
  F:TFileStream;
  i,y:integer;
  otrez:string;
begin
  ConnectClients := TStringList.Create;
  notcheck0 := TStringList.Create;
  notcheck1 := TStringList.Create;
  notcheck2 := TStringList.Create;
  checkall := TStringList.Create;

  md5h := TStringList.Create;
  dataf := TStringList.Create;
  md5hgfpl := TStringList.Create;
  datagfpl := TStringList.Create;
  ogran_list := TStringList.Create;

  ncheck:=0;
  nconect:=0;

  notcheck0.Sorted:=true;
  notcheck0.Duplicates:=dupIgnore;

  notcheck1.Sorted:=true;
  notcheck1.Duplicates:=dupIgnore;

  notcheck2.Sorted:=true;
  notcheck2.Duplicates:=dupIgnore;

  checkall.Sorted:=true;
  checkall.Duplicates:=dupIgnore;

  GetHostName(@c, 128);
  h := GetHostByName(@c);
  Form1.Caption :=Form1.Caption+' Имя Компьютера: '+ h^.h_Name; //Host отображает хост(имя) компьютера
    {Достаем IP}
  p := iNet_ntoa(PInAddr(h^.h_addr_list^)^);
  Form1.Caption :=Form1.Caption+' IP: '+p;

  if FileExists(extractfilepath(paramstr(0))+'report.dbc') then
  begin
  dataf.LoadFromFile(extractfilepath(paramstr(0))+'report.dbc');
  sListView1.Items.BeginUpdate;
        i:=0;
        sListView1.Items.Clear;
          while dataf.Count > i do
            begin
              otrez := dataf.Strings[i];
              with sListView1.Items.Add do
              begin
                caption := copy(otrez,1,pos(#8,otrez)-1);
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                md5h.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
              end;
              inc(i);
            end;
    sListView1.Items.EndUpdate;
  end;

if FileExists(extractfilepath(paramstr(0))+'reportGFPL.dbc') then
  begin
  datagfpl.LoadFromFile(extractfilepath(paramstr(0))+'reportGFPL.dbc');
  sListView2.Items.BeginUpdate;
        i:=0;
        sListView2.Items.Clear;
          while datagfpl.Count > i do
            begin
              otrez := datagfpl.Strings[i];
              with sListView2.Items.Add do
              begin
                caption := copy(otrez,1,pos(#8,otrez)-1);
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                md5hgfpl.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
              end;
              inc(i);
            end;
    sListView2.Items.EndUpdate;
  end;


  if FileExists(extractfilepath(paramstr(0))+'users.dbc') then
  begin

    F:=TFileStream.Create(extractfilepath(paramstr(0))+'users.dbc', fmOpenRead or fmShareDenyWrite);
    try
      f.ReadComponent(sTreeView1);
    finally
      f.Free;
    end;

  end;

  add(sTreeView1.Items, 0 , notcheck0);
  add(sTreeView1.Items, sTreeView1.Items[0].Count + 1 , notcheck1);
  add(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
      sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count + 1 , notcheck2);

end;

procedure TForm1.L1Click(Sender: TObject);
begin
sButton1.Click;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  Form1.Hide;
  form2.Show;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  saveoffline;
  TrayIcon1.Animate:=false;
  Application.Terminate;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
Form5.Hide;
Form4.Show;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
sButton2.Click;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
Form4.Hide;
Form5.Show;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  name,ip:string;
  ind,i:integer;
//  ch:integer;
//  klients:TStringList;
  F:TFileStream;
  TSS:TTreeVJob;
begin
  // Получить IP адрес
  ip:=inet_ntoa(ServerSocket1.Socket.
  Connections[ServerSocket1.Socket.ActiveConnections-1].RemoteAddr.sin_addr);
  // Получить имя ПК
  name:=ServerSocket1.Socket.Connections[ServerSocket1.Socket.ActiveConnections-1].RemoteHost;
//  saveoffline;
//  ch:=0;
  ConnectClients.Add(ip + '('+name+')');
  TSS := TTreeVJob.Create;
  sTreeView1.Items.BeginUpdate;
  TSS.Del(sTreeView1.Items, 0);
  TSS.Del(sTreeView1.Items, sTreeView1.Items[0].Count+1);
  TSS.Del(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
          sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count + 1);
  TSS.ADD(sTreeView1.Items, 0, notcheck0, ip+'('+name+')');
  TSS.ADD(sTreeView1.Items, sTreeView1.Items[0].Count+1, notcheck1, ip+'('+name+')');
  i := notcheck2.IndexOf(ip + '('+name+')');
  if i >= 0 then
  begin
    notcheck2.Delete(i);
  end;
  TSS.ADD(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
          sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count + 1,
          notcheck2, '');
  TSS.ChangeIcon(sTreeView1.Items, 0, notcheck0);
  TSS.ChangeIcon(sTreeView1.Items, sTreeView1.Items[0].Count+1, notcheck1);
  TSS.ChangeIcon(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
          sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count + 1, notcheck2);
  sTreeView1.Items.EndUpdate;
  TSS.Free;
   {  F:=TFileStream.Create(extractfilepath(paramstr(0))+'users.dbc', fmCreate or fmShareCompat);
  try
    f.WriteComponent(TreeView1);
  finally
    f.Free;
  end; }
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  ra,hos:string;
  ind,i:integer;
  F:TFileStream;
  TSS:TTreeVJob;
begin
  ra:=socket.RemoteAddress;
  hos:=socket.RemoteHost;
  ConnectClients.Delete(ConnectClients.IndexOf(ra + '('+hos+')'));
  TSS := TTreeVJob.Create;
  sTreeView1.Items.BeginUpdate;
  TSS.Del(sTreeView1.Items, 0);
  TSS.Del(sTreeView1.Items, sTreeView1.Items[0].Count + 1);
  TSS.Del(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
          sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count+1);
  TSS.ADD(sTreeView1.Items, 0, notcheck0, ra+'('+hos+')');
  i := notcheck1.IndexOf(ra + '('+hos+')');
  if i >= 0 then
    begin
      notcheck1.Delete(i);
    end;
  TSS.ADD(sTreeView1.Items, sTreeView1.Items[0].Count + 1, notcheck1, '');
  TSS.ADD(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
          sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count+1,
          notcheck2, ra+'('+hos+')');
  TSS.ChangeIcon(sTreeView1.Items, 0, notcheck0);
  TSS.ChangeIcon(sTreeView1.Items, sTreeView1.Items[0].Count+1, notcheck1);
  TSS.ChangeIcon(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
          sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count + 1, notcheck2);
  sTreeView1.Items.EndUpdate;
  TSS.Free;

//  for I := 0 to ip_com.Count - 1 do
//  begin
//    if True then
//
//    TreeView1.Items.AddChild(TreeView1.Items[ch+1],ip_com.Strings[i]);
//    TreeView1.Items[ch+1].Item[i].ImageIndex:=6;
//    TreeView1.Items[ch+1].Item[i].SelectedIndex:=6;
//  end;
//
//  ch:=ch+ip_com.Count+1;
//  for I := 0 to offline.Count - 1 do
//  begin
//    TreeView1.Items.AddChild(TreeView1.Items[ch+1],offline.Strings[i]);
//    if checkall.IndexOf(offline.Strings[i])<0 then
//    begin
//      TreeView1.Items[ch+1].Item[i].ImageIndex:=6;
//      TreeView1.Items[ch+1].Item[i].SelectedIndex:=6;
//    end else
//    begin
//      TreeView1.Items[ch+1].Item[i].ImageIndex:=5;
//      TreeView1.Items[ch+1].Item[i].SelectedIndex:=5;
//    end;
//  end;

  sTreeView1.Items.EndUpdate;
  F:=TFileStream.Create(extractfilepath(paramstr(0))+'users.dbc', fmCreate or fmShareCompat);
  try
    f.WriteComponent(sTreeView1);
  finally
    f.Free;
  end;

end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ShowMessage('Err!');
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
  procedure cl(var s:string; ch:char);
    begin
    delete(s,1,pos(ch,s));
    end;
  var
  sSoket, otrez,s:string;
  i:integer;
begin
  sSoket:=ServerSocket1.Socket.Connections[nconect].ReceiveText;


  if copy(sSoket, 1, 10)='ok_givproc' then
  begin
    delete(sSoket,1,10);
    i := strtoint(copy(sSoket,1,pos(#8,sSoket)-1));
    if i<Getgfpl.Count then
      begin
        ServerSocket1.Socket.Connections[nconect].SendText('st' + inttostr(i) + #8 + Getgfpl.Strings[i]);
      end else
      begin
        ServerSocket1.Socket.Connections[nconect].SendText('st');
        Getgfpl.Free;
        nconect:= -1;
        proc_or_f := false;
        Timer1.Enabled := true;
      end;
    sSoket:='';
  end;

  if copy(sSoket, 1, 2)='st' then
  begin
    Delete(sSoket,1,2);
    if Getf.Count<sizef then
      begin
        i := strtoint(copy(sSoket,1,pos(#8,sSoket)-1));
        i := i + 1;
        delete(sSoket,1, pos(#8,sSoket));
        s := sSoket;
        cl(s,#8);
        cl(s,#8);
        cl(s,#8);
        s := copy(s,1,pos(#8,s)-1);
        if md5h.IndexOf(s) < 0 then
          begin
            dataf.Add(sSoket);
            md5h.Add(s);
            bisset := true;
          end;
        Getf.Add(sSoket);
        ServerSocket1.Socket.Connections[nconect].SendText('ok_givproc' +
        inttostr(i) + #8);
      end else
      begin
        if bisset = true then
          begin
        sListView1.Items.BeginUpdate;
        i:=0;
        bisset := false;
        sListView1.Items.Clear;
          while dataf.Count > i do
            begin
              otrez := dataf.Strings[i];
              with sListView1.Items.Add do
              begin
                caption := copy(otrez,1,pos(#8,otrez)-1);
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
              end;
              inc(i);
            end;
    sListView1.Items.EndUpdate;
          end;
    nconect:=-1;
    proc_or_f := true;
    Timer1.Enabled := true;
    Getf.Free;
    Dataf.SaveToFile(extractfilepath(paramstr(0))+'report.dbc');
      end;
  end;


  if copy(sSoket, 1, 6)='gtgfpl' then
  begin
    Delete(sSoket,1,6);
    if Getgfpl.Count<sizeg then
      begin
        i := strtoint(copy(sSoket,1,pos(#8,sSoket)-1));
        i := i + 1;
        delete(sSoket,1, pos(#8,sSoket));
        s := sSoket;
        cl(s,#8);
        cl(s,#8);
        cl(s,#8);
        s := copy(s,1,pos(#8,s)-1);
        if md5hgfpl.IndexOf(s) < 0 then
          begin
            datagfpl.Add(sSoket);
            md5hgfpl.Add(s);
            bissetg := true;
          end;
        Getgfpl.Add(sSoket);
        ServerSocket1.Socket.Connections[nconect].SendText('ok_gfpl' +
        inttostr(i) + #8);
      end else
      begin
        if bissetg = true then
          begin
        sListView2.Items.BeginUpdate;
        i:=0;
        bissetg := false;
        sListView2.Items.Clear;
          while datagfpl.Count > i do
            begin
              otrez := datagfpl.Strings[i];
              with sListView2.Items.Add do
              begin
                caption := copy(otrez,1,pos(#8,otrez)-1);
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
                SubItems.Add(copy(otrez,1,pos(#8,otrez)-1));
                cl(otrez,#8);
              end;
              inc(i);
            end;
    sListView2.Items.EndUpdate;
          end;
    nconect:=-1;
    proc_or_f := false;
    Timer1.Enabled := true;
    Getgfpl.Free;
    datagfpl.SaveToFile(extractfilepath(paramstr(0))+'reportGFPL.dbc');
      end;
  end;


  if copy(sSoket, 1, 7)='ok_proc' then
  begin
    delete(sSoket,1,7);
    sizef := strtoint(copy(sSoket,1,pos(#8,sSoket)-1));
    ServerSocket1.Socket.Connections[nconect].SendText('ok_givproc0'+#8);
    Getf := TStringList.Create;
  end;

  if copy(sSoket, 1, 7)='ok_gfpl' then
  begin
      Getgfpl := TStringList.Create;
    for I := 0 to sListView2.Items.Count - 1 do
    begin
      s :=sListView2.Items[i].Caption + #8;
      s := s + sListView2.Items[i].SubItems[0] + #8;
      s := s + sListView2.Items[i].SubItems[1] + #8;
      s := s + sListView2.Items[i].SubItems[2] + #8;
      s := s + sListView2.Items[i].SubItems[3] + #8;
      s := s + sListView2.Items[i].SubItems[4] + #8;
      Getgfpl.Add(s);
      s:='';
    end;
    ServerSocket1.Socket.Connections[nconect].SendText('ok_gfpl'+inttostr(Getgfpl.Count)+#8);
  sSoket:='';
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
//  sListView1.Clear;
  while (ncheck <= checkall.Count - 1) and (Timer1.Enabled = true) do
    begin
      nconect := ConnectClients.IndexOf(checkall.Strings[ncheck]);
      if nconect>=0 then
        begin
          Timer1.Enabled := false;
          if proc_or_f = false then
             begin
               ServerSocket1.Socket.Connections[nconect].SendText('givproc');
             end else
             begin
               ServerSocket1.Socket.Connections[nconect].SendText('getforbiddenprocess');
             end;
        end;
      inc(ncheck);
    end;
  if ncheck > checkall.Count - 1 then
    begin
      ncheck := 0;
    end;
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

procedure TForm1.sListView1ColumnClick(Sender: TObject; Column: TListColumn);
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
sListView1.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to sListView1.Items.Count-2 do
   if strtoint(sListView1.Items[i].SubItems[1]) > strtoint(sListView1.Items[i+1].SubItems[1]) then
    begin
     cap := sListView1.Items[i].Caption ;
          fpth:=sListView1.Items[i].SubItems[0];
          razm:= sListView1.Items[i].SubItems[1] ;
                    mdd:= sListView1.Items[i].SubItems[2] ;
                                        crcc:= sListView1.Items[i].SubItems[3] ;
                                        in1:=sListView1.Items[i].ImageIndex;
sListView1.Items[i].Caption:= sListView1.Items[i+1].Caption ;
    sListView1.Items[i].SubItems[0]:=sListView1.Items[i+1].SubItems[0] ;
          sListView1.Items[i].SubItems[1]:= sListView1.Items[i+1].SubItems[1] ;
                    sListView1.Items[i].SubItems[2]:= sListView1.Items[i+1].SubItems[2] ;
                          sListView1.Items[i].SubItems[3]:= sListView1.Items[i+1].SubItems[3] ;
                          sListView1.Items[i].ImageIndex:=sListView1.Items[i+1].ImageIndex;
sListView1.Items[i+1].Caption:=cap;
      sListView1.Items[i+1].SubItems[0]:=fpth;
          sListView1.Items[i+1].SubItems[1]:= razm ;
                    sListView1.Items[i+1].SubItems[2]:= mdd ;
                          sListView1.Items[i+1].SubItems[3]:= crcc ;
                          sListView1.Items[i+1].ImageIndex:=in1;
     b:= false;
    end;

 until b;
 sListView1.Items.EndUpdate;

end else
begin
if compix=1 then
begin
compix:=0;
sListView1.Items.BeginUpdate;
repeat
  b:= true;
  for i:= 0 to sListView1.Items.Count-2 do
   if strtoint(sListView1.Items[i].SubItems[1]) < strtoint(sListView1.Items[i+1].SubItems[1]) then
    begin
     cap := sListView1.Items[i+1].Caption ;
          fpth:=sListView1.Items[i+1].SubItems[0];
          razm:= sListView1.Items[i+1].SubItems[1] ;
                    mdd:= sListView1.Items[i+1].SubItems[2] ;
                                        crcc:= sListView1.Items[i+1].SubItems[3] ;
                                        in1:=sListView1.Items[i+1].ImageIndex;
sListView1.Items[i+1].Caption:= sListView1.Items[i].Caption ;
    sListView1.Items[i+1].SubItems[0]:=sListView1.Items[i].SubItems[0] ;
          sListView1.Items[i+1].SubItems[1]:= sListView1.Items[i].SubItems[1] ;
                    sListView1.Items[i+1].SubItems[2]:= sListView1.Items[i].SubItems[2] ;
                          sListView1.Items[i+1].SubItems[3]:= sListView1.Items[i].SubItems[3] ;
                               sListView1.Items[i+1].ImageIndex:=sListView1.Items[i].ImageIndex;
sListView1.Items[i].Caption:=cap;
      sListView1.Items[i].SubItems[0]:=fpth;
          sListView1.Items[i].SubItems[1]:= razm ;
                    sListView1.Items[i].SubItems[2]:= mdd ;
                          sListView1.Items[i].SubItems[3]:= crcc ;
                              sListView1.Items[i].ImageIndex:=in1;
     b:= false;
    end;
 until b;
 sListView1.Items.EndUpdate;
end;
end;
end;
end;
end;

procedure TForm1.sListView1Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
ix,i: Integer;
begin

if ColumnToSort = 0 then
begin
//ListView1.SortType:=stBoth;
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
//sListView1.SortType:=stBoth;
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


procedure TForm1.sListView2ColumnClick(Sender: TObject; Column: TListColumn);
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
sListView2.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to sListView2.Items.Count-2 do
   if strtoint(sListView2.Items[i].SubItems[1]) > strtoint(sListView2.Items[i+1].SubItems[1]) then
    begin
     cap := sListView2.Items[i].Caption ;
          fpth:=sListView2.Items[i].SubItems[0];
          razm:= sListView2.Items[i].SubItems[1] ;
                    mdd:= sListView2.Items[i].SubItems[2] ;
                                        crcc:= sListView2.Items[i].SubItems[3] ;
                                        in1:=sListView2.Items[i].ImageIndex;
sListView2.Items[i].Caption:= sListView2.Items[i+1].Caption ;
    sListView2.Items[i].SubItems[0]:=sListView2.Items[i+1].SubItems[0] ;
          sListView2.Items[i].SubItems[1]:= sListView2.Items[i+1].SubItems[1] ;
                    sListView2.Items[i].SubItems[2]:= sListView2.Items[i+1].SubItems[2] ;
                          sListView2.Items[i].SubItems[3]:= sListView2.Items[i+1].SubItems[3] ;
                          sListView2.Items[i].ImageIndex:=sListView2.Items[i+1].ImageIndex;
sListView2.Items[i+1].Caption:=cap;
      sListView2.Items[i+1].SubItems[0]:=fpth;
          sListView2.Items[i+1].SubItems[1]:= razm ;
                    sListView2.Items[i+1].SubItems[2]:= mdd ;
                          sListView2.Items[i+1].SubItems[3]:= crcc ;
                          sListView2.Items[i+1].ImageIndex:=in1;
     b:= false;
    end;

 until b;
 sListView2.Items.EndUpdate;

end else
begin
if compix=1 then
begin
compix:=0;
sListView2.Items.BeginUpdate;
repeat
  b:= true;

  for i:= 0 to sListView2.Items.Count-2 do
   if strtoint(sListView2.Items[i].SubItems[1]) < strtoint(sListView2.Items[i+1].SubItems[1]) then
    begin
     cap := sListView2.Items[i+1].Caption ;
          fpth:=sListView2.Items[i+1].SubItems[0];
          razm:= sListView2.Items[i+1].SubItems[1] ;
                    mdd:= sListView2.Items[i+1].SubItems[2] ;
                                        crcc:= sListView2.Items[i+1].SubItems[3] ;
                                        in1:=sListView2.Items[i+1].ImageIndex;
sListView2.Items[i+1].Caption:= sListView2.Items[i].Caption ;
    sListView2.Items[i+1].SubItems[0]:=sListView2.Items[i].SubItems[0] ;
          sListView2.Items[i+1].SubItems[1]:= sListView2.Items[i].SubItems[1] ;
                    sListView2.Items[i+1].SubItems[2]:= sListView2.Items[i].SubItems[2] ;
                          sListView2.Items[i+1].SubItems[3]:= sListView2.Items[i].SubItems[3] ;
                               sListView2.Items[i+1].ImageIndex:=sListView2.Items[i].ImageIndex;
sListView2.Items[i].Caption:=cap;
      sListView2.Items[i].SubItems[0]:=fpth;
          sListView2.Items[i].SubItems[1]:= razm ;
                    sListView2.Items[i].SubItems[2]:= mdd ;
                          sListView2.Items[i].SubItems[3]:= crcc ;
                              sListView2.Items[i].ImageIndex:=in1;
     b:= false;
    end;

 until b;
 sListView2.Items.EndUpdate;

end;
end;



end;
end;

end;

procedure TForm1.sListView2Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
ix,i: Integer;
begin

if ColumnToSort = 0 then
begin
sListView2.SortType:=stBoth;
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
sListView2.SortType:=stBoth;
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

procedure TForm1.sTreeView1Click(Sender: TObject);
var
i,ch,x:integer;
TSS:TTreeVJob;
begin
TSS := TTreeVJob.Create;
TSS.FindSelect(sTreeView1.Items, 0);
TSS.FindSelect(sTreeView1.Items, sTreeView1.Items[0].Count+1);
TSS.FindSelect(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count + 1);

TSS.ChangeIcon(sTreeView1.Items, 0, notcheck0);
TSS.ChangeIcon(sTreeView1.Items, sTreeView1.Items[0].Count+1, notcheck1);
TSS.ChangeIcon(sTreeView1.Items, sTreeView1.Items[0].Count + 1 +
sTreeView1.Items[sTreeView1.Items[0].Count + 1].Count + 1, notcheck2);
TSS.Free;

//
//  ch:=0;
//  for I := 0 to TreeView1.Items[0].Count - 1 do //Все ПК
//  begin
//    if TreeView1.Items.Item[0].item[i].Selected then
//       begin
//         if checkall.IndexOf(TreeView1.Items.Item[0].item[i].Text)<0 then
//         begin
//           checkall.Add(TreeView1.Items.Item[0].item[i].Text);
//           TreeView1.Items[0].Item[i].ImageIndex:=5;
//           TreeView1.Items[0].Item[i].SelectedIndex:=5;
//
//           for x := 0 to ip_com.Count - 1 do
//           begin
//             if checkall.IndexOf(TreeView1.Items.Item[TreeView1.Items[0].Count+1
//             ].item[x].Text)>=0 then
//             begin
//               checkonline.Add(TreeView1.Items.Item[TreeView1.Items[0].Count+1].item[x].Text);
//               TreeView1.Items[TreeView1.Items[0].Count+1].Item[x].ImageIndex:=5;
//               TreeView1.Items[TreeView1.Items[0].Count+1].Item[x].SelectedIndex:=5;
//             end;
//           end;
//
//           for x := 0 to offline.Count - 1 do
//           begin
//             if checkall.IndexOf(TreeView1.Items.Item[TreeView1.Items[0].Count+ip_com.Count+2
//             ].item[x].Text)>=0 then
//             begin
//               checkoffline.Add(TreeView1.Items.Item[TreeView1.Items[0].Count+ip_com.Count+2].item[x].Text);
//               TreeView1.Items[TreeView1.Items[0].Count+ip_com.Count+2].Item[x].ImageIndex:=5;
//               TreeView1.Items[TreeView1.Items[0].Count+ip_com.Count+2].Item[x].SelectedIndex:=5;
//             end;
//           end;
//
//
//         end else
//         begin
//           checkall.Delete(checkall.IndexOf(TreeView1.Items.Item[0].item[i].Text));
//           TreeView1.Items[0].Item[i].ImageIndex:=6;
//           TreeView1.Items[0].Item[i].SelectedIndex:=6;
//
//           for x := 0 to ip_com.Count - 1 do
//           begin
//             if checkall.IndexOf(TreeView1.Items.Item[TreeView1.Items[0].Count+1
//             ].item[x].Text)<0 then
//             begin
//               checkonline.Delete(checkonline.IndexOf(TreeView1.Items.Item[TreeView1.Items[0].Count+1].item[x].Text));
//               TreeView1.Items[TreeView1.Items[0].Count+1].Item[x].ImageIndex:=6;
//               TreeView1.Items[TreeView1.Items[0].Count+1].Item[x].SelectedIndex:=6;
//             end;
//           end;
//
//           for x := 0 to offline.Count - 1 do
//           begin
//             if checkall.IndexOf(TreeView1.Items.Item[TreeView1.Items[0].Count+ip_com.Count+2
//             ].item[x].Text)<0 then
//             begin
//               checkoffline.Delete(checkoffline.IndexOf( TreeView1.Items.Item[TreeView1.Items[0].Count+ip_com.Count+2].item[x].Text));
//               TreeView1.Items[TreeView1.Items[0].Count+ip_com.Count+2].Item[x].ImageIndex:=6;
//               TreeView1.Items[TreeView1.Items[0].Count+ip_com.Count+2].Item[x].SelectedIndex:=6;
//             end;
//           end;
//
//
//         end;
//       end;
//     inc(ch);
//  end;
//
//for I := 0 to ip_com.Count - 1 do
//begin
//  if TreeView1.Items.Item[ch+1].item[i].Selected then
//  begin
//
//    if checkonline.IndexOf(TreeView1.Items.Item[ch+1].item[i].Text)<0 then
//    begin
//      checkonline.Add(TreeView1.Items.Item[ch+1].item[i].Text);
//      TreeView1.Items[ch+1].Item[i].ImageIndex:=5;
//      TreeView1.Items[ch+1].Item[i].SelectedIndex:=5;
//
//      for x := 0 to TreeView1.Items[0].Count - 1 do
//      begin
//        if checkonline.IndexOf(TreeView1.Items.Item[0].item[x].Text)>=0 then
//        begin
//          checkall.Add(TreeView1.Items.Item[0].item[x].Text);
//          TreeView1.Items[0].Item[x].ImageIndex:=5;
//          TreeView1.Items[0].Item[x].SelectedIndex:=5;
//        end;
//      end;
//
//    end else
//    begin
//       checkonline.Delete(checkonline.IndexOf(TreeView1.Items.Item[ch+1].item[i].Text));
//       TreeView1.Items[ch+1].Item[i].ImageIndex:=6;
//       TreeView1.Items[ch+1].Item[i].SelectedIndex:=6;
//
//       for x := 0 to TreeView1.Items[0].Count - 1 do
//       begin
//         if checkonline.IndexOf(TreeView1.Items.Item[0].item[x].Text)<0 then
//         begin
//            checkall.Delete(checkall.IndexOf(TreeView1.Items.Item[0].item[x].Text));
//            TreeView1.Items[0].Item[x].ImageIndex:=6;
//            TreeView1.Items[0].Item[x].SelectedIndex:=6;
//         end;
//       end;
//
//    end;
//  end;
//end;
//  ch:=ch+ip_com.Count+1;
//  for I := 0 to offline.Count - 1 do
//  begin
//    if TreeView1.Items.Item[ch+1].item[i].Selected then
//    begin
//      if checkoffline.IndexOf(TreeView1.Items.Item[ch+1].item[i].Text)<0 then
//      begin
//        checkoffline.Add(TreeView1.Items.Item[ch+1].item[i].Text);
//        TreeView1.Items[ch+1].Item[i].ImageIndex:=5;
//        TreeView1.Items[ch+1].Item[i].SelectedIndex:=5;
//
//        for x := 0 to TreeView1.Items[0].Count - 1 do
//        begin
//          if checkoffline.IndexOf(TreeView1.Items.Item[0].item[x].Text)>=0 then
//          begin
//            checkall.Add(TreeView1.Items.Item[0].item[x].Text);
//            TreeView1.Items[0].Item[x].ImageIndex:=5;
//            TreeView1.Items[0].Item[x].SelectedIndex:=5;
//          end;
//        end;
//
//      end else
//      begin
//        checkoffline.Delete(checkoffline.IndexOf(TreeView1.Items.Item[ch+1].item[i].Text));
//        TreeView1.Items[ch+1].Item[i].ImageIndex:=6;
//        TreeView1.Items[ch+1].Item[i].SelectedIndex:=6;
//
//        for x := 0 to TreeView1.Items[0].Count - 1 do
//        begin
//          if checkoffline.IndexOf(TreeView1.Items.Item[0].item[x].Text)<0 then
//          begin
//            checkall.Delete(checkall.IndexOf(TreeView1.Items.Item[0].item[x].Text));
//            TreeView1.Items[0].Item[x].ImageIndex:=6;
//            TreeView1.Items[0].Item[x].SelectedIndex:=6;
//          end;
//        end;
//
//      end;//check
//    end;//Treewiev
//  end;//for
//
//
//    ch:=0;
//    for I := 0 to TreeView1.Items[0].Count - 1 do
//    begin
//      TreeView1.Items.Item[0].item[i].Selected:=false;
//      inc(ch);
//    end;
//
//    for I := 0 to ip_com.Count - 1 do
//    begin
//      TreeView1.Items.Item[ch+1].item[i].Selected:=false;
//    end;
//
//    ch:=ch+ip_com.Count+1;
//    for I := 0 to offline.Count - 1 do
//    begin
//      TreeView1.Items.Item[ch+1].item[i].Selected:=false;
//    end;

end;

procedure TForm1.sTreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin

end;

//TW1Click

end.
