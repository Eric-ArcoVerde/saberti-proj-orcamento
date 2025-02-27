unit cadClienteU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset, ZSqlUpdate,
  xCadPaiU, DB;

type

  { TcadCliente }

  TcadCliente = class(TxCadPaiF)
    DataSource1: TDataSource;
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

