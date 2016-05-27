namespace NorpaNet;

interface

uses
  System,
  System.Data;

type
  
  [Serializable()]
  IPLocation = public class
  private
       
 //   method GetLocation(IPV4: System.String);

    var _ipfrom         : System.Int64  := 0;
    var _ipto           : System.Int64  := 0;
    var _country_code   : System.String := System.String.Empty;
    var _country_name   : System.String := System.String.Empty;
    var _continent_code : System.String := System.String.Empty;
    var _continent_name : System.String := System.String.Empty;
    var _time_zone      : System.String := System.String.Empty;
    var _region_code    : System.String := System.String.Empty;
    var _region_name    : System.String := System.String.Empty;
    var _owner          : System.String := System.String.Empty;
    var _city_name      : System.String := System.String.Empty;
    var _county_name    : System.String := System.String.Empty;
    var _latitude       : System.Decimal:= 0;
    var _longitude      : System.Decimal:= 0;
  protected
  public
    
    constructor ;
    constructor(IPV4: System.String);
    method GetLocation(IPV4: System.String);

    property ipfrom         : System.Int64   read _ipfrom         write _ipfrom;
    property ipto           : System.Int64   read _ipto           write _ipto; 
    property country_code   : System.String  read _country_code   write _country_code;
    property country_name   : System.String  read _country_name   write _country_name;
    property continent_code : System.String  read _continent_code write _continent_code;
    property continent_name : System.String  read _continent_name write _continent_name;
    property time_zone      : System.String  read _time_zone      write _time_zone;
    property region_code    : System.String  read _region_code    write _region_code;
    property region_name    : System.String  read _region_name    write _region_name;
    property owner          : System.String  read _owner          write _owner;
    property city_name      : System.String  read _city_name      write _city_name;
    property county_name    : System.String  read _county_name    write _county_name;
    property latitude       : System.Decimal read _latitude       write _latitude;
    property longitude      : System.Decimal read _longitude      write _longitude;
  end;

implementation

uses 
  System.Net, 
  NorpaNet.Helper, 
  NorpaNet.Helper.Cache;

constructor IPLocation;
begin

end;

constructor IPLocation(IPV4: System.String);
begin
  GetLocation(IPV4);
end;


method IPLocation.GetLocation(IPV4: System.String);
function ConvertToLong(ipv4Address: System.String): Int64;
begin
  var fresult: Int64 := 0;
  if ipv4Address.Contains(':') then begin
    exit fresult
  end;
  var fipAddress: IPAddress;
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
 
    var rd : IDataReader ;
    var a:= Async begin               
      rd := NorpaNet.Data.DBIPLocation.GetOne(ConvertToLong(IPV4));
    end; a;
   
    if rd.Read() then begin
      _ipfrom            := Convert.ToInt64(rd['ip_from'].ToString);
      _ipto              := Convert.ToInt64(rd['ip_to'].ToString);
      _country_code      := rd['country_code'].ToString;
      _country_name      := rd['country_name'].ToString;
      _continent_code    := rd['continent_code'].ToString;
      _continent_name    := rd['continent_name'].ToString;
      _time_zone         := rd['time_zone'].ToString;
      _region_code       := rd['region_code'].ToString;
      _region_name       := rd['region_name'].ToString;
      _owner             := rd['owner'].ToString;
      _city_name         := rd['city_name'].ToString;
      _country_name      := rd['country_name'].ToString;
      _latitude          := Convert.ToDecimal(rd['latitude'].ToString); 
      _longitude         := Convert.ToDecimal(rd['longitude'].ToString);
    end;    

end;

end.
