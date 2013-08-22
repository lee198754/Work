unit PubDef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, RzButton, ShellAPI,
  IniFiles, iGrid, RzRadChk, RzTreeVw, RzGrids, ComCtrls;

const
  //����ͼ
  //ͼ��
  PF_StockOrder = '�ɹ�����.ico';
  PF_StockIn = '�ɹ��ջ�.ico';
  PF_StockBack = '�ɹ��˻�.ico';
  PF_Pay = '���.ico';

  PF_Provider = '��Ӧ��.ico';
  PF_Customer = '�ͻ�.ico';
  PF_Res = '��Ʒ.ico';
  PF_Producer = '��������.ico';

  PF_SaleOrder = '���۶���.ico';
  PF_SaleOut = '���۳���.ico';
  PF_SaleBack = '�����˻�.ico';
  PF_Gather = '�տ.ico';

  PF_StockManage = '��������.ico';
  PF_SaleManage = '���۹���.ico';
  PF_KCManage = '������.ico';
  PF_InfoManage = '��Ϣ����.ico';
  PF_FundManage = '�ʽ����.ico';

  //PF_Active = '����.ico';
  //PF_UnActive = 'δ����.ico';

  PF_StockLog = 'ʳƷ����̨��.ico';
  PF_SaleLog = 'ʳƷ����̨��.ico';
  PF_Quality = '�����ڲ�ѯ.ico';
  PF_CT_Rep_Provider = '��֤����.ico';
  PF_CT_Rep_Res = '��Ʊ����.ico';
  PF_StockSaleLog = '��ܲ�ѯ.ico';

  //���
  //PF_N_L = '��.bmp';
  //PF_N_C = '��.bmp';
  //PF_N_R = '��.bmp';

  //������
  //������ͼ��
  PF_Res32 = '��Ʒ32.ico';
  PF_Provider32 = '��Ӧ��32.ico';
  PF_Customer32 = '�ͻ�32.ico';
  PF_StockOrder32 = '�ɹ�����32.ico';
  PF_StockIn32 = '�ɹ��ջ�32.ico';
  PF_Pay32 = '���32.ico';
  PF_SaleOrder32 = '���۶���32.ico';
  PF_SaleOut32 = '���۳���32.ico';
  PF_Gather32 = '�տ32.ico';

procedure p_LoadImgFile(Img: TImage; sPF: string);
procedure G_SetUI(Frm: TForm);

implementation

procedure p_LoadImgFile(Img: TImage; sPF: string);
var
  sFile: string;
begin
  sFile := ExtractFilePath(Application.ExeName) + 'ͼ��\' + sPF;
  if FileExists(sFile) then
  begin
    if SameText(ExtractFileExt(sFile), '.ico') then
      Img.Picture.LoadFromFile(sFile)
    else
      Img.Picture.Bitmap.LoadFromFile(sFile);
  end;
end;

procedure G_SetUI(Frm: TForm);
var
  i: integer;
  Win: TWinControl;
begin
  Frm.Color := $00F9E9DD;  //clSkyBlue

  Win := Frm;
  for i := 0 to Win.ComponentCount - 1 do
  begin
    //�����ɫ
    if SameText(Win.Components[i].ClassName, 'TGroupBox')
      or SameText(Win.Components[i].ClassName, 'TRzGroupBox') then
    begin
      if Win.Components[i].Tag = 0 then
        TGroupBox(Win.Components[i]).Color := $00F9E9DD;
    end;

    if SameText(Win.Components[i].ClassName, 'TShape') then
    begin
      if Win.Components[i].Tag = 0 then
        TShape(Win.Components[i]).Brush.Color := $00F9E9DD;
    end;

    if SameText(Win.Components[i].ClassName, 'TPanel')
      or SameText(Win.Components[i].ClassName, 'TRzPanel') then
    begin
      if Win.Components[i].Tag = 0 then
        TPanel(Win.Components[i]).Color := $00F9E9DD;
    end;

    //������ɫ
    if SameText(Win.Components[i].ClassName, 'Ti_StgEdit') then
    if Ti_StgEdit(Win.Components[i]).Tag = 0 then
    begin                                           //clSkyBlue
      Ti_StgEdit(Win.Components[i]).FixedColColor := $00F9E9DD;
      Ti_StgEdit(Win.Components[i]).FixedColor := $00F9E9DD;
    end;

    //��������ɫ
    {if SameText(Win.Components[i].ClassName, 'TToolbar') then
    begin
      if Frm_Pub_Resource <> nil then
        TToolbar(Win.Components[i]).OnCustomDraw := Frm_Pub_Resource.ToolBarCustomDraw;
      TToolbar(Win.Components[i]).Color := $D4D0D4
    end;}

    //��ť��ɫ
    {}if SameText(Win.Components[i].ClassName, 'TRzButton') then
    begin                                           //clSkyBlue
      if TRzButton(Win.Components[i]).Tag = 0 then
      begin
        TRzButton(Win.Components[i]).HotTrack := true;
        TRzButton(Win.Components[i]).Color := cl3DLight;  //
      end;  
    end;
  end;
end;

end.
