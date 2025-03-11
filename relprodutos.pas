unit relProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ZDataset,
  LR_Class, LR_DBSet, dataModuleU;

type

  { TrelProdutosF }

  TrelProdutosF = class(TForm)
    btnImpressao: TBitBtn;
    frDBDSRelProd: TfrDBDataSet;
    frRelProd: TfrReport;
    zqRelProd: TZQuery;
  private

  public

  end;

var
  relProdutosF: TrelProdutosF;

implementation

{$R *.lfm}

end.

