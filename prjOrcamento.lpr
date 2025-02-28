program prjOrcamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, xCadPaiU, menuPrincipalU, cadCategoriaU, dataModuleU,
  cadClienteU, cadProdutosU, pesqCategoria;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDataModuleF, DataModuleF);
  Application.CreateForm(TMenuPrincipalF, MenuPrincipalF);
  Application.CreateForm(TcadCliente, cadCliente);
  Application.CreateForm(TcadProdutosF, cadProdutosF);
  Application.CreateForm(TpesqCategoriaF, pesqCategoriaF);
  Application.Run;
end.

