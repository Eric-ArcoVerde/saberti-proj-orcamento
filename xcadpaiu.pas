unit xCadPaiU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Buttons, DBGrids;

type

  { TxCadPaiF }

  TxCadPaiF = class(TForm)
    btnGravar: TBitBtn;
    btnEditar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnNovo: TBitBtn;
    btnSair: TBitBtn;
    DBGrid1: TDBGrid;
    edtPesq: TEdit;
    Label1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    btnPesq: TSpeedButton;
    Panel3: TPanel;
    tsCadastro: TTabSheet;
    tsPesquisar: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  xCadPaiF: TxCadPaiF;

implementation

{$R *.lfm}

{ TxCadPaiF }

procedure TxCadPaiF.btnNovoClick(Sender: TObject);
begin
  PageControl1.PageIndex:=1;
end;

procedure TxCadPaiF.btnGravarClick(Sender: TObject);
begin
  PageControl1.PageIndex:=0;
end;

procedure TxCadPaiF.btnEditarClick(Sender: TObject);
begin
  PageControl1.PageIndex:=0;
end;

procedure TxCadPaiF.btnExcluirClick(Sender: TObject);
begin
  PageControl1.PageIndex:=0;
end;

procedure TxCadPaiF.btnCancelarClick(Sender: TObject);
begin
  PageControl1.PageIndex:=0;
end;

procedure TxCadPaiF.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TxCadPaiF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.PageIndex:=1;
end;

procedure TxCadPaiF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TxCadPaiF.FormShow(Sender: TObject);
begin
  PageControl1.PageIndex:=0;
end;

end.

