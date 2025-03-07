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
    dsAuxProduto: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    zqAuxProduto: TZQuery;
    procedure btnPesqClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  inserirItemF: TinserirItemF;

implementation

{$R *.lfm}

{ TinserirItemF }

procedure TinserirItemF.btnPesqClick(Sender: TObject);
begin
  pesqProdutosF:=TpesqProdutosF.Create(Self);
  pesqProdutosF.ShowModal;
end;

procedure TinserirItemF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:=caFree;
end;

end.

