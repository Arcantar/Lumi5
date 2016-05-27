namespace NorpaNet.Data;

interface

uses
  System,
  System.Configuration,
  System.Data,
  System.Globalization,
  System.Text,
  FirebirdSql.Data.FirebirdClient;

type
  DBSystemLog = public class
  private
    class method GetWriteLogConnectionString: String;
  protected
  public
    class method NP_LOG_I(NP_DATETIME: System.DateTime; NP_METHODE: System.String; NP_CULTURE: System.String; NP_IPADRESSV4: System.String; NP_URL: System.String; NP_USERNAME: System.String; NP_USERAGENT: System.String; NP_RESPONSECODE: System.String; NP_SITENAME: System.String;  NP_APPLICATIONNAME: System.String; NP_REFFERT: System.String; NP_RESPONSETIME: System.Int32; SESSIONID:System.String;
ipfrom         : System.Int64  ;ipto           : System.Int64  ;country_code   : System.String ;country_name   : System.String ;continent_code : System.String ;continent_name : System.String ;
time_zone      : System.String ; region_code    : System.String ; region_name    : System.String ; owner          : System.String ;city_name      : System.String  ; county_name   : System.String;latitude       : System.Decimal;longitude      : System.Decimal): System.Int32; //; IPUSER : IPLocation

  end;

implementation

class method DBSystemLog.GetWriteLogConnectionString: String;
begin
  exit ConfigurationManager.AppSettings['FirebirdLogConnectionString']
end;

class method DBSystemLog.NP_LOG_I(NP_DATETIME: System.DateTime; NP_METHODE: System.String; NP_CULTURE: System.String; NP_IPADRESSV4: System.String; NP_URL: System.String; NP_USERNAME: System.String; NP_USERAGENT: System.String; NP_RESPONSECODE: System.String; NP_SITENAME: System.String;  NP_APPLICATIONNAME: System.String; NP_REFFERT: System.String; NP_RESPONSETIME: System.Int32; SESSIONID:System.String;
ipfrom         : System.Int64  ;ipto           : System.Int64  ;country_code   : System.String ;country_name   : System.String ;continent_code : System.String ;continent_name : System.String ;
time_zone      : System.String ; region_code    : System.String ; region_name    : System.String ; owner          : System.String ;city_name      : System.String ; county_name   : System.String ;latitude       : System.Decimal;longitude      : System.Decimal): System.Int32; //; IPUSER : IPLocation
function ConvertToLong(ipv4Address: System.String): Int64;
begin
  var fresult: Int64 := 0;
  if ipv4Address.Contains(':') then begin
    exit fresult
  end;
  var fipAddress: System.Net.IPAddress;
  if fipAddress.TryParse(ipv4Address, out fipAddress) then begin
    var b: array of System.Byte := fipAddress.GetAddressBytes();
    if b.Length >= 4 then begin
      fresult := System.Int64((b[0] * 16777216));
      fresult := fresult + System.Int64((b[1] * 65536));
      fresult := fresult + System.Int64((b[2] * 256));
      fresult := fresult + System.Int64((b[3] * 1))
    end
  end;
  exit fresult;
end;
begin
  var arParams: array of FbParameter := new FbParameter[28];

  arParams[0] := new FbParameter(':NP_DATETIME', FbDbType.TimeStamp);
  arParams[0].Direction := ParameterDirection.Input;
  arParams[0].Value := NP_DATETIME;

  arParams[1] := new FbParameter(':NP_METHODE', FbDbType.VarChar, 50);
  arParams[1].Direction := ParameterDirection.Input;
  arParams[1].Value := NP_METHODE;

  arParams[2] := new FbParameter(':NP_CULTURE', FbDbType.VarChar, 5);
  arParams[2].Direction := ParameterDirection.Input;
  arParams[2].Value := NP_CULTURE;
 
  arParams[3] := new FbParameter(':NP_IPADRESSV4', FbDbType.VarChar, 16);
  arParams[3].Direction := ParameterDirection.Input;
  arParams[3].Value := NP_IPADRESSV4;

  arParams[4] := new FbParameter(':NP_URL', FbDbType.VarChar, 254);
  arParams[4].Direction := ParameterDirection.Input;
  arParams[4].Value := NP_URL;

  arParams[5] := new FbParameter(':NP_USERNAME', FbDbType.VarChar, 50);
  arParams[5].Direction := ParameterDirection.Input;
  arParams[5].Value := NP_USERNAME;

  arParams[6] := new FbParameter(':NP_USERAGENT', FbDbType.VarChar, 255);
  arParams[6].Direction := ParameterDirection.Input;
  arParams[6].Value := NP_USERAGENT;

  arParams[7] := new FbParameter(':NP_RESPONSECODE', FbDbType.VarChar, 50);
  arParams[7].Direction := ParameterDirection.Input;
  arParams[7].Value := NP_RESPONSECODE;

  arParams[8] := new FbParameter(':NP_SITENAME', FbDbType.VarChar, 50);
  arParams[8].Direction := ParameterDirection.Input;
  arParams[8].Value := NP_SITENAME;

  arParams[9] := new FbParameter(':NP_APPLICATIONNAME', FbDbType.VarChar, 50);
  arParams[9].Direction := ParameterDirection.Input;
  arParams[9].Value := NP_APPLICATIONNAME;

  arParams[10] := new FbParameter(':NP_REFFERT', FbDbType.VarChar, 4000);
  arParams[10].Direction := ParameterDirection.Input;
  arParams[10].Value := NP_REFFERT;

  arParams[11] := new FbParameter(':NP_RESPONSETIME', FbDbType.Integer);
  arParams[11].Direction := ParameterDirection.Input;
  arParams[11].Value := NP_RESPONSETIME;

  arParams[12] := new FbParameter(':SESSIONID', FbDbType.VarChar, 255);
  arParams[12].Direction := ParameterDirection.Input;
  arParams[12].Value := SESSIONID;

  arParams[13] := new FbParameter(':IPLONG', FbDbType.BigInt);
  arParams[13].Direction := ParameterDirection.Input;
  arParams[13].Value := ConvertToLong(NP_IPADRESSV4);

  arParams[14] := new FbParameter(':IP_FROM', FbDbType.BigInt);
  arParams[14].Direction := ParameterDirection.Input;
  arParams[14].Value := ipfrom;        

  arParams[15] := new FbParameter(':IP_TO', FbDbType.BigInt);
  arParams[15].Direction := ParameterDirection.Input;
  arParams[15].Value := ipto;          

  arParams[16] := new FbParameter(':COUNTRY_CODE', FbDbType.VarChar, 10);
  arParams[16].Direction := ParameterDirection.Input;
  arParams[16].Value := country_code;  

  arParams[17] := new FbParameter(':COUNTRY_NAME', FbDbType.VarChar, 255);
  arParams[17].Direction := ParameterDirection.Input;
  arParams[17].Value := country_name;  

  arParams[18] := new FbParameter(':CONTINENT_CODE', FbDbType.VarChar, 10);
  arParams[18].Direction := ParameterDirection.Input;
  arParams[18].Value := continent_code;

  arParams[19] := new FbParameter(':CONTINENT_NAME', FbDbType.VarChar, 255);
  arParams[19].Direction := ParameterDirection.Input;
  arParams[19].Value := continent_name;

  arParams[20] := new FbParameter(':TIME_ZONE', FbDbType.VarChar, 10);
  arParams[20].Direction := ParameterDirection.Input;
  arParams[20].Value := time_zone ;    

  arParams[21] := new FbParameter(':REGION_CODE', FbDbType.VarChar, 10);
  arParams[21].Direction := ParameterDirection.Input;
  arParams[21].Value := region_code ;  

  arParams[22] := new FbParameter(':REGION_NAME', FbDbType.VarChar, 255);
  arParams[22].Direction := ParameterDirection.Input;
  arParams[22].Value := region_name ;  

  arParams[23] := new FbParameter(':OWNER', FbDbType.VarChar, 255);
  arParams[23].Direction := ParameterDirection.Input;
  arParams[23].Value := owner ;        

  arParams[24] := new FbParameter(':CITY_NAME', FbDbType.VarChar, 255);
  arParams[24].Direction := ParameterDirection.Input;
  arParams[24].Value := city_name ;  

  arParams[25] := new FbParameter(':COUNTY_NAME', FbDbType.VarChar, 255);
  arParams[25].Direction := ParameterDirection.Input;
  arParams[25].Value := county_name ;   

  arParams[26] := new FbParameter(':LATITUDE', FbDbType.Float);
  arParams[26].Direction := ParameterDirection.Input;
  arParams[26].Value := latitude;      

  arParams[27] := new FbParameter(':LONGITUDE', FbDbType.Float);
  arParams[27].Direction := ParameterDirection.Input;
  arParams[27].Value := longitude;     
  
 var  newID: System.Int32 := 1 ;
 newID := FBSqlHelper.ExecuteNonQuery(GetWriteLogConnectionString(), CommandType.StoredProcedure, 'EXECUTE PROCEDURE  NP_LOG_I_EX3 (' + FBSqlHelper.GetParamString(arParams.Length) + ')', arParams);
 exit newID;
end;
end.
