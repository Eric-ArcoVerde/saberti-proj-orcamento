unit menuPrincipalU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, cadCategoriaU,
  cadProdutosU, relClientesU, cadClienteU, cadUsuarioU, orcamentoU;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    MainMenu1: TMainMenu;
    miRelTeste: TMenuItem;
    miRelOrcamento: TMenuItem;
    miRelCategorias: TMenuItem;
    miRelProdutos: TMenuItem;
    miSair: TMenuItem;
    miSobre: TMenuItem;
    miVendas: TMenuItem;
    miRelClientes: TMenuItem;
    miRelatorios: TMenuItem;
    miOrcamento: TMenuItem;
    miCadUsuarios: TMenuItem;
    miCadProdutos: TMenuItem;
    miCadCliente: TMenuItem;
    miCadastros: TMenuItem;
    miCadCategoria: TMenuItem;
    Separator1: TMenuItem;
    procedure miCadCategoriaClick(Sender: TObject);
    procedure miCadClienteClick(Sender: TObject);
    procedure miCadProdutosClick(Sender: TObject);
    procedure miCadUsuariosClick(Sender: TObject);
    procedure miOrcamentoClick(Sender: TObject);
    procedure miRelClientesClick(Sender: TObject);
    procedure miSairClick(Sender: TObject);
  private

  public

  end;

var
  MenuPrincipalF: TMenuPrincipalF;

implementation

{$R *.lfm}

{ TMenuPrincipalF }

procedure TMenuPrincipalF.miCadCategoriaClick(Sender: TObject);
begin
  cadCategoriaF:=TcadCategoriaF.Create(Self);
  cadCategoriaF.ShowModal;
end;

procedure TMenuPrincipalF.miCadClienteClick(Sender: TObject);
begin
  cadClienteF:=TcadClienteF.Create(Self);
  cadClienteF.ShowModal;
end;

procedure TMenuPrincipalF.miCadProdutosClick(Sender: TObject);
begin
  cadProdutosF:=TcadProdutosF.Create(Self);
  cadProdutosF.ShowModal;
end;

procedure TMenuPrincipalF.miCadUsuariosClick(Sender: TObject);
begin
  cadUsuariosF:=TcadUsuariosF.Create(Self);
  cadUsuariosF.ShowModal;
end;

procedure TMenuPrincipalF.miOrcamentoClick(Sender: TObject);
begin
  orcamentoF:=TorcamentoF.Create(Self);
  orcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.miRelClientesClick(Sender: TObject);
begin
  RelClientesF:=TRelClientesF.Create(Self);
  RelClientesF.ShowModal;
end;

procedure TMenuPrincipalF.miSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

