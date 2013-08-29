unit FindDataFrom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFrom, StdCtrls, Buttons, cxGraphics, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxRadioGroup,
  Db, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, XPMenu;

type
  TFieldobject = class
  private
    fFieldName:String;
    fFieldCaption:String;
    fFieldType:TFieldType;
    fFieldLen:Integer;
  public
    Property FieldName:String read fFieldName write fFieldName;
    property FieldCaption :String read fFieldCaption write fFieldCaption;
    Property FieldType:TFieldType read fFieldType write fFieldType;
    Property FieldLen:Integer read fFieldLen write fFieldLen;
  end;
  
  TFindData_Frm = class(TBase_Frm)
    btn1: TBitBtn;
    btn2: TBitBtn;
    cbbF1: TcxComboBox;
    cxtxtdtFV1: TcxTextEdit;
    cbbF2: TcxComboBox;
    cxtxtdtFV2: TcxTextEdit;
    rband: TcxRadioButton;
    rbor: TcxRadioButton;
  private
    fFields:TStringList;

  public
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;

    function AddField(FieldName,Fieldcaption:String
        ;FieldType:TFieldType;FieldLen:Integer):Boolean;
    function ExistsField(fieldName:String):Boolean;

    function AddDefaultField1(FieldName,Fieldcaption:String
        ;FieldType:TFieldType;FieldLen:Integer):Boolean;
    function AddDefaultField2(FieldName,Fieldcaption:String
        ;FieldType:TFieldType;FieldLen:Integer):Boolean;
  end;

var
  FindData_Frm: TFindData_Frm;

implementation

{$R *.dfm}

{ TFindData_Frm }

function TFindData_Frm.AddDefaultField1(FieldName, Fieldcaption: String;
  FieldType: TFieldType; FieldLen: Integer): Boolean;
begin
  Result := AddField(FieldName,Fieldcaption,FieldType,FieldLen);
  if Result  Then
  Begin
    cbbF1.Text := Fieldcaption;
  End;
end;

function TFindData_Frm.AddDefaultField2(FieldName, Fieldcaption: String;
  FieldType: TFieldType; FieldLen: Integer): Boolean;
begin
  Result := AddField(FieldName,Fieldcaption,FieldType,FieldLen);
  if Result  Then
  Begin
    cbbF2.Text := Fieldcaption;
  End;
end;

function TFindData_Frm.AddField(FieldName, Fieldcaption: String;
  FieldType: TFieldType; FieldLen: Integer): Boolean;
var
  FieldObj:TFieldobject;
begin
  Result := False;
  if Self.ExistsField(FieldName) Then Exit;
  FieldObj := TFieldobject.Create;
  FieldObj.FieldName    := Fieldname;
  FieldObj.FieldCaption := Fieldcaption;
  FieldObj.FieldType    := FieldType;
  FieldObj.FieldLen     := FieldLen;
  fFields.AddObject(FieldName,FieldObj);
  cbbF1.Properties.Items.Add(Fieldcaption);
  Result := True;
end;

constructor TFindData_Frm.Create(AOwner: TComponent);
begin
  inherited;
  fFields := TStringList.Create;
end;

destructor TFindData_Frm.Destroy;
begin
  inherited;
  fFields.Free;
end;

function TFindData_Frm.ExistsField(fieldName: String): Boolean;
var
  i:integer;
begin
  Result := False;
  for i := 0 To fFields.Count -1 Do
  Begin
    if TFieldobject(fFields.Objects[i]).FieldName =  fieldName  Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

end.
