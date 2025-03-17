unit cadCategoriaU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ZDataset, ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB, ComCtrls, dataModuleU;

type

  { TcadCategoriaF }

  TcadCategoriaF = class(TxCadPaiF)
    dsCategorias: TDataSource;
    edtID: TDBEdit;
    edtDesc: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    zqCategorias: TZQuery;
    zqCategoriascategoriaprodutoid: TZIntegerField;
    zqCategoriasds_categoria_produto: TZRawStringField;
    zuCategorias: TZUpdateSQL;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure zqCategoriasAfterInsert(DataSet: TDataSet);
  private
    function ValidaCampos: Boolean;
  public

  end;

var
  cadCategoriaF: TcadCategoriaF;

implementation

{$R *.lfm}

{ TcadCategoriaF }


function TcadCategoriaF.ValidaCampos: boolean;
begin
  Result := True;
  if (Trim(zqCategoriasds_categoria_produto.AsString) = '') then
  begin
    ShowMessage('Preencha todos os Campos');
    Result := False;
  end;
end;
procedure TcadCategoriaF.FormShow(Sender: TObject);
begin
  inherited;
  zqCategorias.Open;
end;

procedure TcadCategoriaF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  zqCategorias.Close;
end;

procedure TcadCategoriaF.zqCategoriasAfterInsert(DataSet: TDataSet);
begin
  zqCategoriascategoriaprodutoid.AsInteger :=
    StrToInt(DataModuleF.getSequence('categoria_produto_categoriaprodutoid'));
end;

procedure TcadCategoriaF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
    zqCategorias.Close;
    zqCategorias.SQL.Text :=
      'select * ' + 'from categoria_produto ' + 'where categoriaprodutoid = ' +
      edtPesq.Text + 'order by categoriaprodutoid';
    zqCategorias.Open;
  end
  else
  begin
    zqCategorias.Close;
    zqCategorias.SQL.Text :=
      'select * ' + 'from categoria_produto ' + 'order by categoriaprodutoid';
    zqCategorias.Open;
  end;
end;

procedure TcadCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  zqCategorias.Edit;
end;

procedure TcadCategoriaF.btnNovoClick(Sender: TObject);
begin
  inherited;
  zqCategorias.Insert;
end;

procedure TcadCategoriaF.btnGravarClick(Sender: TObject);
begin
  if not ValidaCampos then
     Exit;
  inherited;
  zqCategorias.Post;
end;

procedure TcadCategoriaF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqCategorias.Cancel;
end;

procedure TcadCategoriaF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqCategorias.Delete
  else
    Exit;
  inherited;
end;

end.

