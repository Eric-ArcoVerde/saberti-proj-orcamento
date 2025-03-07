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
  cadClienteU, cadProdutosU, pesqCategoria, relClientesU, cadUsuarioU, 
orcamentoU, pesClienteU, inserirItemU, pesqProdutoU;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDataModuleF, DataModuleF);
  Application.CreateForm(TMenuPrincipalF, MenuPrincipalF);
  Application.CreateForm(TorcamentoF, orcamentoF);
  Application.CreateForm(TpesqClienteF, pesqClienteF);
  Application.CreateForm(TinserirItemF, inserirItemF);
  Application.CreateForm(TpesqProdutosF, pesqProdutosF);
  Application.Run;
end.

