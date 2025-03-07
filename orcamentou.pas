unit orcamentoU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  DBCtrls, StdCtrls, Buttons, ZDataset, ZSqlUpdate, ZAbstractRODataset,
  xCadPaiU, DB, dataModuleU, pesClienteU;

type

  { TorcamentoF }

  TorcamentoF = class(TxCadPaiF)
    btnAdcItem: TBitBtn;
    btnDelItem: TBitBtn;
    btnPesqCliente: TBitBtn;
    edtID: TDBEdit;
    edtCliente: TDBEdit;
    edtDtOrcamento: TDBEdit;
    edtDtVal: TDBEdit;
    edtTotalOrc: TDBEdit;
    dbGridOrcItem: TDBGrid;
    dsOrcItem: TDataSource;
    dsOrcamento: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbDescCliente: TLabel;
    Panel4: TPanel;
    zqOrcamento: TZQuery;
    zqOrcamentoclienteid: TZIntegerField;
    zqOrcamentodt_orcamento: TZDateTimeField;
    zqOrcamentodt_validade_orcamento: TZDateTimeField;
    zqOrcamentoorcamentoid: TZIntegerField;
    zqOrcamentovl_total_orcamento: TZBCDField;
    zqOrcItem: TZQuery;
    zqOrcItemorcamentoid: TZIntegerField;
    zqOrcItemorcamentoitemid: TZIntegerField;
    zqOrcItemprodutoid: TZIntegerField;
    zqOrcItemproduto_desc: TZRawStringField;
    zqOrcItemqt_produto: TZBCDField;
    zqOrcItemvl_total: TZBCDField;
    zqOrcItemvl_unitario: TZBCDField;
    zuOrcamento: TZUpdateSQL;
    zuOrcItem: TZUpdateSQL;
    procedure btnAdcItemClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure btnPesqClienteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tsCadastroExit(Sender: TObject);
  private

  public

  end;

var
  orcamentoF: TorcamentoF;

implementation

{$R *.lfm}

{ TorcamentoF }

procedure TorcamentoF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
   zqOrcamento.Close;
   zqOrcamento.SQL.Text:=
   'select * ' +
   'from orcamento ' +
   'where orcamentoid = ' +
   edtPesq.Text;
   zqOrcamento.Open;
  end
  else
  begin
   zqOrcamento.Close;
   zqOrcamento.SQL.Text :=
    'select * '+
    'from orcamento '+
    'order by orcamentoid';
   zqOrcamento.Open;
  end;
end;

procedure TorcamentoF.btnPesqClienteClick(Sender: TObject);
begin
  pesqClienteF:=TpesqClienteF.Create(Self);
  pesqClienteF.ShowModal;
end;

procedure TorcamentoF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  zqOrcItem.Close;
  zqOrcItem.SQL.Text:=
   'select * ' +
   'from orcamento_item ' +
   'where orcamentoid = ' +
   zqOrcamentoorcamentoid.AsString;
  zqOrcItem.Open;
end;

procedure TorcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  zqOrcamento.Close;
end;

procedure TorcamentoF.FormShow(Sender: TObject);
begin
  inherited;
  zqOrcamento.Open;
end;

procedure TorcamentoF.tsCadastroExit(Sender: TObject);
begin
  zqOrcItem.Close;
end;

procedure TorcamentoF.btnNovoClick(Sender: TObject);
begin
  inherited;
  zqOrcItem.Close;
  zqOrcamento.Insert;
end;

procedure TorcamentoF.btnEditarClick(Sender: TObject);
begin
  zqOrcamento.Edit;
end;

procedure TorcamentoF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqOrcamento.Delete
  else
  begin
    ShowMessage('A exclusão foi cancelada.');
  end;
  inherited;
end;

procedure TorcamentoF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqOrcamento.Cancel;
end;

procedure TorcamentoF.btnAdcItemClick(Sender: TObject);
begin

end;

procedure TorcamentoF.btnGravarClick(Sender: TObject);
begin
  inherited;
  zqOrcamento.Post;
end;

end.

