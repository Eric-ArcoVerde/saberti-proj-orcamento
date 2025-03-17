unit pesqProdutoU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, ZDataset, ZAbstractRODataset;

type

  { TpesqProdutosF }

  TpesqProdutosF = class(TForm)
    btnPesquisar: TBitBtn;
    dsPesqProd: TDataSource;
    DBGrid1: TDBGrid;
    edtPesquisar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    zqPesqProd: TZQuery;
    zqPesqProdds_produto: TZRawStringField;
    zqPesqProdprodutoid: TZIntegerField;
    zqPesqProdvl_venda_produto: TZBCDField;
    procedure btnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  pesqProdutosF: TpesqProdutosF;

implementation

uses
  inserirItemU, orcamentoU;


  {$R *.lfm}

  { TpesqProdutosF }

procedure TpesqProdutosF.FormShow(Sender: TObject);
begin
  zqPesqProd.Open;
end;

procedure TpesqProdutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  zqPesqProd.Close;
  CloseAction := caFree;
end;

procedure TpesqProdutosF.btnPesquisarClick(Sender: TObject);
var
  AuxWhere: string;
begin
  if edtPesquisar.Text = '' then
    AuxWhere := '1 = 1'
  else
    AuxWhere := 'PRODUTOID = ' + edtPesquisar.Text;

  zqPesqProd.Close;
  zqPesqProd.SQL.Text :=
    'SELECT ' + 'PRODUTOID, ' + 'DS_PRODUTO, ' +
    'VL_VENDA_PRODUTO ' + 'FROM PRODUTO ' + 'WHERE ' + AuxWhere + ' ' +
    'AND STATUS_PRODUTO = ''ATIVO'' '+
    'ORDER BY PRODUTOID';
  zqPesqProd.Open;

end;

procedure TpesqProdutosF.DBGrid1DblClick(Sender: TObject);
begin
  orcamentoF.zqOrcItemprodutoid.AsInteger := zqPesqProdprodutoid.AsInteger;
  orcamentoF.zqOrcItemproduto_desc.AsString := zqPesqProdds_produto.AsString;
  orcamentoF.zqOrcItemvl_unitario.AsFloat := zqPesqProdvl_venda_produto.AsFloat;
  Close;
end;

end.

