unit loginU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, dataModuleU,
  menuPrincipalU;

type

  { TloginF }

  TloginF = class(TForm)
    btnEntrar: TButton;
    btnSair: TButton;
    edtSenha: TEdit;
    edtUser: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public
    function ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
  end;

var
  loginF: TloginF;

implementation

{$R *.lfm}

{ TloginF }

function TloginF.ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
begin
   if (pUsusario = '') then
   begin
      ShowMessage('Favor Preencha o Usuário!');
      edtUser.SetFocus;
      Exit;
   end;

   if (pSenha = '') then
   begin
      ShowMessage('Favor Preencha a Senha!');
      edtSenha.SetFocus;
      Exit;
   end;

   DataModuleF.zqGenerica.Close;
   DataModuleF.zqGenerica.SQL.Clear;
   DataModuleF.zqGenerica.SQL.Add('SELECT COUNT(*) AS NUMBER '+
                                   'FROM USUARIOS '+
                                   'WHERE USUARIO = ' +  QuotedStr(pUsusario) + ' ' +
                                   'AND SENHA = ' + QuotedStr(pSenha));
   DataModuleF.zqGenerica.Open;

   if DataModuleF.zqGenerica.FieldByName('NUMBER').AsInteger = 0 then
   Begin
      ShowMessage('Senha ou Usuário incorretos!');
      edtUser.SetFocus;
      Result := False
   end
   else
      Result := True;

end;

procedure TloginF.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TloginF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=cafree;
end;

procedure TloginF.FormShow(Sender: TObject);
begin
  edtUser.SetFocus;
end;

procedure TloginF.btnEntrarClick(Sender: TObject);
begin
  if ValidaUsuario(edtUser.Text,edtSenha.Text) = true then
  begin
     MenuPrincipalF := TMenuPrincipalF.Create(Self);
     MenuPrincipalF.ShowModal;
     close;
  end;

end;

end.

