unit uBaseForm;

interface

uses
  Forms,Classes,Controls;

type
  TFrmBase = class(TForm);

  TFrmFrame = class(TFrmBase)
  public
    constructor Create(AOwner: TComponent);  override;
   // constructor Create(AOwner: TComponent;AParentWindow:THandle=0); overload;
  end;

implementation

{ TFrmBase }

constructor TFrmFrame.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  Hide;
  if AOwner is TWinControl then
      Parent := TWinControl(AOwner);
  Align := alClient;
end;

//constructor TFrmFrame.Create(AOwner: TComponent;AParentWindow:THandle);
//begin
//  inherited Create(AOwner);
//  BorderStyle := bsNone;
//  Hide;
//  //ParentWindow := TWinControl(AOwner).Handle;
//  Align := alClient;
////  Create(AOwner);
//  if AParentWindow = 0 then
//  begin
//    if AOwner is TWinControl then
//      Parent := TWinControl(AOwner)
//  end else
//    ParentWindow := AParentWindow;
////  inherited Create(AOwner);
////  BorderStyle := bsNone;
////  Hide;
////  ParentWindow := AParentWindow;
////  Align := alClient;
//end;

end.

