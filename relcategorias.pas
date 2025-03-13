unit relCategorias;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet, ZDataset, ZAbstractRODataset, dataModuleU;

type

  { TrelCategoriasF }

  TrelCategoriasF = class(TForm)
    btnImpressao: TBitBtn;
    frDBDSRelCategorias: TfrDBDataSet;
    frRelCategorias: TfrReport;
    zqRelCategorias: TZQuery;
    zqRelCategoriascategoriaprodutoid: TZIntegerField;
    zqRelCategoriasds_categoria_produto: TZRawStringField;
    procedure btnImpressaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  relCategoriasF: TrelCategoriasF;

implementation

{$R *.lfm}

{ TrelCategoriasF }

procedure TrelCategoriasF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  zqRelCategorias.Close;
  CloseAction:=caFree;
end;

procedure TrelCategoriasF.btnImpressaoClick(Sender: TObject);
begin
  frRelCategorias.LoadFromFile('relCategorias.lrf');
  frRelCategorias.PrepareReport;
  frRelCategorias.ShowReport;
end;

procedure TrelCategoriasF.FormShow(Sender: TObject);
begin
  zqRelCategorias.Open;
end;

end.

