unit cadProdutosU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, ZDataset, ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB, ComCtrls, pesqCategoria, dataModuleU;

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
    zqProdutosds_produto: TZRawStringField;
    zqProdutosdt_cadastro_produto: TZDateTimeField;
    zqProdutosobs_produto: TZRawStringField;
    zqProdutosprodutoid: TZIntegerField;
    zqProdutosstatus_produto: TZRawStringField;
    zqProdutosvl_venda_produto: TZBCDField;
    zuProdutos: TZUpdateSQL;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure zqProdutosAfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  cadProdutosF: TcadProdutosF;

implementation

{$R *.lfm}

{ TcadProdutosF }



procedure TcadProdutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
  zqProdutos.Close;
end;

procedure TcadProdutosF.btnNovoClick(Sender: TObject);
begin
  inherited;
  zqProdutos.Insert;
end;

procedure TcadProdutosF.btnGravarClick(Sender: TObject);
begin
  inherited;
  zqProdutos.Post;
end;

procedure TcadProdutosF.btnEditarClick(Sender: TObject);
begin
  inherited;
  zqProdutos.Edit;
end;

procedure TcadProdutosF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqProdutos.Delete
  else
  begin
    ShowMessage('A exclusão foi cancelada.');
  end;
  inherited;
end;

procedure TcadProdutosF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqProdutos.Cancel;
end;

procedure TcadProdutosF.BitBtn1Click(Sender: TObject);
begin
  pesqCategoriaF:=TpesqCategoriaF.Create(Self);
  pesqCategoriaF.ShowModal;
end;

procedure TcadProdutosF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
   zqProdutos.Close;
   zqProdutos.SQL.Text:=
   'select * ' +
   'from produto ' +
   'where produtoid = ' +
   edtPesq.Text;
   zqProdutos.Open;
  end
  else
  begin
   zqProdutos.Close;
   zqProdutos.SQL.Text :=
    'select * '+
    'from produto '+
    'order by produtoid';
   zqProdutos.Open;
  end;
end;

procedure TcadProdutosF.FormShow(Sender: TObject);
begin
  inherited;
  zqProdutos.Open;
end;

procedure TcadProdutosF.zqProdutosAfterInsert(DataSet: TDataSet);
begin
  zqProdutosprodutoid.AsInteger:=StrToInt(dataModuleF.getSequence('produto_produtoid_seq'));
end;

end.

