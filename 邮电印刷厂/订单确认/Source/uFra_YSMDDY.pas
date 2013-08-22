unit uFra_YSMDDY;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ButtonEdit, RM_System, RM_Common, RM_Class;

type
  TFra_YSMDDY = class(TFrame)
    edt_njpm: Ti_TxtFilter;
    edt_sjdh: Ti_TxtFilter;
    edt_sjdz: Ti_TxtFilter;
    edt_sjrxm: Ti_TxtFilter;
    edt_sjdwmc: Ti_TxtFilter;
    btn_qjysmddy: TButton;
    btn_sjysmd: TButton;
    btn_hjysmddy: TButton;
    Button2: TButton;
    Button3: TButton;
    edt_njsl: Ti_TxtFilter;
    edt_ZL: Ti_TxtFilter;
    edt_FY: Ti_TxtFilter;
    edt_SJRY: Ti_TxtFilter;
    btn_jt: TButton;
    Button4: TButton;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    rmr_qmjz: TRMReport;
    rmr_hmjz: TRMReport;
    rmr_qmjz_old: TRMReport;
    rmr_hmjz_old: TRMReport;
    procedure btn_qjysmddyClick(Sender: TObject);
    procedure btn_sjysmdClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btn_jtClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    procedure p_SetPrint(Rmrprt:TRMReport;sName, sValue: string);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uPub_Type, uPub_Text, uPub_Func, PubStr;

{$R *.dfm}

var
  aYZZL: TYZZL;
  aYZFY: TYZFY;
  vsSJRY: string;
  vsTempPath: string;


procedure TFra_YSMDDY.btn_qjysmddyClick(Sender: TObject);
var
  iJZ, i: Integer;
  sName,sFileName: string;
  Report:TRMReport;
begin
  if TButton(Sender) = btn_qjysmddy then
    iJZ := 0
  else if TButton(Sender) = btn_hjysmddy then
    iJZ := 1;
  case iJZ of
    0:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_DD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
        if FileExists(sFileName) then
          rmr_qmjz.LoadFromFile(sFileName);
        Report := rmr_qmjz;
        //rmr_qmjz.PrepareReport;
        //rmr_qmjz.ShowReport;
      end;
    1:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_DD_HMJZ_ExeName;//c_WorkOrder_PrintExeName;
        if FileExists(sFileName) then
          rmr_hmjz.LoadFromFile(sFileName);
        Report := rmr_hmjz;
        //rmr_hmjz.PrepareReport;
        //rmr_hmjz.ShowReport;
      end;
  else
    Exit;
  end;
  for i := 0 to self.ComponentCount -1 do
  begin
    if Self.Components[i] is Ti_TxtFilter then
    begin
      sName := 'mmo_'+ Copy(Ti_TxtFilter(Self.Components[i]).Name,5,Length(Ti_TxtFilter(Self.Components[i]).Name));
      p_SetPrint(Report,sName,Ti_TxtFilter(Self.Components[i]).Text);
    end;
  end;
  Report.PrepareReport;
  Report.ShowReport;
end;

procedure TFra_YSMDDY.btn_sjysmdClick(Sender: TObject);
var
  iJZ, i: Integer;
  sName,sFileName: string;
  Report:TRMReport;
begin
  iJZ := TButton(Sender).Tag;
  case iJZ of
    0:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_DD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
        if FileExists(sFileName) then
          rmr_qmjz.LoadFromFile(sFileName);
        Report := rmr_qmjz;//rmr_qmjz.DesignReport;
      end;
    1:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_DD_HMJZ_ExeName;//c_WorkOrder_PrintExeName;
        if FileExists(sFileName) then
          rmr_hmjz.LoadFromFile(sFileName);
        Report := rmr_hmjz;//rmr_hmjz.DesignReport;
      end;
  else
    Exit;
  end;
  for i := 0 to self.ComponentCount -1 do
  begin
    if Self.Components[i] is Ti_TxtFilter then
    begin
      sName := 'mmo_'+ Copy(Ti_TxtFilter(Self.Components[i]).Name,5,Length(Ti_TxtFilter(Self.Components[i]).Name));
      p_SetPrint(Report,sName,Ti_TxtFilter(Self.Components[i]).Text);
    end;
  end;
  Report.DesignReport;

end;

procedure TFra_YSMDDY.Button3Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to self.ComponentCount -1 do
  begin
    if Self.Components[i] is Ti_TxtFilter then
    begin
      Ti_TxtFilter(Self.Components[i]).Text := '';
    end;
  end;
end;

procedure TFra_YSMDDY.p_SetPrint(Rmrprt: TRMReport; sName, sValue: string);
var
  rmMemo: TRMView;
begin
  rmMemo := Rmrprt.FindObject(sName);
  if rmMemo <> nil then
    TRMMemoView(rmMemo).DataField := sValue;

end;

procedure TFra_YSMDDY.FraShow;
begin
  aYZZL.m_rPK  := c_ZL_PK;
  aYZZL.m_rXK := c_ZL_XK;
  aYZZL.m_rXF  := c_ZL_XF;
  aYZZL.m_rNJ  := c_ZL_NJ;

  aYZFY.m_rPK  := c_FY_PK;
  aYZFY.m_rXK  := c_FY_XK;
  aYZFY.m_rXF  := c_FY_XF;
  aYZFY.m_rNJ  := c_FY_NJ;
  vsTempPath := GetTempDirectory+'YDPrint\YSMD\';
  if not DirectoryExists(vsTempPath) then
    ForceDirectories(vsTempPath);
  rmr_qmjz.SaveToFile(vsTempPath+c_Temp_QMJZ_ExeName);
  rmr_hmjz.SaveToFile(vsTempPath+c_Temp_HMJZ_ExeName);

  vsSJRY := c_YSMD_SJRY;
end;

procedure TFra_YSMDDY.btn_jtClick(Sender: TObject);
var
  aRecField : TArrSelectField;
  i: Integer;
  sSHRDH,sSHRSJ: string;
begin
  aRecField := f_ShowSelectSHXX(edt_njpm.Text);
  sSHRDH := '';
  sSHRSJ := '';
  for i := 0 to Length(aRecField) -1 do
  begin
    if aRecField[i].m_sName = '机构名称' then
      edt_sjdwmc.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '产品编号' then
      edt_njpm.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '收货人姓名' then
      edt_sjrxm.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '收货人地址' then
      edt_sjdz.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '收货人电话' then
      sSHRDH := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '收货人手机' then
      sSHRSJ := aRecField[i].m_sValue;
  end;
  if (sSHRSJ <> '') and (sSHRDH <> '') then
    sSHRSJ := sSHRSJ + '(' + sSHRDH + ')'
  else
    sSHRSJ := sSHRSJ + sSHRDH;
  edt_sjdh.Text := sSHRSJ;
end;

procedure TFra_YSMDDY.Button4Click(Sender: TObject);
var
  sFileName: string;
  iJZ: integer;
  sText , sCaption ,AButtom ,BButtom: string;
begin
  sText := '请选择要导入哪种模版：';
  sCaption := '提示';
  AButtom := '前面进纸';
  BButtom := '后面进纸';
  case f_SelectDlg(sText,sCaption,AButtom,BButtom) of
    mrYes: iJZ := 0;
    mrNo: iJZ := 1;
  else
    Exit;
  end;
  if OpenDialog1.Execute then
  begin
    case iJZ of
      0:
        begin
          sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
          if not FileExists(sFileName) then
            ForceDirectories(ExtractFilePath(sFileName));
          CopyFile(PChar(OpenDialog1.FileName),PChar(sFileName),False);
        end;
      1:
        begin
          sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_HMJZ_ExeName;
          if not FileExists(sFileName) then
            ForceDirectories(ExtractFilePath(sFileName));
          CopyFile(PChar(OpenDialog1.FileName),PChar(sFileName),False);
        end;
    end;
    p_MessageBoxDlg('导入成功!')
  end;
end;

procedure TFra_YSMDDY.Button5Click(Sender: TObject);
var
  sFileName: string;
  iJZ: integer;
  sText , sCaption ,AButtom ,BButtom: string;
begin
  sText := '请选择要清空哪种模版：';
  sCaption := '提示';
  AButtom := '前面进纸';
  BButtom := '后面进纸';
  case f_SelectDlg(sText,sCaption,AButtom,BButtom) of
    mrYes: iJZ := 0;
    mrNo: iJZ := 1;
  else
    Exit;
  end;
  case iJZ of
    0:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
        if FileExists(sFileName) then
          DeleteFile(sFileName);
        if FileExists(vsTempPath+c_Temp_QMJZ_ExeName) then
          rmr_qmjz.LoadFromFile(vsTempPath+c_Temp_QMJZ_ExeName);
      end;
    1:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_HMJZ_ExeName;
        if FileExists(sFileName) then
          DeleteFile(sFileName);
        if FileExists(vsTempPath+c_Temp_HMJZ_ExeName) then
          rmr_hmjz.LoadFromFile(vsTempPath+c_Temp_HMJZ_ExeName);
      end;
  end;
  p_MessageBoxDlg('清空成功!')
end;

end.
