unit relClientesU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ZDataset,
  ZAbstractRODataset, LR_Class, LR_DBSet, dataModuleU, LR_DSet;

type

  { TRelClientesF }

  TRelClientesF = class(TForm)
    btnImpressao: TBitBtn;
    frDBDSRelCliente: TfrDBDataSet;
    frRelCliente: TfrReport;
    zqRelCliente: TZQuery;
    zqRelClienteclienteid: TZIntegerField;
    zqRelClientecpf_cnpj_cliente: TZRawStringField;
    zqRelClientenome_cliente: TZRawStringField;
    zqRelClientetipo_cliente: TZRawStringField;
    procedure btnImpressaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  RelClientesF: TRelClientesF;

implementation

{$R *.lfm}

{ TRelClientesF }

procedure TRelClientesF.btnImpressaoClick(Sender: TObject);
begin
  frRelCliente.LoadFromFile('relCliente.lrf');
  frRelCliente.PrepareReport;
  frRelCliente.ShowReport;
end;

procedure TRelClientesF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  zqRelCliente.Close;
  CloseAction:=caFree;
end;

procedure TRelClientesF.FormShow(Sender: TObject);
begin
  zqRelCliente.Open;
end;


end.

