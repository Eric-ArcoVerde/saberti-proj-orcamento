unit menuPrincipalU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, cadCategoriaU, cadProdutosU, cadClienteU, cadUsuarioU, orcamentoU,
  relCategorias, relProdutos, relClientesU, relOrcamento, sobreU;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
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
    procedure miRelCategoriasClick(Sender: TObject);
    procedure miRelClientesClick(Sender: TObject);
    procedure miRelOrcamentoClick(Sender: TObject);
    procedure miRelProdutosClick(Sender: TObject);
    procedure miSairClick(Sender: TObject);
    procedure miSobreClick(Sender: TObject);
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
  cadCategoriaF := TcadCategoriaF.Create(Self);
  cadCategoriaF.ShowModal;
end;

procedure TMenuPrincipalF.miCadClienteClick(Sender: TObject);
begin
  cadClienteF := TcadClienteF.Create(Self);
  cadClienteF.ShowModal;
end;

procedure TMenuPrincipalF.miCadProdutosClick(Sender: TObject);
begin
  cadProdutosF := TcadProdutosF.Create(Self);
  cadProdutosF.ShowModal;
end;

procedure TMenuPrincipalF.miCadUsuariosClick(Sender: TObject);
begin
  cadUsuariosF := TcadUsuariosF.Create(Self);
  cadUsuariosF.ShowModal;
end;

procedure TMenuPrincipalF.miOrcamentoClick(Sender: TObject);
begin
  orcamentoF := TorcamentoF.Create(Self);
  orcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.miRelCategoriasClick(Sender: TObject);
begin
  relCategoriasF := TrelCategoriasF.Create(Self);
  relCategoriasF.ShowModal;
end;

procedure TMenuPrincipalF.miRelClientesClick(Sender: TObject);
begin
  RelClientesF := TRelClientesF.Create(Self);
  RelClientesF.ShowModal;
end;

procedure TMenuPrincipalF.miRelProdutosClick(Sender: TObject);
begin
  relProdutosF := TrelProdutosF.Create(Self);
  relProdutosF.ShowModal;
end;

procedure TMenuPrincipalF.miRelOrcamentoClick(Sender: TObject);
begin
  relOrcamentoF := TrelOrcamentoF.Create(Self);
  relOrcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.miSobreClick(Sender: TObject);
begin
  sobreF := TsobreF.Create(Self);
  sobreF.ShowModal;
end;

procedure TMenuPrincipalF.miSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

