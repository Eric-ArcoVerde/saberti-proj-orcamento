unit dataModuleU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset;

type

  { TDataModuleF }

  TDataModuleF = class(TDataModule)
    ZConnection1: TZConnection;
    zqGenerica: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    function getSequence(const pNomeSequence:String):String;
  end;

var
  DataModuleF: TDataModuleF;

implementation

{$R *.lfm}

{ TDataModuleF }


procedure TDataModuleF.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.HostName := 'localhost';
  ZConnection1.DataBase := 'postgres';
  ZConnection1.User := 'postgres';
  ZConnection1.Password := '12345';
  ZConnection1.Port := 5432;
  ZConnection1.Protocol := 'postgresql';
end;

function TDataModuleF.getSequence(const pNomeSequence: String): String;
begin
     Result := '';
 try
     zqGenerica.close;
     zqGenerica.SQL.Clear;
     zqGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
     zqGenerica.Open;
     Result := zqGenerica.FieldByName('CODIGO').AsString;
 finally
   zqGenerica.Close;
 end;
end;

end.
