unit uDDMX_DZX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, iLabel, ADODB, IdComponent,
  IdHTTP,jpeg,GIFImage,ShellAPI,IdGlobal, Menus;


type
  TPicInfo = record
    m_sPath: string;
    m_sFileName: string;
    m_sUrlPicPath: string;
  end;
  TFrm_DDMX_DZX = class;

  TMyDownLoad=class(TThread)
  private
    g_iFileSize: Integer;
    g_iCurrent: Integer;
    FrmDZX: TFrm_DDMX_DZX;
    procedure  DownLoadPic;    //下载图片 和 控件移动
    procedure idhtp_picWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure idhtp_picStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure idhtp_picWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure idhtp_picWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
  protected
        procedure Execute;override;
  end;

  TFrm_DDMX_DZX = class(TForm)
    pan_jg: TPanel;
    Shape52: TShape;
    Shape98: TShape;
    Shape93: TShape;
    Shape92: TShape;
    Shape91: TShape;
    Shape90: TShape;
    Shape89: TShape;
    Shape87: TShape;
    Shape85: TShape;
    Shape83: TShape;
    Shape82: TShape;
    Shape81: TShape;
    Shape80: TShape;
    Shape72: TShape;
    Shape67: TShape;
    Shape66: TShape;
    Shape65: TShape;
    Shape64: TShape;
    Shape63: TShape;
    Shape61: TShape;
    Shape59: TShape;
    Shape57: TShape;
    Shape56: TShape;
    Shape55: TShape;
    Shape54: TShape;
    Shape48: TShape;
    Shape47: TShape;
    Shape46: TShape;
    Shape44: TShape;
    Shape43: TShape;
    Shape42: TShape;
    Shape41: TShape;
    Shape40: TShape;
    Shape39: TShape;
    Shape38: TShape;
    Shape37: TShape;
    Shape36: TShape;
    Shape35: TShape;
    Shape34: TShape;
    Shape33: TShape;
    Shape32: TShape;
    Shape31: TShape;
    Shape30: TShape;
    Shape29: TShape;
    Shape28: TShape;
    Shape22: TShape;
    Shape21: TShape;
    Shape20: TShape;
    Shape19: TShape;
    Shape18: TShape;
    Shape17: TShape;
    Shape16: TShape;
    Shape15: TShape;
    Shape14: TShape;
    Shape13: TShape;
    Shape12: TShape;
    Shape11: TShape;
    Shape10: TShape;
    Shape9: TShape;
    Shape8: TShape;
    Shape7: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape2: TShape;
    lab_qttsgy: Ti_Label;
    i_Label2: Ti_Label;
    i_Label3: Ti_Label;
    lab_tsgybz: Ti_Label;
    i_Label5: Ti_Label;
    i_Label6: Ti_Label;
    i_Label7: Ti_Label;
    i_Label9: Ti_Label;
    i_Label10: Ti_Label;
    i_Label11: Ti_Label;
    i_Label12: Ti_Label;
    i_Label14: Ti_Label;
    i_Label15: Ti_Label;
    i_Label16: Ti_Label;
    i_Label17: Ti_Label;
    i_Label18: Ti_Label;
    lab_qy: Ti_Label;
    i_Label20: Ti_Label;
    lab_jybz: Ti_Label;
    lab_xpl: Ti_Label;
    i_Label23: Ti_Label;
    i_Label24: Ti_Label;
    i_Label25: Ti_Label;
    i_Label26: Ti_Label;
    i_Label27: Ti_Label;
    i_Label28: Ti_Label;
    lab_wxbz: Ti_Label;
    i_Label31: Ti_Label;
    i_Label32: Ti_Label;
    i_Label33: Ti_Label;
    i_Label34: Ti_Label;
    i_Label35: Ti_Label;
    i_Label36: Ti_Label;
    Shape1: TShape;
    Shape26: TShape;
    lab_SbID: Ti_Label;
    Shape58: TShape;
    lab_dfbbz: Ti_Label;
    edt_Temp: TEdit;
    btn_tsgy: TButton;
    pan_gy: TPanel;
    Shape60: TShape;
    Shape62: TShape;
    Shape68: TShape;
    Shape69: TShape;
    i_Label1: Ti_Label;
    lab_yzjg: Ti_Label;
    Shape70: TShape;
    Shape71: TShape;
    Shape73: TShape;
    Shape75: TShape;
    Shape78: TShape;
    Shape84: TShape;
    Shape86: TShape;
    Shape88: TShape;
    Shape94: TShape;
    Shape95: TShape;
    Shape96: TShape;
    Shape97: TShape;
    i_Label13: Ti_Label;
    i_Label19: Ti_Label;
    i_Label21: Ti_Label;
    i_Label22: Ti_Label;
    i_Label29: Ti_Label;
    i_Label43: Ti_Label;
    lab_njtsgy: Ti_Label;
    shape_2: TShape;
    shape_1: TShape;
    Shape24: TShape;
    btn_bz: TButton;
    Shape25: TShape;
    Shape27: TShape;
    Shape49: TShape;
    Shape50: TShape;
    lab_fyzjg: Ti_Label;
    lab_njyzjg: Ti_Label;
    Shape45: TShape;
    Shape23: TShape;
    lab_nbbz: Ti_Label;
    btn_yzjg: TButton;
    pm_jgp: TPopupMenu;
    menu_SaveTo: TMenuItem;
    dlg_SavePic: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure i_Label13Click(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure btn_tsgyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_bzClick(Sender: TObject);
    procedure btn_yzjgClick(Sender: TObject);

  private
    { Private declarations }
    vClose: Boolean;
    ImgList: array of TImage;
    PicInfo: array of TPicInfo;
    MyThread: TMyDownLoad;
    procedure LoadPic;
    function f_MakeAllow: Boolean;   //操作允许
    procedure WndProc(var Message: TMessage); override;
    procedure FileSaveTo(AsFileName: string);
    procedure SaveToClick(Sender: TObject);
    procedure ImgDblClick(Sender: TObject);
    procedure ImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure DisplaySBSX;  //显示申报备注
  public
    { Public declarations }
    Lab: array of TLabel;
    vCustomID: Integer;
    vTGSHOW: Boolean;
    LabProg: array of TLabel;
    LabSaveTo: array of TLabel;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  function FrmDDMX_DZX(_iOrderID: Integer;_bTGSHOW: Boolean): TFrm_DDMX_DZX;

implementation

uses
  PubStr, uDM_DataBase,uFrm_Tsgy_modif, uPub_Type, uPub_Func, uPub_Text;

{$R *.dfm}

const
  WM_FREE = WM_USER + 100;

function FrmDDMX_DZX(_iOrderID: Integer;_bTGSHOW: Boolean): TFrm_DDMX_DZX;
var
  i: Integer;
  sSqlData,sHint: string;
  ADO_Rec: TADOQuery;
  Frm_DDMX_DZX: TFrm_DDMX_DZX;
begin
  sSqlData := 'select * from BI_CustomOrderDetails where F_iID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[_iOrderID]);

  Frm_DDMX_DZX := TFrm_DDMX_DZX.Create(Application);
  for i := 0 to Frm_DDMX_DZX.ComponentCount -1 do
  begin
    if Frm_DDMX_DZX.Components[i] is Ti_Label then
    begin
      sHint := Ti_Label(Frm_DDMX_DZX.Components[i]).Hint;
      if sHint = 'F_sQttsgyms' then
      begin
        sHint := Ti_Label(Frm_DDMX_DZX.Components[i]).EditLabel.Caption;
        sHint := 'F_sQttsgyms';
      end;
      if sHint = '' then Continue;
      Ti_Label(Frm_DDMX_DZX.Components[i]).Caption := ADO_Rec.FieldByName(sHint).AsString;
    end;
  end;
  Frm_DDMX_DZX.vCustomID := _iOrderID;
  Frm_DDMX_DZX.vTGSHOW := _bTGSHOW;
  Result := Frm_DDMX_DZX;

end;

procedure FrmMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  TForm(Sender).VertScrollBar.Position := TForm(Sender).VertScrollBar.Position + 40;
end;

procedure FrmMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  TForm(Sender).VertScrollBar.Position := TForm(Sender).VertScrollBar.Position - 40;

end;


procedure TFrm_DDMX_DZX.LoadPic;
var
  ms: TMemoryStream;
  sTempPath,sPicCpbh,sPicName,sPicPath: string;
  ADO_Rec: TADOQuery;
  sSqlData: string;
  Len, iWidth: Integer;
  rs: TResourceStream;
begin
  if Self.vCustomID = 0 then Exit;
  ms := TMemoryStream.Create;
  SetLength(Self.ImgList,0);
  SetLength(Self.Lab,0);
  sTempPath := GetTempDirectory+c_TempPicPath;
  sSqlData := 'Select * from BI_CustomOrderImg where F_iCustomDetailsID=%d order by F_sCPBH';
  ADO_Rec :=  DM_DataBase.OpenQuery(sSqlData,[Self.vCustomID]);
  try
    with ADO_Rec do
    begin
      //加印订单图稿信息不全,用原订单图稿信息带替
      if lab_jybz.Caption = '加印' then
      begin
        sPicPath := '';
        while not Eof do
        begin
          sPicPath := FieldByName('F_sPath').AsString;
          if Trim(sPicPath) = '' then Break;
          Next;
        end;
        if Trim(sPicPath) = '' then
        begin
          ADO_Rec.Free;
          sSqlData := 'select b.* from BI_CustomOrderDetails a,BI_CustomOrderImg b '
            + ' where exists(select 1 from BI_CustomOrderDetails where F_iID=%d and a.F_sCPBH=F_sCPBH) '
            + ' and F_tiJYBZ=0 and a.F_iID = b.F_iCustomDetailsID';
          ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[Self.vCustomID]);
          if not Assigned(ADO_Rec) or (ADO_Rec.RecordCount = 0) then
          begin
            ADO_Rec.Free;
            sSqlData := 'Select * from BI_CustomOrderImg where F_iCustomDetailsID=%d';
            ADO_Rec :=  DM_DataBase.OpenQuery(sSqlData,[Self.vCustomID]);
          end;
        end;
      end;
      First;
      //订单在国网撤销后接收下来的订单如果图稿信息不会,用撤销订单的图稿信息带替
      if RecordCount=0 then
      begin
        ADO_Rec.Free;
        sSqlData := 'select b.* from BI_CustomOrderDetails a,BI_CustomOrderImg b '
          + ' where exists(select 1 from BI_CustomOrderDetails where F_iID=%d and a.F_sCPBH=F_sCPBH) '
          + ' and  a.F_iID = b.F_iCustomDetailsID and F_tiCXBZ=1';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[Self.vCustomID]);
        if not Assigned(ADO_Rec) or (ADO_Rec.RecordCount = 0) then
        begin
          ADO_Rec.Free;
          sSqlData := 'Select * from BI_CustomOrderImg where F_iCustomDetailsID=%d';
          ADO_Rec :=  DM_DataBase.OpenQuery(sSqlData,[Self.vCustomID]);
        end;
      end;
      First;
      Len := 0;
      iWidth := 800;
      while not Eof do
      begin
        sPicCpbh := FieldByName('F_sCpbh').AsString;
        sPicPath := FieldByName('F_sPath').AsString;
        sPicName := FieldByName('F_sName').AsString;
        with Self do
        begin
          SetLength(ImgList,Len+1);
          SetLength(PicInfo,Len+1);
          SetLength(Lab,Len+1);
          SetLength(LabProg,Len+1);
          SetLength(LabSaveTo,Len+1);
          LabProg[Len] := TLabel.Create(self);
          with LabProg[Len] do
          begin
            Parent := Self;
            Hide;
            Top := Len*10;
          end;
          LabSaveTo[Len] := TLabel.Create(self);
          with LabSaveTo[Len] do
          begin
            Parent := Self;
            Hide;
            Top := Len*10;
            Font.Color := clHighlight;
            Tag := Len;
            Cursor := crHandPoint;
            Caption := '另存为...';
          end;
          Lab[Len] := TLabel.Create(self);
          with Lab[Len] do
          begin
            if Len = 0 then
              Top := Self.pan_gy.Top + Self.pan_gy.Height
            else
              Top := ImgList[Len-1].Top+ImgList[Len-1].Height + 15;
            Parent := Self;
            Caption := Format('产品编号：%s   文件类型：%s',[sPicCpbh,sPicName])+'   (双击图片查看原图)';
            Left := 16;
          end;
          if not FileExists(sTempPath+'jz.gif') then
          begin
            rs := TResourceStream.Create(HInstance,'Loading','MyGIF');
            ForceDirectories(sTempPath);
            rs.SaveToFile(sTempPath+'jz.gif');
            rs.Free;
          end;
          ImgList[Len] := TImage.Create(self);
          with ImgList[Len] do
          begin
            Top := Lab[Len].Top + Lab[Len].Height +5;
            Width := iWidth - 54;
            Height := 150;
            Center := True;
            Left := Lab[Len].Left;
            Transparent := True;
            Visible := False;
            Picture.LoadFromFile(sTempPath+'jz.gif');
            Parent := self;
            Visible := True;
            Hint := '双击查看原图';
            //ImgList[Len].ShowHint := True;      //显示Hint后会被切换到主窗口上,待解决  (猜想原因是Hint和主窗口有联系,此航窗口的父窗口是桌面)
            Tag := Len;
          end;
          PicInfo[Len].m_sPath := sPicPath;
          PicInfo[Len].m_sFileName := '';
          PicInfo[Len].m_sUrlPicPath := '';
        end;
        Inc(Len);
        Next;
      end;
    end;
    if Len >0 then
      Self.pan_jg.Top := Self.ImgList[Len-1].Top + Self.ImgList[Len-1].Height;
  finally
    ADO_Rec.Free;
    ms.Free;
  end;
end;


procedure TFrm_DDMX_DZX.FormShow(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
//  lab: Ti_Label;
//  shape_1,shape_2: TShape;
  btn: TButton;
  str: string;
begin
  Self.VertScrollBar.Position := 0;

  vClose := False;
  Self.DoubleBuffered := True;
  edt_Temp.DoubleBuffered := True;

  case StrToNum(lab_xpl.Caption) of
    0:
    begin
      btn_tsgy.Visible := True;
      lab_xpl.Caption := '无';
    end;
    1:
    begin
      btn_tsgy.Visible := False;
      lab_xpl.Caption := '小批量';
    end;
  end;

  case StrToNum(lab_wxbz.Caption) of
    0: lab_wxbz.Caption := '无';
    1: lab_wxbz.Caption := '有';
  end;

  case StrToNum(lab_jybz.Caption) of
    0: lab_jybz.Caption := '无';
    1: lab_jybz.Caption := '加印';
  end;

  case StrToNum(lab_qy.Caption) of
    0: lab_qy.Caption := '否';
    1: lab_qy.Caption := '是';
    2: lab_qy.Caption := '电子签样';
  end;
  case StrToNum(lab_tsgybz.Caption) of
    0: lab_tsgybz.Caption := '无';
    1: lab_tsgybz.Caption := '有';
  end;

  f_MakeAllow;


  if vCustomID <> 0 then
  begin
    sSqlData := 'Select F_tiDfbbz,F_tiLrbz,F_sSbbbh from BI_CustomOrder a where exists(Select 1 from BI_CustomOrderDetails where F_iID=%d and F_iCustomID=a.F_iID)';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vCustomID]);
    case ADO_Rec.FieldByName('F_tiDfbbz').AsInteger of
      0:lab_dfbbz.Caption := '无';
      1:
        begin
          lab_dfbbz.Caption := '地方版';
          Self.Caption := '地方版订单明细';
        end;
    end;
    if ADO_Rec.FieldByName('F_tiLrbz').AsInteger in  [1,2,3] then
    begin
      str := '';
      case ADO_Rec.FieldByName('F_tiLrbz').AsInteger  of
        1: str := '(手动录入)';
        2: str := '(已匹配)';
        3: str := '(不进行国网匹配)';
      end;
      //lab_SbID.Caption := '(手动录入订单)';
      lab_SbID.LabelCaption := '申报表编号 ';
      lab_SbID.Caption := ADO_Rec.FieldByName('F_sSbbbh').AsString+str ;
    end;
    ADO_Rec.Free;
    sSqlData := 'Select case when IsNull(ltrim(rtrim(a.F_sTsgy)),'''')='''' then b.F_sQttsgyms else a.F_sTsgy end Tsgy, '
      + ' a.F_tiNJBZ from DO_OrderApart  a,BI_CustomOrderDetails b where a.F_tiOrderType=0 and a.F_iOrderID=b.F_iID and a.F_iOrderID=%d and a.F_tiCXBZ=0 ';
    //sSqlData := 'Select IsNull(a.F_sTsgy,b.F_sQttsgyms) Tsgy, a.F_tiNJBZ from DO_OrderApart  a,BI_CustomOrderDetails b where a.F_tiOrderType=0 and a.F_iOrderID=b.F_iID and a.F_iOrderID=%d  ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vCustomID]);
    while not ADO_Rec.Eof do
    begin
      case  ADO_Rec.FieldByName('F_tiNJBZ').AsInteger of
        0:
          lab_qttsgy.Caption := ADO_Rec.FieldByName('Tsgy').AsString;
        1:
          begin
            //lab := Ti_Label.Create(Self);
            //shape_1 := TShape.Create(Self);
            //shape_2 := TShape.Create(Self);
            btn := TButton.Create(Self);
            shape_1.Left := Shape22.Left;
            shape_1.Top := Shape22.Top+Shape22.Height-1;
            shape_1.Visible := True;
            //shape_1.Width := Shape22.Width;
            //shape_1.Height := Shape22.Height;
            //shape_1.Parent := Self;
            shape_2.Left := Shape48.Left;
            shape_2.Top := Shape48.Top+Shape48.Height-1;
            shape_2.Visible := True;
            //shape_2.Width := Shape48.Width;
            //shape_2.Height := Shape48.Height;
            //shape_2.Parent := Self;
            btn.Left := btn_tsgy.Left;
            btn.Width := btn_tsgy.Width;
            btn.Caption := btn_tsgy.Caption;
            btn.Top := btn_tsgy.Top+btn_tsgy.Height+2;
            btn.OnClick := btn_tsgy.OnClick;
            btn.Enabled := btn_tsgy.Enabled;
            btn.Tag := 1;
            btn.Parent := Self;
            pan_gy.Top := shape_1.Top + shape_1.Height-1;
            {lab.LabelCaption := '内件特殊工艺描述  ';
            lab.Caption := ADO_Rec.FieldByName('F_sTsgy').AsString;
            lab.Color := clWhite;
            lab.Left := lab_qttsgy.Left;
            lab.Top := shape_2.Top + 8;
            lab.Parent := Self;
            lab.Visible := True; }
            lab_njtsgy.Caption := ADO_Rec.FieldByName('Tsgy').AsString;
            lab_njtsgy.Left := lab_qttsgy.Left;
            lab_njtsgy.Top := shape_2.Top + 8;
            lab_njtsgy.Visible := True;
          end;
      end;
      ADO_Rec.Next;
    end;
    DisplaySBSX;
  end;
  menu_SaveTo.OnClick := SaveToClick;
  if vTGSHOW  then
  begin
    LoadPic;
    //MyDownLoad := TMyDownLoad.Create(False);
    MyThread := TMyDownLoad.Create(True);
    TMyDownLoad(MyThread).FrmDZX := Self;
    MyThread.Resume;
  end;
end;

procedure TFrm_DDMX_DZX.i_Label13Click(Sender: TObject);
begin
  edt_Temp.Visible := True;
  edt_Temp.Parent := Ti_Label(Sender).Parent;
  edt_Temp.Text := Ti_Label(Sender).Caption;
  edt_Temp.Left := Ti_Label(Sender).Left;
  edt_Temp.Top := Ti_Label(Sender).Top;
  edt_Temp.Height := Ti_Label(Sender).Height;
  if Ti_Label(Sender).Width > edt_Temp.Width then
    edt_Temp.Width := Ti_Label(Sender).Width
  else
    edt_Temp.Width := 150;
end;


procedure TMyDownLoad.idhtp_picWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  if Self.FrmDZX.vClose then
  begin
    TIdHTTP(Sender).Disconnect;
    Abort;
  end;
  case AWorkMode of
    wmRead:;
    wmWrite:;
  end;
  //if AWorkCount  > 100 then
  begin
    if AWorkCount < g_iFileSize then
      Self.FrmDZX.LabProg[g_iCurrent].Caption :=  IntToStr(AWorkCount*100 div g_iFileSize) +'%'
    else
      Self.FrmDZX.LabProg[g_iCurrent].Caption := '100%';
  end;
end;

procedure TMyDownLoad.idhtp_picStatus(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: String);
begin

end;

procedure TMyDownLoad.idhtp_picWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  if Self.FrmDZX.vClose then
  begin
    TIdHTTP(Sender).Disconnect;
    Abort;
  end;
  g_iFileSize:=AWorkCountMax;
  Self.FrmDZX.LabProg[g_iCurrent].Caption := '0%';
end;

procedure TMyDownLoad.idhtp_picWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  if Self.FrmDZX.vClose then
  begin
    TIdHTTP(Sender).Disconnect;
    Abort;
  end;
  g_iFileSize := 0;
end;

procedure TMyDownLoad.DownLoadPic;
var
  ms: TMemoryStream;
  sTempPath,sPicPath,sFullPicPath: string;
  sFileName: string;
  idhtp_pic: TIdHTTP;
  jpg: TJPEGImage;
  rBl: Double;  //长宽比例
  i, j, Len: Integer;
  FileRec: TSearchRec;
function CovFileDate(Fd:_FileTime):TDateTime;
{ 转换文件的时间格式 }
var
  Tct:_SystemTime;
  Temp:_FileTime;
begin
  FileTimeToLocalFileTime(Fd,Temp);
  FileTimeToSystemTime(Temp,Tct);
  CovFileDate:=SystemTimeToDateTime(Tct);
end;

begin
  if Self.FrmDZX.vCustomID = 0 then Exit;
  ms := TMemoryStream.Create;
  jpg := TJPEGImage.Create;
  idhtp_pic :=TIdHTTP.Create(Application);
  idhtp_pic.OnWork := idhtp_picWork;
  idhtp_pic.OnStatus := idhtp_picStatus;
  idhtp_pic.OnWorkBegin := idhtp_picWorkBegin;
  idhtp_pic.OnWorkEnd := idhtp_picWorkEnd;
  try
    sTempPath := GetTempDirectory + c_TempPicPath;
    Sleep(100);
    with Self.FrmDZX do
    begin
      Len := Length(ImgList);
      for i := 0 to Len -1 do
      begin
        if vClose then
          Break;
        g_iCurrent := i;
        //sPicPath := ImgList[i].Hint;
        sPicPath := PicInfo[i].m_sPath;
        //SetLength(LabProg,i+1);
        //LabProg[i] := TLabel.Create(Frm_DDMX_DZX);
        LabProg[i].Show;
        LabProg[i].Top := Lab[i].Top;
        LabProg[i].Left := Lab[i].Left+Lab[i].Width+30;

        //LabProg[i].Caption := '';
       // LabProg[i].Parent := Frm_DDMX_DZX;
        if sPicPath = '' then
        begin
          lab[i].Caption := lab[i].Caption+' 图片下载地址为空!';
          ImgList[i].Visible := False;
          Continue;
        end;
        if UpperCase(StrLeft(sPicPath,4)) = 'HTTP' then
        begin
          sFullPicPath := sPicPath;
          sFileName :=  StrReplace(Copy(sPicPath,8,Length(sPicPath)),'/','\');
        end else
        begin
          sFullPicPath := c_PicUrl+sPicPath;
          sFileName :=  StrReplace(sPicPath,'/','\');
        end;
        PicInfo[i].m_sFileName := sTempPath+sFileName;
        PicInfo[i].m_sUrlPicPath := sFullPicPath;
        if FileExists(sTempPath+sFileName) then
        begin
          if SysUtils.FindFirst(sTempPath+sFileName,faAnyfile,FileRec) = 0 then
          begin
            idhtp_pic.Head(sFullPicPath);               //下载http头
            if idhtp_pic.Response.ContentLength <> FileRec.Size then  //对比文件大小来判断是否需要重新下载
            begin
               ms.Clear;
               idhtp_pic.Get(sFullPicPath,ms);
               ms.SaveToFile(sTempPath+sFileName);
            end;
//            if DaysBetween(CovFileDate(FileRec.FindData.ftLastWriteTime),Now) > 7 then
//            begin
//             if not p_DownloadFile(sTempPath+sFileName,sFileName) then
//             begin
//               ms.Clear;
//               idhtp_pic.Get(c_PicUrl+sPicPath,ms);
//               ms.SaveToFile(sTempPath+sFileName);
//             end;
//            end;
          end;
        end else
        begin
          if not p_DownloadFile(sTempPath+sFileName,sFileName) then
          begin
            ms.Clear;
            idhtp_pic.Get(sFullPicPath,ms);
            if not ForceDirectories(ExtractFilePath(sTempPath + sFileName)) then
              sFileName := '1.jpg';
            ms.SaveToFile(sTempPath+sFileName);
          end;
        end;
        jpg.LoadFromFile(sTempPath+sFileName);
        rBl := jpg.Height / jpg.Width;
        ImgList[i].Top := lab[i].Top + lab[i].Height +5;
        ImgList[i].Width := Trunc(Trunc(ImgList[i].Width * rBl) / rBl);
        ImgList[i].Height := Trunc(ImgList[i].Width * rBl);
        ImgList[i].Proportional := True;
        ImgList[i].Stretch := True;
        ImgList[i].Visible := False;
        ImgList[i].Picture.LoadFromFile(sTempPath+sFileName);
        ImgList[i].OnDblClick := ImgDblClick;
        ImgList[i].PopupMenu := pm_jgp;
        ImgList[i].OnMouseDown := ImgMouseDown;
        ImgList[i].Show;
        LabSaveTo[i].Top := LabProg[i].Top;
        LabSaveTo[i].Left := LabProg[i].Left+LabProg[i].Width+30;
        LabSaveTo[i].OnClick := SaveToClick;
        LabSaveTo[i].Show;

       for j := i to Len -2 do
        begin
          Lab[j+1].Top := ImgList[j].Top +ImgList[j].Height +20 ;
          ImgList[j+1].Top := Lab[j+1].Top + 5 ;
        end;
        pan_jg.Top := ImgList[Len-1].Top + ImgList[Len-1].Height;
      end;
    end;
  except
    //p_MessageBoxDlg('图稿下载失败!请检查网络是否连通再重新打开页面!');
    //SetForegroundWindow(Frm_DDMX_DZX.Handle);
  end;
  if Assigned(idhtp_pic) then idhtp_pic.Free;
  if Assigned(jpg) then jpg.Free;
  if Assigned(ms) then ms.Free;
end;

procedure TMyDownLoad.Execute;
begin
  inherited;
  FreeOnTerminate := True;
  DownLoadPic;

  if Self.FrmDZX.vClose then
    Synchronize(Self.FrmDZX.Free);  //切换到主线程执行窗口释放
  //  SendMessage(Self.FrmDZX.Handle,WM_FREE,0,0);   //发消息到主线程执行窗口释放
end;


procedure TFrm_DDMX_DZX.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  LockWindowUpdate(Handle);
  TForm(Sender).VertScrollBar.Position := TForm(Sender).VertScrollBar.Position +40;
  LockWindowUpdate(0)
end;

procedure TFrm_DDMX_DZX.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
//var
//  i: integer;
begin
  LockWindowUpdate(Handle);
  TForm(Sender).VertScrollBar.Position := TForm(Sender).VertScrollBar.Position -40;
  LockWindowUpdate(0)
{  for i := 0 to Length(ImgList) -1 do
  begin
    ImgList[i].Visible := true;
    Lab[i].Visible := true;
  end;   }
//  Perform(WM_VSCROLL, SB_LINEUP, 0);
end;



procedure TFrm_DDMX_DZX.btn_tsgyClick(Sender: TObject);
var
  sTsgy: string;
  i,iNJBZ: integer;

begin
  Frm_Tsgy_modif := TFrm_Tsgy_modif.Create(Self);
  iNJBZ := 0;
  if TButton(Sender) = btn_tsgy then
    iNJBZ := 0
  else if TButton(Sender) = btn_yzjg then
    iNJBZ := 1;

  case iNJBZ of
    0: sTsgy := lab_qttsgy.Caption;
    1: sTsgy := lab_njtsgy.Caption;
  end;
  CbParamAdd(Frm_Tsgy_modif.cb_gyyq,'特殊工艺');
  for i := 0 to Frm_Tsgy_modif.cb_gyyq.Items.Count -1 do
  begin
    if Pos(Frm_Tsgy_modif.cb_gyyq.Items.Strings[i],sTsgy) > 0 then
      Frm_Tsgy_modif.cb_gyyq.Checked[i] := True;
  end;
  Frm_Tsgy_modif.mmo_tsgy.Text := sTsgy;
  Frm_Tsgy_modif.vCustomID :=  vCustomID;
  Frm_Tsgy_modif.vUpdate := True;
  Frm_Tsgy_modif.vNJBZ := iNJBZ;
  if Frm_Tsgy_modif.ShowModal = mrOk then
  begin
    case iNJBZ of
      0: lab_qttsgy.Caption := Frm_Tsgy_modif.mmo_tsgy.Text;
      1: lab_njtsgy.Caption := Frm_Tsgy_modif.mmo_tsgy.Text;
    end;
  end;
  Frm_Tsgy_modif.Free;
end;

procedure TFrm_DDMX_DZX.ImgDblClick(Sender: TObject);
var
  ImgSrc: TImage;
  sTempPath,sPicPath,sFileName: string;
  Len: Integer;
//  ImgDes: TImage;
//  Frm: TForm;
//  hRect : TRect;
//  bottom: Integer;
//  frame,TitleHeight: Integer;
//  bBig: Boolean;
begin
  ImgSrc := TImage(Sender);
  Len := ImgSrc.Tag;
  sTempPath := GetTempDirectory + c_TempPicPath;
  sPicPath := PicInfo[Len].m_sPath;
  //sFileName :=  StrReplace(sPicPath,'/','\');
  if UpperCase(StrLeft(sPicPath,4)) = 'HTTP' then
  begin
    sFileName :=  StrReplace(Copy(sPicPath,8,Length(sPicPath)),'/','\');
  end else
  begin
    sFileName :=  StrReplace(sPicPath,'/','\');
  end;
  ShellExecute(0,nil,pchar(sTempPath+sFileName),nil,nil,sw_shownormal);
{  SystemParametersInfo(SPI_GETWORKAREA,0,@hRect, 0);    //获取桌面分辨率(不含任务栏)
  Frm := TForm.Create(Self);
  ImgDes := TImage.Create(Frm);
  ImgDes.AutoSize := True;
  ImgDes.Picture.LoadFromFile(sTempPath+sFileName);
  frame := (Width - ClientWidth) div 2;
  TitleHeight := Height - ClientHeight - frame * 2;    //标题栏ymya
//  bottom := GetSystemMetrics(SM_CYSCREEN)-GetSystemMetrics(SM_CYFULLSCREEN)-GetSystemMetrics(SM_CYCAPTION);  //任务栏高度
  bBig := False;
  if hRect.Right > ImgDes.Width then
  begin
    Frm.Left := (hRect.Right - frame * 2 - ImgDes.Width) div 2;
    Frm.Width := ImgDes.Width +frame+1;       // +frame * 2
  end else
  begin
    Frm.Left := 0;
    Frm.Width := hRect.Right;
    bBig := True;
  end;
  if hRect.Bottom  > ImgDes.Height then
  begin
    Frm.Top := (hRect.Bottom - TitleHeight  - frame * 2- ImgDes.Height) div 2;  //- bottom
    Frm.Height := ImgDes.Height + TitleHeight + frame * 2 +1;  //+ bottom
  end else
  begin
    Frm.Top := 0;
    Frm.Height := hRect.Bottom;
    bBig := True;
  end;
  ImgDes.Parent := Frm;
  if not bBig then
  begin
    ImgDes.AutoSize := False;
    ImgDes.Align := alClient;
    ImgDes.Proportional := True;
    ImgDes.Stretch := True;
    ImgDes.Center := True;
  end;
  ImgDes.Visible := True;
  Frm.OnMouseWheelDown := FormMouseWheelDown;
  Frm.OnMouseWheelUp := FormMouseWheelUp;
  Frm.Caption := '原图';
  Frm.ShowModal;
  ImgDes.Free;
  Frm.Free;   }
end;



procedure TFrm_DDMX_DZX.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent :=   0 ;//就是桌面
end;

function TFrm_DDMX_DZX.f_MakeAllow: Boolean;
var
  sSqlData, sAllowName: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  if LoginData.m_iAllowCode >= 0 then
  begin
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID,F_sCode from Set_AllowInfo where F_tiStatus = 1 and F_sCode in (''%s'',''%s'') order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_Allow_DDMX_TSGYXG,c_Allow_DDMX_YZJGXG],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
        sAllowName := ADO_Rec.FieldByName('F_sCode').AsString;
        if sAllowName = c_Allow_DDMX_TSGYXG then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            btn_tsgy.Enabled := True;
            btn_tsgy.Tag := c_Tag_MakeAllow;
          end else
          begin
            btn_tsgy.Enabled := False;
            btn_tsgy.Tag := 0;
          end;
        end else
        if sAllowName = c_Allow_DDMX_YZJGXG then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            btn_yzjg.Enabled := True;
            btn_yzjg.Tag := c_Tag_MakeAllow;
          end else
          begin
            btn_yzjg.Enabled := False;
            btn_yzjg.Tag := 0;
          end;
        end;
        ADO_Rec.Next;
      end;
    end;

    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
  Result := True;
end;

procedure TFrm_DDMX_DZX.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  ExitCode: Cardinal;
begin
  ExitCode := 0;
  if Assigned(MyThread) then
    GetExitCodeThread(MyThread.Handle, ExitCode);
  if ExitCode = STILL_ACTIVE then
  begin
    Action := caHide;
  end else
    Action := caFree;
  vClose := True;
end;


procedure TFrm_DDMX_DZX.btn_bzClick(Sender: TObject);
const
  c_NUM = 0;
  c_STRING = 1;
var
  sSqlData: string;
  sCaption,sPrompt,sValue, sFieldName: string;
  lab: Ti_Label;
  iType: integer;
begin
  lab := nil;
  iType := -1;
  if TButton(Sender).Name = 'btn_bz' then
  begin
    lab := lab_nbbz;
    sCaption := '修改备注';
    sPrompt := '备注：';
    iType := c_STRING;
  end else
  if TButton(Sender).Name = 'btn_fyzjg' then
  begin
    lab := lab_fyzjg;
    sCaption := '修改封印制价格';
    sPrompt := '封印制价格：';
    iType := c_NUM;
  end else
  if TButton(Sender).Name = 'btn_njyzjg' then
  begin
    lab := lab_njyzjg;
    sCaption := '修改内件印制价格';
    sPrompt := '修改内件印制价格：';
    iType := c_NUM;
  end;     
  sFieldName := lab.Hint;
  sValue := lab.Caption;
  if InputQueryEH(sCaption,sPrompt,sValue) then
  begin
    case iType of
       c_NUM:
         begin
           while not IsNum(sValue) do
           begin
             p_MessageBoxDlg('请输入数字!');
             if not InputQueryEH(sCaption,sPrompt,sValue) then exit
           end;
           sSqlData := 'Update BI_CustomOrderDetails set %s = %s where F_iID=%d ';
         end;
       c_STRING: sSqlData := 'Update BI_CustomOrderDetails set %s = ''%s'' where F_iID=%d ';
    end;
    try
      DM_DataBase.ExecQuery(sSqlData,[sFieldName,sValue,vCustomID],True);
      lab.Caption := sValue;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('添加失败:'+E.message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  end;

end;

procedure TFrm_DDMX_DZX.btn_yzjgClick(Sender: TObject);
var
  sCaption,sSqlData: string;
  asPrompt,asValue:array of string;
begin
  sCaption := '印制价格修改';
  SetLength(asPrompt,2);
  asPrompt := VarArrayOf(['封印制单价:    印制单价:'+lab_yzjg.Caption,'内件印制单价:']);
  SetLength(asValue,2);
  asValue := VarArrayOf([lab_fyzjg.Caption,lab_njyzjg.Caption]);
  if InputQueryEH(sCaption,asPrompt,asValue,[0,0]) then
  begin
    while (not IsNum(asValue[0])) or (not IsNum(asValue[1])) do
    begin
      p_MessageBoxDlg('请输入数字!');
      if not InputQueryEH(sCaption,asPrompt,asValue,[0,0]) then exit;
    end;
    while not (StrToNum(lab_yzjg.Caption) = StrToNum(StrToNum(asValue[0])+StrToNum(asValue[1])) ) do
    begin
      p_MessageBoxDlg('修改失败:封和内件印制价格之和必须等于印制价格!');
      if not InputQueryEH(sCaption,asPrompt,asValue,[0,0]) then exit;
    end;
    sSqlData := 'Update BI_CustomOrderDetails set F_mNBFYZJG = %s where F_iID=%d ';
    sSqlData := sSqlData + ' Update BI_CustomOrderDetails set F_mNBNJYZJG = %s where F_iID=%d ';
    try
      DM_DataBase.ExecQuery(sSqlData,[StrToNum(asValue[0]),vCustomID,StrToNum(asValue[1]),vCustomID],True);
      lab_fyzjg.Caption := StrToNum(asValue[0]);
      lab_njyzjg.Caption := StrToNum(asValue[1]);
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('添加失败:'+E.message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  end;
end;

procedure TFrm_DDMX_DZX.WndProc(var Message: TMessage);
begin
  with Message do
    case Msg of
      WM_FREE:
      begin
        Self.Free;
        Exit;
      end;
    end;

  inherited WndProc(Message);

end;

procedure TFrm_DDMX_DZX.FileSaveTo(AsFileName: string);
var
  sFileName: string;
begin
  with dlg_SavePic do
  begin
    DefaultExt := ExtractFileExt(AsFileName);
    FileName := ExtractFileName(AsFileName);
    if Execute then
    begin
      sFileName := ExtractFileName(AsFileName);;
      if not CopyFileTo(AsFileName,FileName) then
      begin
        if p_MessageBoxDlg(sFileName+' 已存在。'+#13#10+'要替换它吗?','确认另存为',MB_ICONINFORMATION + MB_YESNO) = IDYES then
        begin
          CopyFile(PChar(AsFileName),PChar(FileName),False);
        end;
      end;
    end;
  end;
end;

procedure TFrm_DDMX_DZX.SaveToClick(Sender: TObject);
var
  n: Integer;
begin
  n := TControl(Sender).Tag;
  if PicInfo[n].m_sFileName <> '' then
    FileSaveTo(PicInfo[n].m_sFileName);
end;

procedure TFrm_DDMX_DZX.ImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  menu_SaveTo.Tag := TControl(Sender).Tag;
end;

procedure TFrm_DDMX_DZX.DisplaySBSX;
var
  sSqlData,sSXMC,sSXQZ: string;
  ADO_Rec: TADOQuery;
  shp_SXMC,shp_SXQZ:TShape;
  lab_SXQZ: Ti_Label;
begin
  sSqlData := 'Select * from BI_CustomOrderSBSX where F_iCustomDetailsID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vCustomID]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
  begin
    sSXMC := ADO_Rec.FieldByName('F_sSXMC').AsString;
    sSXQZ := ADO_Rec.FieldByName('F_sSXQZ').AsString;
    shp_SXMC := TShape.Create(Self);
    shp_SXMC.Parent := Self;
    with shp_SXMC do
    begin
      Parent := Self;
      Left := Shape22.Left;
      Top := pan_gy.Top;
      Width := Shape22.Width;
      Height := Shape22.Height;
      Brush.Color := Shape22.Brush.Color;
    end;
    shp_SXQZ := TShape.Create(Self);
    with shp_SXQZ do
    begin
      Parent := Self;
      Left := Shape48.Left;
      Top := pan_gy.Top;
      Width := Shape48.Width;
      Height := Shape48.Height;
    end;
    lab_SXQZ := Ti_Label.Create(Self);
    with lab_SXQZ do
    begin
      Parent := Self;
      Caption := sSXQZ;
      LabelCaption := sSXMC+' ';
      Left := lab_qttsgy.Left;
      Top := shp_SXQZ.Top + 8;
      Color := lab_qttsgy.Color;
      ParentColor := lab_qttsgy.ParentColor;
      OnMouseEnter := lab_qttsgy.OnMouseEnter;
      LabelPosition := lab_qttsgy.LabelPosition;
      LabelSpacing := lab_qttsgy.LabelSpacing;
      Visible := True;
    end;

    shp_SXQZ.Parent := Self;
    shp_SXMC.Top := pan_gy.Top;
    shp_SXQZ.Top := pan_gy.Top;
    pan_gy.Top := shp_SXMC.Top + shp_SXMC.Height-1;
  end;

  if Assigned(ADO_Rec) then ADO_Rec.Free;
end;

end.


