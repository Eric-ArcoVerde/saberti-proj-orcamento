unit relProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ZDataset,
  ZAbstractRODataset, LR_Class, LR_DBSet, dataModuleU;

type

  { TrelProdutosF }

  TrelProdutosF = class(TForm)
    btnImpressao: TBitBtn;
    frDBDSRelProd: TfrDBDataSet;
    frRelProd: TfrReport;
    zqRelProd: TZQuery;
    zqRelProdds_categoria_produto: TZRawStringField;
    zqRelProdds_produto: TZRawStringField;
    zqRelProddt_cadastro_produto: TZDateTimeField;
    zqRelProdobs_produto: TZRawStringField;
    zqRelProdprodutoid: TZIntegerField;
    zqRelProdstatus_produto: TZRawStringField;
    zqRelProdvl_venda_produto: TZBCDField;
    procedure btnImpressaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  relProdutosF: TrelProdutosF;

implementation

{$R *.lfm}

{ TrelProdutosF }

procedure TrelProdutosF.FormShow(Sender: TObject);
begin
  zqRelProd.Open;
end;

procedure TrelProdutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  zqRelProd.Close;
  CloseAction := caFree;
end;

procedure TrelProdutosF.btnImpressaoClick(Sender: TObject);
begin
  frRelProd.LoadFromFile('relProdutos.lrf');
  frRelProd.PrepareReport;
  frRelProd.ShowReport;
end;

end.

