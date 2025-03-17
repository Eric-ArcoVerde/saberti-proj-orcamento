unit cadUsuarioU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, ZDataset, ZSqlUpdate, ZAbstractRODataset, xCadPaiU, DB, dataModuleU;

type

  { TcadUsuariosF }

  TcadUsuariosF = class(TxCadPaiF)
    edtID: TDBEdit;
    edtUsuario: TDBEdit;
    edtNome: TDBEdit;
    edtSenha: TDBEdit;
    dsUsuario: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnMostrarSenha: TSpeedButton;
    Label6: TLabel;
    zqUsuario: TZQuery;
    zqUsuarioid: TZIntegerField;
    zqUsuarionome_completo: TZRawStringField;
    zqUsuariosenha: TZRawStringField;
    zqUsuariousuario: TZRawStringField;
    zuUsuario: TZUpdateSQL;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMostrarSenhaClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure zqUsuarioAfterInsert(DataSet: TDataSet);
  private
    function ValidaCampos: Boolean;
  public

  end;

var
  cadUsuariosF: TcadUsuariosF;

implementation

{$R *.lfm}

{ TcadUsuariosF }

function TcadUsuariosF.ValidaCampos: boolean;
begin
  Result := True;
  if (Trim(zqUsuariousuario.AsString) = '') or
     (Trim(zqUsuarionome_completo.AsString) = '') or
     (Trim(zqUsuariosenha.AsString) = '') then
  begin
    ShowMessage('Preencha todos os Campos');
    Result := False;
  end;
end;

procedure TcadUsuariosF.FormShow(Sender: TObject);
begin
  inherited;
  zqUsuario.Open;
end;

procedure TcadUsuariosF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  zqUsuario.Close;
end;

procedure TcadUsuariosF.zqUsuarioAfterInsert(DataSet: TDataSet);
begin
  zqUsuarioid.AsInteger := StrToInt(DataModuleF.getSequence('usuarios_id_seq'));
end;

procedure TcadUsuariosF.btnPesqClick(Sender: TObject);
begin
  if edtPesq.Text <> '' then
  begin
    zqUsuario.Close;
    zqUsuario.SQL.Text :=
      'select id, usuario, nome_completo, senha ' + 'from usuarios ' +
      'where id = ' + edtPesq.Text + 'order by id';
    zqUsuario.Open;
  end
  else
  begin
    zqUsuario.Close;
    zqUsuario.SQL.Text :=
      'select * ' + 'from usuarios ' + 'order by id';
    zqUsuario.Open;
  end;
end;

procedure TcadUsuariosF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  zqUsuario.Edit;
end;

procedure TcadUsuariosF.btnNovoClick(Sender: TObject);
begin
  inherited;
  zqUsuario.Insert;
end;

procedure TcadUsuariosF.btnGravarClick(Sender: TObject);
begin
  if not ValidaCampos then
     Exit;
  if Length(zqUsuariosenha.AsString)<6 then
  begin
    ShowMessage('Senha muito pequena');
    Exit;
  end;
  inherited;
  zqUsuario.Post;
end;

procedure TcadUsuariosF.btnCancelarClick(Sender: TObject);
begin
  inherited;
  zqUsuario.Cancel;
end;

procedure TcadUsuariosF.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Você tem certeza que deseja excluir este item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    zqUsuario.Delete
  else
    Exit;
  inherited;
end;

procedure TcadUsuariosF.btnMostrarSenhaClick(Sender: TObject);
begin
  if edtSenha.PasswordChar = '*' then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*';
end;

end.
