unit cadClienteU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ZDataset, ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB, dataModuleU, ComCtrls;

type

  { TcadClienteF }

  TcadClienteF = class(TxCadPaiF)
    dsClientes: TDataSource;
    edtIdCliente: TDBEdit;
    edtTipoCliente: TDBEdit;
    edtNomeCliente: TDBEdit;
    edtRegCliente: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    zqClientes: TZQuery;
    zqClientesclienteid: TZIntegerField;
    zqClientescpf_cnpj_cliente: TZRawStringField;
    zqClientesnome_cliente: TZRawStringField;
    zqClientestipo_cliente: TZRawStringField;
    zuClientes: TZUpdateSQL;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure zqClientesAfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  cadClienteF: TcadClienteF;

implementation

{$R *.lfm}

{ TcadClienteF }

procedure TcadClienteF.FormShow(Sender: TObject);
begin
  inherited;
  zqClientes.Open;
end;

procedure TcadClienteF.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=False;
end;

procedure TcadClienteF.zqClientesAfterInsert(DataSet: TDataSet);
begin
  zqClientesclienteid.AsInteger:=StrToInt(dataModuleF.getSequence('cliente_clienteid_seq'));
end;

procedure TcadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  zqClientes.Close;
end;

procedure TcadClienteF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
   zqClientes.Close;
   zqClientes.SQL.Text :=
     'select clienteid, tipo_cliente, nome_cliente, cpf_cnpj_cliente '+
     'from cliente '+
     'where clienteid = ' + edtPesq.Text +
     'order by clienteid';
   zqClientes.Open;
   end
   else
   begin
     zqClientes.Close;
     zqClientes.SQL.Text :=
      'select * '+
      'from cliente '+
      'order by clienteid';
     zqClientes.Open;
   end;
end;

procedure TcadClienteF.btnNovoClick(Sender: TObject);
begin
  inherited;
  zqClientes.Insert;
end;

procedure TcadClienteF.btnGravarClick(Sender: TObject);
begin
  inherited;
  zqClientes.Post;
end;

procedure TcadClienteF.btnEditarClick(Sender: TObject);
begin
  zqClientes.Edit;
end;

procedure TcadClienteF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqClientes.Delete
  else
  begin
    ShowMessage('A exclusão foi cancelada.');
  end;
  inherited;
end;

procedure TcadClienteF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqClientes.Cancel;
end;

end.

