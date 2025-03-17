unit orcamentoU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  DBCtrls, StdCtrls, Buttons, MaskEdit, LR_DBSet, LR_Class, ZDataset,
  ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB, dataModuleU, pesClienteU,
  inserirItemU;

type

  { TorcamentoF }

  TorcamentoF = class(TxCadPaiF)
    btnAdcItem: TBitBtn;
    btnDelItem: TBitBtn;
    btnImpressao: TBitBtn;
    btnPesqCliente: TBitBtn;
    edtID: TDBEdit;
    edtCliente: TDBEdit;
    edtDtOrcamento: TDBEdit;
    edtDtVal: TDBEdit;
    edtTotalOrc: TDBEdit;
    dbGridOrcItem: TDBGrid;
    dsOrcItem: TDataSource;
    dsOrcamento: TDataSource;
    frDBDSRelOrcItem: TfrDBDataSet;
    frRelOcrItem: TfrReport;
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
    zqOrcamentonome_cliente: TZRawStringField;
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
    procedure btnDelItemClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnImpressaoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure btnPesqClienteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure dbGridOrcItemDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tsCadastroExit(Sender: TObject);
    procedure AbreOrcItens(orcamentoid: integer);
    procedure SomaItens;
    procedure tsCadastroShow(Sender: TObject);
    procedure zqOrcamentoAfterInsert(DataSet: TDataSet);
    procedure zqOrcItemAfterInsert(DataSet: TDataSet);
    procedure zqOrcItemAfterPost(DataSet: TDataSet);
  private
    function ValidaCampos: Boolean;
  public


  end;

var
  orcamentoF: TorcamentoF;

implementation

{$R *.lfm}

{ TorcamentoF }

//----------------- FUNÇÕES --------------------
function TOrcamentoF.ValidaCampos: boolean;
begin
  Result := True;
  if (Trim(zqOrcamentoclienteid.AsString) = '') or
     (Trim(zqOrcamentodt_orcamento.AsString) = '') or
     (Trim(zqOrcamentodt_validade_orcamento.AsString) = '') or
     (zqOrcamentovl_total_orcamento.AsString = '') or
     (zqOrcamentovl_total_orcamento.AsInteger = 0)then
  begin
    ShowMessage('Preencha todos os Campos');
    Result := False;
  end;
end;

procedure TOrcamentoF.SomaItens;
begin
  if not (zqOrcamento.State in [dsEdit, dsInsert]) then
    zqOrcamento.Edit;

  zqOrcItem.First;
  zqOrcamentovl_total_orcamento.AsFloat := 0;

  while not zqOrcItem.EOF do
  begin
    zqOrcamentovl_total_orcamento.AsFloat :=
      zqOrcamentovl_total_orcamento.AsFloat + zqOrcItemvl_total.AsFloat;
    zqOrcItem.Next;
  end;
end;

procedure TorcamentoF.tsCadastroShow(Sender: TObject);
begin
  zqOrcamentodt_orcamento.EditMask := '99/99/9999;1;_';
  zqOrcamentovl_total_orcamento.EditMask := '99/99/9999;1;_';
end;

procedure TOrcamentoF.AbreOrcItens(orcamentoid: integer);
begin
  if orcamentoid <> 0 then
  begin
    zqOrcItem.Close;
    zqOrcItem.SQL.Clear;
    zqOrcItem.SQL.Add(
      'SELECT * ' + 'FROM ORCAMENTO_ITEM ' + 'WHERE ORCAMENTOID = ' +
      IntToStr(orcamentoid) + ' ' + 'ORDER BY ORCAMENTOID');
    zqOrcItem.Open;
  end;
end;

//----------------- EVENTOS --------------------

procedure TorcamentoF.FormShow(Sender: TObject);
begin
  inherited;
  zqOrcamento.Open;
end;

procedure TorcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  zqOrcamento.Close;
end;

procedure TorcamentoF.zqOrcamentoAfterInsert(DataSet: TDataSet);
begin
  zqOrcamentoorcamentoid.AsInteger :=
    StrToInt(dataModuleF.getSequence('orcamento_orcamentoid_seq'));
  zqOrcamentodt_orcamento.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now));
  zqOrcamentodt_validade_orcamento.AsDateTime :=
    StrToDate(formatdatetime('dd/mm/yyyy', now + 20));
end;

procedure TorcamentoF.zqOrcItemAfterInsert(DataSet: TDataSet);
begin
  zqOrcItemorcamentoitemid.AsString :=
    dataModuleF.getSequence('orcamento_item_oracamentoitemid_seq');
  zqOrcItemorcamentoid.AsInteger := zqOrcamentoorcamentoid.AsInteger;
end;

procedure TorcamentoF.zqOrcItemAfterPost(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TorcamentoF.tsCadastroExit(Sender: TObject);
begin
  zqOrcItem.Close;
end;

//-------------- PAGINA PESQUISAR ----------

procedure TorcamentoF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
    zqOrcamento.Close;
    zqOrcamento.SQL.Text :=
      'select *, ' + '(select nome_cliente from cliente ' +
      'where clienteid=o.clienteid)' + 'from orcamento o ' +
      'where orcamentoid = ' + edtPesq.Text + 'order by orcamentoid';
    zqOrcamento.Open;
  end
  else
  begin
    zqOrcamento.Close;
    zqOrcamento.SQL.Text :=
      'select *, ' + '(select nome_cliente from cliente ' +
      'where clienteid=o.clienteid)' + 'from orcamento o ' +
      'order by orcamentoid';
    zqOrcamento.Open;
  end;
end;

procedure TorcamentoF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  zqOrcItem.Close;
  zqOrcItem.SQL.Text :=
    'select * ' + 'from orcamento_item ' + 'where orcamentoid = ' +
    zqOrcamentoorcamentoid.AsString;
  zqOrcItem.Open;
  AbreOrcItens(zqOrcamentoorcamentoid.AsInteger);
  lbDescCliente.Caption := zqOrcamentonome_cliente.AsString;
  zqOrcamento.Edit;
  zqOrcItem.Edit;
end;

procedure TorcamentoF.btnNovoClick(Sender: TObject);
begin
  lbDescCliente.Caption := '';
  inherited;
  zqOrcItem.Close;
  zqOrcamento.Insert;
  AbreOrcItens(zqOrcamentoorcamentoid.AsInteger);
end;

//--------------------- Botões Cad Pai --------------------

procedure TorcamentoF.btnGravarClick(Sender: TObject);
begin
  if not ValidaCampos then
     Exit;
  inherited;
  zqOrcamento.Post;
end;

procedure TorcamentoF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqOrcamento.Cancel;
end;

procedure TorcamentoF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqOrcamento.Delete
  else
    Exit;
  inherited;
end;

//-------------------- Botões específicos --------------

procedure TorcamentoF.btnPesqClienteClick(Sender: TObject);
begin
  pesqClienteF := TpesqClienteF.Create(Self);
  pesqClienteF.ShowModal;
end;

procedure TorcamentoF.btnAdcItemClick(Sender: TObject);
begin
  zqOrcItem.Insert;
  inserirItemF := TinserirItemF.Create(Self);
  inserirItemF.ShowModal;
end;

procedure TorcamentoF.btnDelItemClick(Sender: TObject);
begin
  zqOrcItem.Delete;
  SomaItens;
end;

procedure TorcamentoF.dbGridOrcItemDblClick(Sender: TObject);
begin
  zqOrcItem.Edit;
  inserirItemF := TinserirItemF.Create(Self);
  inserirItemF.ShowModal;
end;

procedure TorcamentoF.btnImpressaoClick(Sender: TObject);
begin
  frRelOcrItem.LoadFromFile('relOrcItem.lrf');
  frRelOcrItem.PrepareReport;
  frRelOcrItem.ShowReport;
end;

end.

