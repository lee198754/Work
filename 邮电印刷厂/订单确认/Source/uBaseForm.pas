unit uBaseForm;

interface

uses
  Forms,Classes,Controls;

type
  TFrmBase = class(TForm);

  TFrmFrame = class(TFrmBase)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TFrmBase }

constructor TFrmFrame.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  Hide;
  Parent := TWinControl(AOwner);
  Align := alClient;
end;

end.
