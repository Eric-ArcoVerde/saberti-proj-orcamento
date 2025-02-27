unit cadClienteU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ZDataset,
  ZSqlUpdate, xCadPaiU, DB;

type

  { TcadCliente }

  TcadCliente = class(TxCadPaiF)
    DataSource1: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ZQuery1: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
  private

  public

  end;

var
  cadCliente: TcadCliente;

implementation

{$R *.lfm}

end.

