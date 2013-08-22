unit uFraWorkerManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, StdCtrls, ButtonEdit, ComCtrls, RzListVw, ExtCtrls,
  RzPanel, uDM_DataBase, RzRadChk, Menus,ADODB, ImgList, RzCmboBx,
  iComboBox;

type
  TFra_WorkerManage = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    lv_WorkerList: TRzListView;
    RzPanel1: TRzPanel;
    edt_Name: Ti_TxtFilter;
    btn_add: TRzButton;
    edt_Age: Ti_TxtFilter;
    rb_Sex1: TRzRadioButton;
    rb_Sex2: TRzRadioButton;
    lab_Sex: TLabel;
    pm_lv_Worker: TPopupMenu;
    menu_Del: TMenuItem;
    ImageList1: TImageList;
    edt_Department: Ti_TxtFilter;
    btn_mod: TRzButton;
    btn_Del: TRzButton;
    cbb_Sex: Ti_ComboBox;
    procedure btn_addClick(Sender: TObject);
    procedure menu_DelClick(Sender: TObject);
    procedure lv_WorkerListColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure lv_WorkerListCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure edt_AgeKeyPress(Sender: TObject; var Key: Char);
    procedure lv_WorkerListClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_modClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshLv;
  end;

implementation

uses
  uPub_Type, uPub_Func;

{$R *.dfm}

procedure TFra_WorkerManage.btn_addClick(Sender: TObject);
var
  SqlData: string;
begin
  if Trim(edt_Name.Text) = '' then Exit;
  lv_WorkerList.Items.Add.Caption := edt_Name.Text;
  SqlData := Format('Insert into BI_WorkerList (F_sName,F_iSex,F_sDepartment) Values (''%s'',%d,''%s'')',[edt_Name.Text,cbb_Sex.ItemIndex,edt_Department.Text]);
  with DM_DataBase.ADO_DataRec do
  begin
    Close;
    SQL.Text := SqlData;
    ExecSQL;
  end;
  RefreshLv;
end;

procedure TFra_WorkerManage.RefreshLv;
var
  sSex: string;
begin
  with DM_DataBase.ADO_DataRec do
  begin
    Close;
    SQL.Text := 'Select * from BI_WorkerList';
    Open;
    if RecordCount >0 then
    begin
      lv_WorkerList.Clear;
      First;
      while not Eof do
      begin
        lv_WorkerList.Items.Add.Caption := FieldByName('F_sName').AsString;
        case FieldByName('F_iSex').AsInteger of
          0:sSex := '男';
          1:sSex := '女';
        end;
        lv_WorkerList.Items.Item[lv_WorkerList.Items.Count -1].SubItems.Add(sSex);
        lv_WorkerList.Items.Item[lv_WorkerList.Items.Count -1].SubItems.Add(FieldByName('F_sDepartment').AsString);
        lv_WorkerList.Items.Item[lv_WorkerList.Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
        Next;
      end;

    end;

  end;
end;

procedure TFra_WorkerManage.menu_DelClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  SelItem: TListItem;
  sID: string;
  SqlData: string;
begin
  SelItem := lv_WorkerList.Selected;
  if not Assigned(SelItem) then Exit;
  sID := SelItem.SubItems.Strings[SelItem.SubItems.Count-1];
  SqlData := 'F_iID='+sID;
try
  ADO_Rec := TADOQuery.Create(Self);
  DM_DataBase.GetTableData(ADO_Rec,'BI_WorkerList',SqlData);
  ADO_Rec.Delete;
  lv_WorkerList.Selected.Delete;
finally
  ADO_Rec.Free;
end;
end;

procedure TFra_WorkerManage.lv_WorkerListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
end;

procedure TFra_WorkerManage.lv_WorkerListCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);

end;

procedure TFra_WorkerManage.edt_AgeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9')) then
    Key := #0;

end;

procedure TFra_WorkerManage.lv_WorkerListClick(Sender: TObject);
var
  SelItem: TListItem;
begin
  SelItem := lv_WorkerList.Selected;
  if not Assigned(SelItem) then Exit;
  edt_Name.Text := SelItem.Caption;
  cbb_Sex.ItemIndex := cbb_Sex.IndexOf(Trim(SelItem.SubItems.Strings[0]));
  edt_Department.Text := SelItem.SubItems.Strings[1];
end;

procedure TFra_WorkerManage.btn_DelClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  SelItem: TListItem;
  sID: string;
  SqlData: string;
begin
  SelItem := lv_WorkerList.Selected;
  if not Assigned(SelItem) then Exit;
  if Application.MessageBox(PChar('是否删除 '+SelItem.Caption),'提示',MB_YESNO+MB_ICONINFORMATION)= IDNO then Exit;
  sID := SelItem.SubItems.Strings[SelItem.SubItems.Count-1];
  SqlData := 'F_iID='+sID;
try
  ADO_Rec := TADOQuery.Create(Self);
  DM_DataBase.GetTableData(ADO_Rec,'BI_WorkerList',SqlData);
  ADO_Rec.Delete;
  lv_WorkerList.Selected.Delete;
finally
  ADO_Rec.Free;
end;
end;

procedure TFra_WorkerManage.btn_modClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  SelItem: TListItem;
  sID: string;
  SqlData: string;
begin
  SelItem := lv_WorkerList.Selected;
  if not Assigned(SelItem) then Exit;
  if Trim(edt_Name.Text) = '' then
  begin
    Application.MessageBox('姓名不能为空!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  sID := SelItem.SubItems.Strings[SelItem.SubItems.Count-1];
  SqlData := 'F_iID='+sID;
try
  ADO_Rec := TADOQuery.Create(Self);
  DM_DataBase.GetTableData(ADO_Rec,'BI_WorkerList',SqlData);
  ADO_Rec.Edit;
  ADO_Rec.FieldByName('F_sName').AsString := edt_Name.Text;
  ADO_Rec.FieldByName('F_iSex').AsInteger := cbb_Sex.ItemIndex;
  ADO_Rec.FieldByName('F_sDepartment').AsString := edt_Department.Text;
  ADO_Rec.Post;
  SelItem.Caption := edt_Name.Text;
  SelItem.SubItems.Strings[0] := cbb_Sex.Text;
  SelItem.SubItems.Strings[1] := edt_Department.Text;
finally
  ADO_Rec.Free;
end;
end;

end.

