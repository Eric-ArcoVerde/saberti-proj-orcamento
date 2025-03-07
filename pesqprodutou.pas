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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  pesqProdutosF: TpesqProdutosF;

implementation

{$R *.lfm}

{ TpesqProdutosF }

procedure TpesqProdutosF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

