unit loginU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, ExtCtrls, ZDataset, ZAbstractRODataset, dataModuleU, menuPrincipalU,
  DB;

type

  { TloginF }

  TloginF = class(TForm)
    btnEntrar: TButton;
    btnMostrarSenha: TSpeedButton;
    btnSair: TButton;
    edtUser: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnMostrarSenhaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public
    function ValidaUsuario(pUsusario: string; pSenha: string): boolean;
  end;

var
  loginF: TloginF;

implementation

{$R *.lfm}

{ TloginF }

function TloginF.ValidaUsuario(pUsusario: string; pSenha: string): boolean;
begin
  if (pUsusario = '') then
  begin
    ShowMessage('Favor Preencha o Usuário!');
    edtUser.SetFocus;
    Exit(False);
  end;

  if (pSenha = '') then
  begin
    ShowMessage('Favor Preencha a Senha!');
    edtSenha.SetFocus;
    Exit(False);
  end;

  DataModuleF.zqGenerica.Close;
  DataModuleF.zqGenerica.SQL.Clear;
  DataModuleF.zqGenerica.SQL.Add('SELECT COUNT(*) AS NUMBER ' +
    'FROM USUARIOS ' + 'WHERE USUARIO = ' + QuotedStr(pUsusario) +
    ' ' + 'AND SENHA = ' + QuotedStr(pSenha));
  DataModuleF.zqGenerica.Open;

  if DataModuleF.zqGenerica.FieldByName('NUMBER').AsInteger = 0 then
  begin
    ShowMessage('Senha ou Usuário incorretos!');
    edtUser.SetFocus;
    Result := False;
  end
  else
    Result := True;

end;

procedure TloginF.FormShow(Sender: TObject);
begin
  edtUser.SetFocus;
end;

procedure TloginF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := cafree;
end;

procedure TloginF.btnMostrarSenhaClick(Sender: TObject);
begin
  if edtSenha.PasswordChar = '*' then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*';
end;

procedure TloginF.btnEntrarClick(Sender: TObject);
begin
  if ValidaUsuario(edtUser.Text, edtSenha.Text) = True then
  begin
    MenuPrincipalF := TMenuPrincipalF.Create(Self);
    MenuPrincipalF.ShowModal;
    Close;
  end;
end;

procedure TloginF.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
