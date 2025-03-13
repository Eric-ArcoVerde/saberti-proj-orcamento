unit relOrcItemU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ZDataset,
  ZAbstractRODataset, LR_Class, LR_DBSet, dataModuleU;

type

  { TrelOrcItemF }

  TrelOrcItemF = class(TForm)
    btnImpressao: TBitBtn;
    frDBDSRelOrcItem: TfrDBDataSet;
    frRelOcrItem: TfrReport;
    zqRelOrcItem: TZQuery;
    zqRelOrcItemorcamentoid: TZIntegerField;
    zqRelOrcItemorcamentoitemid: TZIntegerField;
    zqRelOrcItemproduto_desc: TZRawStringField;
    zqRelOrcItemqt_produto: TZBCDField;
    zqRelOrcItemvl_total: TZBCDField;
    zqRelOrcItemvl_unitario: TZBCDField;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  relOrcItemF: TrelOrcItemF;

implementation

{$R *.lfm}

{ TrelOrcItemF }

procedure TrelOrcItemF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  zqRelOrcItem.Close;
  CloseAction:=caFree;
end;

procedure TrelOrcItemF.FormShow(Sender: TObject);
begin
  zqRelOrcItem.Open;
end;

end.

