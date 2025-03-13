unit relOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_DBSet,
  LR_Class, ZDataset, ZAbstractRODataset, dataModuleU, LR_DSet;

type

  { TrelOrcamentoF }

  TrelOrcamentoF = class(TForm)
    btnImpressao: TBitBtn;
    frDBDSRelOrc: TfrDBDataSet;
    frRelOrc: TfrReport;
    zqRelOrc: TZQuery;
    zqRelOrcclienteid: TZIntegerField;
    zqRelOrcdt_orcamento: TZDateTimeField;
    zqRelOrcdt_validade_orcamento: TZDateTimeField;
    zqRelOrcnome_cliente: TZRawStringField;
    zqRelOrcorcamentoid: TZIntegerField;
    zqRelOrcvl_total_orcamento: TZBCDField;
    procedure btnImpressaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  relOrcamentoF: TrelOrcamentoF;

implementation

{$R *.lfm}

{ TrelOrcamentoF }

procedure TrelOrcamentoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  zqRelOrc.Close;
  CloseAction:=caFree;
end;

procedure TrelOrcamentoF.btnImpressaoClick(Sender: TObject);
begin
  frRelOrc.LoadFromFile('relOrcamento.lrf');
  frRelOrc.PrepareReport;
  frRelOrc.ShowReport;
end;

procedure TrelOrcamentoF.FormShow(Sender: TObject);
begin
  zqRelOrc.Open;
end;



end.

