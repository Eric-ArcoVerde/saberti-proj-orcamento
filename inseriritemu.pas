unit inserirItemU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, ZDataset, pesqProdutoU;

type

  { TinserirItemF }

  TinserirItemF = class(TForm)
    btnPesq: TBitBtn;
    btnInserir: TBitBtn;
    btnCancelar: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    edtQtde: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure edtQtdeExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  inserirItemF: TinserirItemF;

implementation

uses
  orcamentoU;

{$R *.lfm}

{ TinserirItemF }

procedure TinserirItemF.btnPesqClick(Sender: TObject);
begin
  pesqProdutosF:=TpesqProdutosF.Create(Self);
  pesqProdutosF.ShowModal;
end;

procedure TinserirItemF.edtQtdeExit(Sender: TObject);
begin
    orcamentoF.zqOrcItemvl_total.AsFloat := orcamentoF.zqOrcItemqt_produto.AsFloat * orcamentoF.zqOrcItemvl_unitario.AsFloat;
end;

procedure TinserirItemF.btnInserirClick(Sender: TObject);
begin
  if orcamentoF.zqOrcItemqt_produto.AsInteger < 1 then
  begin
    ShowMessage('Insira uma quantidade');
    edtQtde.SetFocus;
    Abort;
  end
  else
  begin
    orcamentoF.zqOrcItem.Post;
    Close;
  end;
end;

procedure TinserirItemF.btnCancelarClick(Sender: TObject);
begin
  orcamentoF.zqOrcItem.Cancel;
  Close;
end;

procedure TinserirItemF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

end.

