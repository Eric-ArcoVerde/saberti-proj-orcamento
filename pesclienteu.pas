unit pesClienteU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBCtrls, Buttons, DBGrids, ZDataset, ZAbstractRODataset, dataModuleU;

type

  { TpesqClienteF }

  TpesqClienteF = class(TForm)
    btnPesquisar: TBitBtn;
    dsPesqCliente: TDataSource;
    DBGrid1: TDBGrid;
    edtPesqCliente: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    zqClienteAux: TZQuery;
    zqClienteAuxclienteid: TZIntegerField;
    zqClienteAuxcpf_cnpj_cliente: TZRawStringField;
    zqClienteAuxnome_cliente: TZRawStringField;
    zqClienteAuxtipo_cliente: TZRawStringField;
    procedure btnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  pesqClienteF: TpesqClienteF;

implementation

uses
  orcamentoU;

  {$R *.lfm}

  { TpesqClienteF }

procedure TpesqClienteF.FormShow(Sender: TObject);
begin
  zqClienteAux.Open;
end;

procedure TpesqClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  zqClienteAux.Close;
  CloseAction := caFree;
end;

procedure TpesqClienteF.btnPesquisarClick(Sender: TObject);
var
  AuxWhere: string;
begin
  if edtPesqCliente.Text = '' then
    AuxWhere := '1 = 1'
  else
    AuxWhere := 'CLIENTEID = ' + edtPesqCliente.Text;

  zqClienteAux.Close;
  zqClienteAux.SQL.Text :=
    'SELECT ' + 'CLIENTEID, ' + 'TIPO_CLIENTE, ' +
    'CPF_CNPJ_CLIENTE, ' + 'NOME_CLIENTE ' + 'FROM CLIENTE ' +
    'WHERE ' + AuxWhere + ' ' + 'ORDER BY CLIENTEID';
  zqClienteAux.Open;
end;

procedure TpesqClienteF.DBGrid1DblClick(Sender: TObject);
begin
  orcamentoF.zqOrcamentoclienteid.AsInteger := zqClienteAuxclienteid.AsInteger;
  orcamentoF.lbDescCliente.Caption := zqClienteAuxnome_cliente.AsString;
  Close;
end;

end.

