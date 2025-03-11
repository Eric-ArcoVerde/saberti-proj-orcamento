unit orcamentoU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  DBCtrls, StdCtrls, Buttons, ZDataset, ZSqlUpdate, ZAbstractRODataset,
  xCadPaiU, DB, dataModuleU, pesClienteU, inserirItemU;

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
    procedure btnDelItemClick(Sender: TObject);
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
    procedure AbreOrcItens(orcamentoid : Integer);
    procedure SomaItens;
    procedure zqOrcamentoAfterInsert(DataSet: TDataSet);
    procedure zqOrcItemAfterInsert(DataSet: TDataSet);
    procedure zqOrcItemAfterPost(DataSet: TDataSet);
  private

  public


  end;

var
  orcamentoF: TorcamentoF;

implementation

{$R *.lfm}

{ TorcamentoF }



procedure TOrcamentoF.SomaItens;
begin
  if not (zqOrcamento.State in [dsEdit, dsInsert]) then
     zqOrcamento.Edit;

  zqOrcItem.First;
  zqOrcamentovl_total_orcamento.AsFloat:=0;

  while not zqOrcItem.EOF do
  begin
   zqOrcamentovl_total_orcamento.AsFloat:=zqOrcamentovl_total_orcamento.AsFloat + zqOrcItemvl_total.AsFloat;
   zqOrcItem.Next;
  end;
end;

procedure TorcamentoF.zqOrcamentoAfterInsert(DataSet: TDataSet);
begin
  zqOrcamentoorcamentoid.AsInteger := StrToInt(dataModuleF.getSequence('orcamento_orcamentoid_seq'));
end;

procedure TorcamentoF.zqOrcItemAfterInsert(DataSet: TDataSet);
begin
  zqOrcItemorcamentoitemid.AsString :=  dataModuleF.getSequence('orcamento_item_oracamentoitemid_seq');
  zqOrcItemorcamentoid.AsInteger := zqOrcamentoorcamentoid.AsInteger;
end;

procedure TorcamentoF.zqOrcItemAfterPost(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TOrcamentoF.AbreOrcItens(orcamentoid : Integer);
begin
  if orcamentoid <> 0 then
  begin
      zqOrcItem.Close;
      zqOrcItem.SQL.Clear;
      zqOrcItem.SQL.Add(
                      'SELECT * '+
                      //'ORCAMENTOITEMID, '+
                      //'ORCAMENTOID, '+
                      //'PRODUTOID, '+
                      //'produtodesc, '+
                      //'QT_PRODUTO, '+
                      //'VL_UNITARIO, '+
                      //'VL_TOTAL '+
                      'FROM ORCAMENTO_ITEM ' +
                      'WHERE ORCAMENTOID = '+ inttostr(orcamentoid) + ' ' +
                      'ORDER BY ORCAMENTOID');
       zqOrcItem.Open;
  end;
end;

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
  AbreOrcItens(zqOrcamentoorcamentoid.AsInteger);
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
  AbreOrcItens(zqOrcamentoorcamentoid.AsInteger);
  zqOrcamentodt_orcamento.AsDateTime := Date;
end;

procedure TorcamentoF.btnEditarClick(Sender: TObject);
begin
  zqOrcamento.Edit;
  zqOrcItem.Edit;
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

procedure TorcamentoF.btnDelItemClick(Sender: TObject);
begin
  zqOrcItem.Delete;
end;

procedure TorcamentoF.btnAdcItemClick(Sender: TObject);
begin
  zqOrcItem.Insert;
  inserirItemF:=TinserirItemF.Create(Self);
  inserirItemF.ShowModal;
end;

procedure TorcamentoF.btnGravarClick(Sender: TObject);
begin
  inherited;
  zqOrcamento.Post;
end;

end.

