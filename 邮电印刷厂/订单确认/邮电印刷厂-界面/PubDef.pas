unit PubDef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, RzButton, ShellAPI,
  IniFiles, iGrid, RzRadChk, RzTreeVw, RzGrids, ComCtrls;

const
  //导航图
  //图标
  PF_StockOrder = '采购订单.ico';
  PF_StockIn = '采购收货.ico';
  PF_StockBack = '采购退货.ico';
  PF_Pay = '付款单.ico';

  PF_Provider = '供应商.ico';
  PF_Customer = '客户.ico';
  PF_Res = '商品.ico';
  PF_Producer = '生产厂商.ico';

  PF_SaleOrder = '销售订单.ico';
  PF_SaleOut = '销售出库.ico';
  PF_SaleBack = '销售退货.ico';
  PF_Gather = '收款单.ico';

  PF_StockManage = '进货管理.ico';
  PF_SaleManage = '销售管理.ico';
  PF_KCManage = '库存管理.ico';
  PF_InfoManage = '信息管理.ico';
  PF_FundManage = '资金管理.ico';

  //PF_Active = '激活.ico';
  //PF_UnActive = '未激活.ico';

  PF_StockLog = '食品进货台帐.ico';
  PF_SaleLog = '食品销售台帐.ico';
  PF_Quality = '保质期查询.ico';
  PF_CT_Rep_Provider = '索证管理.ico';
  PF_CT_Rep_Res = '索票管理.ico';
  PF_StockSaleLog = '监管查询.ico';

  //面板
  //PF_N_L = '左.bmp';
  //PF_N_C = '中.bmp';
  //PF_N_R = '右.bmp';

  //主窗体
  //工具栏图标
  PF_Res32 = '商品32.ico';
  PF_Provider32 = '供应商32.ico';
  PF_Customer32 = '客户32.ico';
  PF_StockOrder32 = '采购订单32.ico';
  PF_StockIn32 = '采购收货32.ico';
  PF_Pay32 = '付款单32.ico';
  PF_SaleOrder32 = '销售订单32.ico';
  PF_SaleOut32 = '销售出库32.ico';
  PF_Gather32 = '收款单32.ico';

procedure p_LoadImgFile(Img: TImage; sPF: string);
procedure G_SetUI(Frm: TForm);

implementation

procedure p_LoadImgFile(Img: TImage; sPF: string);
var
  sFile: string;
begin
  sFile := ExtractFilePath(Application.ExeName) + '图标\' + sPF;
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
    //面板颜色
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

    //网格颜色
    if SameText(Win.Components[i].ClassName, 'Ti_StgEdit') then
    if Ti_StgEdit(Win.Components[i]).Tag = 0 then
    begin                                           //clSkyBlue
      Ti_StgEdit(Win.Components[i]).FixedColColor := $00F9E9DD;
      Ti_StgEdit(Win.Components[i]).FixedColor := $00F9E9DD;
    end;

    //工具栏颜色
    {if SameText(Win.Components[i].ClassName, 'TToolbar') then
    begin
      if Frm_Pub_Resource <> nil then
        TToolbar(Win.Components[i]).OnCustomDraw := Frm_Pub_Resource.ToolBarCustomDraw;
      TToolbar(Win.Components[i]).Color := $D4D0D4
    end;}

    //按钮颜色
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
