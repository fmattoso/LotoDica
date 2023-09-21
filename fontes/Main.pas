unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Controls.Presentation,
  FMX.Layouts, FMX.ListView, FMX.ListBox, FMX.ExtCtrls;

type
  TfrmMain = class(TForm)
    ListView1: TListView;
    GridPanelLayout1: TGridPanelLayout;
    Label1: TLabel;
    NumberBox1: TNumberBox;
    Label2: TLabel;
    NumberBox2: TNumberBox;
    btnGerarNumeros: TCornerButton;
    btnLista: TSpeedButton;
    btnVolante: TSpeedButton;
    Label3: TLabel;
    cbModalidade: TComboBox;
    ImageViewer1: TImageViewer;
    procedure Ordenar(var dezenas: string; tmo: integer = 3);
    procedure btnGerarNumerosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnGerarNumerosClick(Sender: TObject);
var
  LItem: TListViewItem;
  iDz,
  iJg: integer;
  sLin: string;
  sDezena: string;
  lstJogos: TStrings;
begin

  ListView1.Items.Clear;
  lstJogos := TStringList.Create;
  try
    Randomize();

    iJg := 0;
    while iJg < Round(NumberBox2.Value) do
    begin
      sLin := '';
      iDz := 0;
      while (iDz < Round(NumberBox1.Value)) do
      begin
        sDezena := Format('-%.2d', [Round((Random() * 24)+1)]);
        if Pos(sDezena, sLin) = 0 then
        begin
          sLin := sLin + sDezena;
          Inc(iDz);
        end;
      end;

      Ordenar(sLin);

      if lstJogos.IndexOf(sLin) = -1 then
      begin
        lstJogos.Append(sLin);
        LItem := ListView1.Items.Add;
        LItem.Text := sLin;
        Inc(iJg);
      end;

    end;

  finally
    lstJogos.Free;
  end;


end;

procedure TfrmMain.Ordenar(var dezenas: string; tmo: integer = 3);
var
  sD1,
  sD2: string;
  iPos: integer;
  bTroca: Boolean;
begin

  repeat
    bTroca := False;
    iPos := 2;
    while (iPos+3) < Length(dezenas) do
    begin
      sD1 := Copy(dezenas, iPos, 2);
      sD2 := Copy(dezenas, iPos+3, 2);
      Inc(iPos, 3);
      if sD1 > sD2 then
      begin
        bTroca := True;
        dezenas := StringReplace(dezenas, sD2, '**', [rfReplaceAll]);
        dezenas := StringReplace(dezenas, sD1, sD2, [rfReplaceAll]);
        dezenas := StringReplace(dezenas, '**', sD1, [rfReplaceAll]);
      end;
    end;

  until not bTroca;

  if dezenas[1] = '-' then
    dezenas := Copy(dezenas, 2, Length(dezenas));
end;

end.
