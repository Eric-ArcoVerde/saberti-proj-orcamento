unit cadClienteU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ZDataset, ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB, dataModuleU, ComCtrls;

type

  { TcadClienteF }

  TcadClienteF = class(TxCadPaiF)
    rgTipoCliente: TDBRadioGroup;
    dsClientes: TDataSource;
    edtIdCliente: TDBEdit;
    edtNomeCliente: TDBEdit;
    edtRegCliente: TDBEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    zqClientes: TZQuery;
    zqClientesclienteid: TZIntegerField;
    zqClientescpf_cnpj_cliente: TZRawStringField;
    zqClientesnome_cliente: TZRawStringField;
    zqClientestipo_cliente: TZRawStringField;
    zuClientes: TZUpdateSQL;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure rgTipoClienteChange(Sender: TObject);
    procedure zqClientesAfterInsert(DataSet: TDataSet);
  private
    function ValidaCampos: Boolean;
  public

  end;

var
  cadClienteF: TcadClienteF;

implementation

{$R *.lfm}

{ TcadClienteF }

function TcadClienteF.ValidaCampos: boolean;
begin
  Result := True;
  if (rgTipoCliente.ItemIndex = -1) or
     (Trim(zqClientesnome_cliente.AsString) = '') or
     (Trim(zqClientescpf_cnpj_cliente.AsString) = '') then
  begin
    ShowMessage('Preencha todos os Campos');
    Result := False;
  end;
end;

procedure TcadClienteF.PageControl1Changing(Sender: TObject; var AllowChange: boolean);
begin
  AllowChange := False;
end;

procedure TcadClienteF.FormShow(Sender: TObject);
begin
  inherited;
  zqClientes.Open;
end;

procedure TcadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  zqClientes.Close;
end;

procedure TcadClienteF.zqClientesAfterInsert(DataSet: TDataSet);
begin
  zqClientesclienteid.AsInteger :=
    StrToInt(dataModuleF.getSequence('cliente_clienteid_seq'));
end;

procedure TcadClienteF.rgTipoClienteChange(Sender: TObject);
begin
  if rgTipoCliente.ItemIndex = 0 then
    zqClientescpf_cnpj_cliente.EditMask := '999.999.999-99;1;_'
  else if rgTipoCliente.ItemIndex = 1 then
    zqClientescpf_cnpj_cliente.EditMask := '99.999.999/9999-99;1;_';
end;

procedure TcadClienteF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
    zqClientes.Close;
    zqClientes.SQL.Text :=
      'select clienteid, tipo_cliente, nome_cliente, cpf_cnpj_cliente ' +
      'from cliente ' + 'where clienteid = ' + edtPesq.Text + 'order by clienteid';
    zqClientes.Open;
  end
  else
  begin
    zqClientes.Close;
    zqClientes.SQL.Text :=
      'select * ' + 'from cliente ' + 'order by clienteid';
    zqClientes.Open;
  end;
end;

procedure TcadClienteF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if zqClientestipo_cliente.AsString = 'F' then
    rgTipoCliente.ItemIndex := 0
  else if zqClientestipo_cliente.AsString = 'J' then
    rgTipoCliente.ItemIndex := 1;
  zqClientes.Edit;
end;

procedure TcadClienteF.btnNovoClick(Sender: TObject);
begin
  inherited;
  zqClientes.Insert;
end;

procedure TcadClienteF.btnGravarClick(Sender: TObject);
begin
  if not ValidaCampos then
     Exit;
  inherited;
  if rgTipoCliente.ItemIndex = 0 then
    zqClientestipo_cliente.AsString := 'F'
  else if rgTipoCliente.ItemIndex = 1 then
    zqClientestipo_cliente.AsString := 'J';
  zqClientes.Post;
end;

procedure TcadClienteF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqClientes.Cancel;
end;

procedure TcadClienteF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqClientes.Delete
  else
    Exit;
  inherited;
end;


end.

