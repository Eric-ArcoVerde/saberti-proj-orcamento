unit cadCategoriaU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ZDataset, ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB, ComCtrls;

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
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  private

  public

  end;

var
  cadCategoriaF: TcadCategoriaF;

implementation

{$R *.lfm}

{ TcadCategoriaF }

procedure TcadCategoriaF.FormShow(Sender: TObject);
begin
  inherited;
  zqCategorias.Open;
end;

procedure TcadCategoriaF.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=False;
end;

procedure TcadCategoriaF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
  zqCategorias.Close;
end;

procedure TcadCategoriaF.btnNovoClick(Sender: TObject);
begin
  inherited;
  zqCategorias.Insert;
end;

procedure TcadCategoriaF.btnPesqClick(Sender: TObject);
begin
  zqCategorias.Close;
  zqCategorias.SQL.Text :=
    'select * '+
    'from categoria_produto '+
    'where categoriaprodutoid = ' + edtPesq.Text +
    'order by categoriaprodutoid';
  zqCategorias.Open;
end;


procedure TcadCategoriaF.btnGravarClick(Sender: TObject);
begin
  inherited;
  zqCategorias.Post;
end;

procedure TcadCategoriaF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqCategorias.Cancel;
end;

procedure TcadCategoriaF.btnEditarClick(Sender: TObject);
begin
  inherited;
  zqCategorias.Edit;
end;

procedure TcadCategoriaF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqCategorias.Delete
  else
  begin
    ShowMessage('A exclusão foi cancelada.');
  end;
  inherited;
end;

end.

