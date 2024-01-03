unit USkiaDemoMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Skia, Vcl.Skia, Vcl.StdCtrls,
  System.Types, System.Math;

type
  TFSkiaDemoMain = class(TForm)
    SkAnimatedImage1: TSkAnimatedImage;
    Button1: TButton;
    SkLabel1: TSkLabel;
    SkPaintBoxGradient: TSkPaintBox;
    SkAnimatedImage2: TSkAnimatedImage;
    SkSvg1: TSkSvg;
    SkAnimatedPaintBox1: TSkAnimatedPaintBox;
    SkAnimatedPaintBox2: TSkAnimatedPaintBox;
    Button2: TButton;
    Button3: TButton;
    SkAnimatedImage3: TSkAnimatedImage;
    SkAnimatedImageFireworks: TSkAnimatedImage;
    procedure Button1Click(Sender: TObject);
    procedure SkPaintBoxGradientDraw(ASender: TObject; const ACanvas: ISkCanvas;
      const ADest: TRectF; const AOpacity: Single);
    procedure SkAnimatedPaintBox1AnimationDraw(ASender: TObject;
      const ACanvas: ISkCanvas; const ADest: TRectF; const AProgress: Double;
      const AOpacity: Single);
    procedure SkAnimatedPaintBox2AnimationDraw(ASender: TObject;
      const ACanvas: ISkCanvas; const ADest: TRectF; const AProgress: Double;
      const AOpacity: Single);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SkAnimatedImage3DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSkiaDemoMain: TFSkiaDemoMain;

implementation

{$R *.dfm}

procedure TFSkiaDemoMain.Button1Click(Sender: TObject);
begin
 if SkAnimatedPaintBox2.Animate then
  SkAnimatedPaintBox2.Animation.Stop
 else
  SkAnimatedPaintBox2.Animation.Start;
end;

procedure TFSkiaDemoMain.Button2Click(Sender: TObject);
begin
 SkAnimatedImage1.Animation.Speed := SkAnimatedImage1.Animation.Speed + 1;
end;

procedure TFSkiaDemoMain.Button3Click(Sender: TObject);
begin
 SkAnimatedImage1.Animation.Speed := SkAnimatedImage1.Animation.Speed - 1;
end;

procedure TFSkiaDemoMain.SkAnimatedImage3DblClick(Sender: TObject);
begin
 SkAnimatedImageFireworks.Align := alClient;
 SkAnimatedImageFireworks.Visible := true;
end;

procedure TFSkiaDemoMain.SkAnimatedPaintBox1AnimationDraw(ASender: TObject;
  const ACanvas: ISkCanvas; const ADest: TRectF; const AProgress: Double;
  const AOpacity: Single);
var
  LPaint: ISkPaint;
begin
  LPaint := TSkPaint.Create;
//  LPaint.Shader := TSkShader.MakeGradientSweep(ADest.CenterPoint, [$FFFCE68D, $FFF7CAA5, $FF2EBBC1, $FFFCE68D]);
  LPaint.Shader := TSkShader.MakeGradientLinear
     ( PointF(ADest.Left, ADest.Top+Floor((ADest.Bottom-ADest.Top)*AProgress)) ,
       PointF(ADest.Right, ADest.Bottom-Floor((ADest.Bottom-ADest.Top)*AProgress)),
       [$FF00FF00, $FFFF0000]);


  ACanvas.DrawPaint(LPaint);

end;

procedure TFSkiaDemoMain.SkAnimatedPaintBox2AnimationDraw(ASender: TObject;
  const ACanvas: ISkCanvas; const ADest: TRectF; const AProgress: Double;
  const AOpacity: Single);
var
  LPaint: ISkPaint;
  strt  : Single;
begin
  LPaint := TSkPaint.Create(TSkPaintStyle.Stroke);
  LPaint.AntiAlias := True;
  LPaint.Color := $FF00008D;
  //LPaint.SetPathEffect(TSkPathEffect.MakeCorner(50));
  LPaint.StrokeCap := TSkStrokeCap.Round;
  LPaint.StrokeWidth := 4;

//  LPaint.Shader := TSkShader.MakeGradientSweep(ADest.CenterPoint, [$FFFCE68D, $FFF7CAA5, $FF2EBBC1, $FFFCE68D]);
  //LPaint.Shader := TSkShader.MakeGradientLinear(  ADest.TopLeft,ADest.BottomRight, [$FFFF0000, $FF00FF00]);

  //ACanvas.DrawPaint(LPaint);
  strt := 0;
  if AProgress > 0.25 then
   strt := Floor(360*AProgress)-90 ;
  ACanvas.DrawArc(RectF(ADest.Left+5, ADest.Top+5, ADest.Right-5, ADest.Bottom-5), strt, Floor(360*AProgress), false, LPaint);
end;

procedure TFSkiaDemoMain.SkPaintBoxGradientDraw(ASender: TObject; const ACanvas: ISkCanvas;
  const ADest: TRectF; const AOpacity: Single);
var
  LPaint: ISkPaint;
begin
  LPaint := TSkPaint.Create;
//  LPaint.Shader := TSkShader.MakeGradientSweep(ADest.CenterPoint, [$FFFCE68D, $FFF7CAA5, $FF2EBBC1, $FFFCE68D]);
  LPaint.Shader := TSkShader.MakeGradientLinear(  ADest.TopLeft,ADest.BottomRight, [$FFFF0000, $FF00FF00]);

  ACanvas.DrawPaint(LPaint);

end;

end.
