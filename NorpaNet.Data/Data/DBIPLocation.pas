namespace NorpaNet.Data;

interface

uses
  System,
  System.Xml,
  System.Globalization,
  System.Text,
  System.Data,
  System.Data.Common,
  System.Configuration,
  FirebirdSql.Data.FirebirdClient;
type
  DBIPLocation = public class
  private
    class method GetConnectionString: String;
  protected
  public
     class method GetOne(IPLONG : System.Int64): IDataReader;
  end;

implementation

class method DBIPLocation.GetConnectionString: String;
begin
  exit ConfigurationManager.AppSettings['FirebirdLogConnectionString']
end;

class method DBIPLocation.GetOne(IPLONG : System.Int64): IDataReader;
begin
  var sqlCommand: StringBuilder := new StringBuilder();
  sqlCommand.Append('SELECT  * ');
  sqlCommand.Append('FROM mp_ipligencemax ');
  sqlCommand.Append('WHERE ');
  sqlCommand.Append('@iplong between IP_FROM and IP_TO');
  sqlCommand.Append(';');

  var arParams: array of FbParameter := new FbParameter[1];

  arParams[0] := new FbParameter('@iplong', FbDbType.BigInt);
  arParams[0].Direction := ParameterDirection.Input;
  arParams[0].Value := IPLONG;

  exit FBSqlHelper.ExecuteReader(GetConnectionString(), sqlCommand.ToString(), arParams)
end;
end.
