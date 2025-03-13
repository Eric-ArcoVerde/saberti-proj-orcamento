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
  orcamentoU, pesClienteU, inserirItemU, pesqProdutoU, relProdutos,
  relOrcamento, relCategorias, relOrcItemU, loginU, sobreU;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDataModuleF, DataModuleF);
  Application.CreateForm(TloginF, loginF);
  Application.Run;
end.

