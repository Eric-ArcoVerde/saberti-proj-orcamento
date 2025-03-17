unit cadProdutosU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, ZDataset, ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB,
  ComCtrls, pesqCategoria, dataModuleU;

type

  { TcadProdutosF }

  TcadProdutosF = class(TxCadPaiF)
    BitBtn1: TBitBtn;
    cbStatus: TDBComboBox;
    edtID: TDBEdit;
    dsProdutos: TDataSource;
    edtDataCadProd: TDBEdit;
    edtCategoria: TDBEdit;
    edtValorVenda: TDBEdit;
    edtDescricao: TDBEdit;
    edtOBS: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LbCat: TLabel;
    zqProdutos: TZQuery;
    zqProdutoscategoriaprodutoid: TZIntegerField;
    zqProdutosds_categoria_produto: TZRawStringField;
    zqProdutosds_produto: TZRawStringField;
    zqProdutosdt_cadastro_produto: TZDateTimeField;
    zqProdutosobs_produto: TZRawStringField;
    zqProdutosprodutoid: TZIntegerField;
    zqProdutosstatus_produto: TZRawStringField;
    zqProdutosvl_venda_produto: TZBCDField;
    zuProdutos: TZUpdateSQL;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tsCadastroShow(Sender: TObject);
    procedure zqProdutosAfterInsert(DataSet: TDataSet);
  private
    function ValidaCampos: Boolean;
  public

  end;

var
  cadProdutosF: TcadProdutosF;

implementation

{$R *.lfm}

{ TcadProdutosF }

function TcadProdutosF.ValidaCampos: boolean;
begin
  Result := True;
  if (Trim(zqProdutosstatus_produto.AsString) = '') or
     (Trim(zqProdutosdt_cadastro_produto.AsString) = '') or
     (Trim(zqProdutoscategoriaprodutoid.AsString) = '') or
     (Trim(zqProdutosvl_venda_produto.AsString) = '') or
     (Trim(zqProdutosds_produto.AsString) = '') or
     (Trim(zqProdutosobs_produto.AsString) = '') then
  begin
    ShowMessage('Preencha todos os Campos');
    Result := False;
  end;
end;

procedure TcadProdutosF.FormShow(Sender: TObject);
begin
  inherited;
  zqProdutos.Open;
end;

procedure TcadProdutosF.tsCadastroShow(Sender: TObject);
begin
  zqProdutosdt_cadastro_produto.EditMask := '99/99/9999;1;_';
end;

procedure TcadProdutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  zqProdutos.Close;
end;

procedure TcadProdutosF.zqProdutosAfterInsert(DataSet: TDataSet);
begin
  zqProdutosprodutoid.AsInteger :=
    StrToInt(dataModuleF.getSequence('produto_produtoid_seq'));
  zqProdutosdt_cadastro_produto.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now));
end;

procedure TcadProdutosF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
    zqProdutos.Close;
    zqProdutos.SQL.Text :=
      'select *, ' + '(select ds_categoria_produto ' +
      'from categoria_produto where categoriaprodutoid=p.categoriaprodutoid )' +
      'from produto p ' + 'where produtoid = ' + edtPesq.Text +
      ' order by produtoid';
    zqProdutos.Open;
  end
  else
  begin
    zqProdutos.Close;
    zqProdutos.SQL.Text :=
      'select *, ' + '(select ds_categoria_produto ' +
      'from categoria_produto where categoriaprodutoid=p.categoriaprodutoid )' +
      'from produto p ' + 'order by produtoid';
    zqProdutos.Open;
  end;
end;

procedure TcadProdutosF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  LbCat.Caption := zqProdutosds_categoria_produto.AsString;
  zqProdutos.Edit;
end;

procedure TcadProdutosF.btnNovoClick(Sender: TObject);
begin
  inherited;
  LbCat.Caption := '';
  zqProdutos.Insert;
end;

procedure TcadProdutosF.btnGravarClick(Sender: TObject);
begin
  if not ValidaCampos then
     Exit;
  inherited;
  zqProdutos.Post;
end;

procedure TcadProdutosF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqProdutos.Cancel;
end;

procedure TcadProdutosF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqProdutos.Delete
  else
    Exit;
  inherited;
end;

procedure TcadProdutosF.BitBtn1Click(Sender: TObject);
begin
  pesqCategoriaF := TpesqCategoriaF.Create(Self);
  pesqCategoriaF.ShowModal;
end;

end.
