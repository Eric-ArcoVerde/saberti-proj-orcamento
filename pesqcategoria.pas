unit pesqCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, Buttons, ZDataset, ZAbstractRODataset, dataModuleU;

type

  { TpesqCategoriaF }

  TpesqCategoriaF = class(TForm)
    btnPesquisar: TBitBtn;
    dsPesqCategoria: TDataSource;
    DBGrid1: TDBGrid;
    edtPesquisar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    zqCategoriaAux: TZQuery;
    zqCategoriaAuxcategoriaprodutoid: TZIntegerField;
    zqCategoriaAuxds_categoria_produto: TZRawStringField;
    procedure btnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  pesqCategoriaF: TpesqCategoriaF;

implementation

uses
  cadProdutosU;

{$R *.lfm}

{ TpesqCategoriaF }

procedure TpesqCategoriaF.btnPesquisarClick(Sender: TObject);
var AuxWhere : String;
begin
   if edtPesquisar.Text = '' then
     AuxWhere := '1 = 1'
   else
       AuxWhere := 'CATEGORIAPRODUTOID = '+edtPesquisar.Text;

  zqCategoriaAux.Close;
  zqCategoriaAux.SQL.Text :=
        'SELECT ' +
        'CATEGORIAPRODUTOID, ' +
        'DS_CATEGORIA_PRODUTO ' +
        'FROM CATEGORIA_PRODUTO ' +
        'WHERE '+AuxWhere+' '+
        'ORDER BY CATEGORIAPRODUTOID';
  zqCategoriaAux.Open;

end;

procedure TpesqCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
   cadProdutosF.zqProdutoscategoriaprodutoid.AsInteger := zqCategoriaAuxcategoriaprodutoid.AsInteger;
   cadProdutosF.;
end;

end.

