unit SkinEQGrid;

interface

uses Classes,Controls,Graphics,
     WinSkinData,winsubclass,
     cxStyles,cxControls,cxEdit, cxGridCustomView, cxGrid,
     cxGridTableView,cxDropDownEdit,cxCheckBox,cxLookAndFeels,cxpc,ExtCtrls,Forms;

type
TmyGridTableViewAccess = class(TcxGridTableView);
TmycxCustomEdit = class(TcxCustomEdit);
procedure InitStyle(SD:Tskindata);
procedure DoSkinControl(Sender: TComponent; SkinData: TSkinData; Form,Control: TControl;
  ControlClass: String; var SkinnedControl: TComponent);overload;

procedure DoSkinControl(Control: TControl);overload;
procedure DoSkinChanged(Sender: TObject);

var skinstyle:TcxStyle;
    SData:Tskindata;

implementation

//Replace cxgrid styles with skinstyle
procedure DoSkinControl(Sender: TComponent; SkinData: TSkinData; Form,Control: TControl;
  ControlClass: String; var SkinnedControl: TComponent);
var cxgrid:TcxCustomGrid;
    i:integer;
    Styles: TcxGridTableViewStyles;
begin
   if control is TcxGrid then begin
     cxgrid:=TcxGrid(control);
     cxgrid.LookAndFeel.Kind := lfUltraFlat;
     cxgrid.LookAndFeel.NativeStyle := False;
     for i:= 0 to cxgrid.ViewCount-1 do begin
       if cxgrid.Views[i] is TcxGridTableView then begin
          Styles:=TcxGridTableViewStyles(TmyGridTableViewAccess(cxgrid.Views[i]).Styles);
          Styles.Header:=skinstyle;
          Styles.GroupByBox :=skinstyle;
          styles.Indicator:=skinstyle;
          styles.Footer:=skinstyle;
       end;
     end;
   end
   else if control is TcxCustomDropDownEdit then begin
      TmycxCustomEdit(control).style.borderstyle:=   ebsflat;
      SkinnedControl:=Tskincombox.create(control);
   end
   else if control is TcxCustomCheckBox then begin
      TcxCustomCheckBox(control).style.TransparentBorder:= false;
   end;
end;

procedure DoSkinChanged(Sender: TObject);
begin
  if sdata.active then
    skinstyle.Color:=sdata.colors[csButtonFace]
  else
    skinstyle.Color:=clbtnface;
end;

procedure InitStyle(SD:Tskindata);
begin
   sdata:=sd;
   skinstyle:=TcxStyle.create(sd.Owner);    
   skinstyle.Color:=sd.colors[csButtonFace];
   
end;

procedure DoSkinControl(Control: TControl);
var cxgrid:TcxCustomGrid;
    i:integer;
    Styles: TcxGridTableViewStyles;
begin
   if control is TcxGrid then begin
     cxgrid:=TcxGrid(control);
     //cxgrid.LookAndFeel.Kind := lfFlat;
     cxgrid.LookAndFeel.Kind := lfOffice11;  //2013.09.03 lpj改:TcxGrid风格样式
     cxgrid.LookAndFeel.NativeStyle := False;
     for i:= 0 to cxgrid.ViewCount-1 do begin
       if cxgrid.Views[i] is TcxGridTableView then begin
          Styles:=TcxGridTableViewStyles(TmyGridTableViewAccess(cxgrid.Views[i]).Styles);
          Styles.Header:=skinstyle;
          styles.Indicator:=skinstyle;
          Styles.GroupByBox :=skinstyle;
          styles.Footer:=skinstyle;
       end;
     end;
   end else if control is TcxPageControl Then
   Begin
     if TcxPageControl(control).Parent is  Tpanel Then
        Tpanel(TcxPageControl(control).Parent).Color := skinstyle.Color
     else if  TcxPageControl(control).Parent is  TForm Then
        TForm(TcxPageControl(control).Parent).Color := skinstyle.Color;
     TcxPageControl(control).Color := skinstyle.Color;
     TcxPageControl(control).LookAndFeel.Kind := lfUltraFlat;
     TcxPageControl(control).LookAndFeel.NativeStyle := False;
     TcxPageControl(control).ParentColor := True;
     //TcxPageControl(control).Style := 4;
   End;
end;
end.
