namespace NorpaNet.Data.Business;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.Data, 
  NorpaNet.Data;

type
  [Serializable()]
  orders = public class(Iorders)
  private
    var _Orderid                         : System.Int64    := 0;
    var _Orderdate                       : System.DateTime := System.DateTime.MinValue;
    var _Username                        : System.String   := System.String.Empty;
    var _Firstname                       : System.String   := System.String.Empty;
    var _Lastname                        : System.String   := System.String.Empty;
    var _Address                         : System.String   := System.String.Empty;
    var _City                            : System.String   := System.String.Empty;
    var _State                           : System.String   := System.String.Empty;
    var _Postalcode                      : System.String   := System.String.Empty;
    var _Country                         : System.String   := System.String.Empty;
    var _Phone                           : System.String   := System.String.Empty;
    var _Email                           : System.String   := System.String.Empty;
    var _Total                           : System.Decimal    := 0;
    var _Paymenttransactionid            : System.String   := System.String.Empty;
    var _Hasbeenshipped                  : System.String   := System.String.Empty;
    method Set_Orderid( Value  :  System.Int64 );
    method Get_Orderid :  System.Int64 ;
    method Set_Orderdate( Value  :  System.DateTime );
    method Get_Orderdate :  System.DateTime ;
    method Set_Username( Value  :  System.String );
    method Get_Username :  System.String ;
    method Set_Firstname( Value  :  System.String );
    method Get_Firstname :  System.String ;
    method Set_Lastname( Value  :  System.String );
    method Get_Lastname :  System.String ;
    method Set_Address( Value  :  System.String );
    method Get_Address :  System.String ;
    method Set_City( Value  :  System.String );
    method Get_City :  System.String ;
    method Set_State( Value  :  System.String );
    method Get_State :  System.String ;
    method Set_Postalcode( Value  :  System.String );
    method Get_Postalcode :  System.String ;
    method Set_Country( Value  :  System.String );
    method Get_Country :  System.String ;
    method Set_Phone( Value  :  System.String );
    method Get_Phone :  System.String ;
    method Set_Email( Value  :  System.String );
    method Get_Email :  System.String ;
    method Set_Total( Value  :  System.Decimal );
    method Get_Total :  System.Decimal ;
    method Set_Paymenttransactionid( Value  :  System.String );
    method Get_Paymenttransactionid :  System.String ;
    method Set_Hasbeenshipped( Value  :  System.String );
    method Get_Hasbeenshipped :  System.String ;
  protected
  public
    constructor;
  const
    C_Orderid                               : Int16   =   0;
    C_Orderdate                             : Int16   =   1;
    C_Username                              : Int16   =   2;
    C_Firstname                             : Int16   =   3;
    C_Lastname                              : Int16   =   4;
    C_Address                               : Int16   =   5;
    C_City                                  : Int16   =   6;
    C_State                                 : Int16   =   7;
    C_Postalcode                            : Int16   =   8;
    C_Country                               : Int16   =   9;
    C_Phone                                 : Int16   =  10;
    C_Email                                 : Int16   =  11;
    C_Total                                 : Int16   =  12;
    C_Paymenttransactionid                  : Int16   =  13;
    C_Hasbeenshipped                        : Int16   =  14;
    Property Orderid                         : System.Int64    read Get_Orderid                        write Set_Orderid                       ;
    Property Orderdate                       : System.DateTime read Get_Orderdate                      write Set_Orderdate                     ;
    Property Username                        : System.String   read Get_Username                       write Set_Username                      ;
    Property Firstname                       : System.String   read Get_Firstname                      write Set_Firstname                     ;
    Property Lastname                        : System.String   read Get_Lastname                       write Set_Lastname                      ;
    Property Address                         : System.String   read Get_Address                        write Set_Address                       ;
    Property City                            : System.String   read Get_City                           write Set_City                          ;
    Property State                           : System.String   read Get_State                          write Set_State                         ;
    Property Postalcode                      : System.String   read Get_Postalcode                     write Set_Postalcode                    ;
    Property Country                         : System.String   read Get_Country                        write Set_Country                       ;
    Property Phone                           : System.String   read Get_Phone                          write Set_Phone                         ;
    Property Email                           : System.String   read Get_Email                          write Set_Email                         ;
    Property Total                           : System.Decimal    read Get_Total                          write Set_Total                         ;
    Property Paymenttransactionid            : System.String   read Get_Paymenttransactionid           write Set_Paymenttransactionid          ;
    Property Hasbeenshipped                  : System.String   read Get_Hasbeenshipped                 write Set_Hasbeenshipped                ;
    method SaveChange:Int32;
    class method select_orders_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
    class method select_orders_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
    class method select_orders_Orderid_to_list(Orderid: System.Int64 ):orders;
    class method select_orders_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_orders_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method select_orders_with_spec_clause_where_to_list(value : System.String ):list<Iorders>;
    class method insert_or_update_orders( ORDERID: System.Int64   ; ORDERDATE: System.DateTime; USERNAME: System.String  ; FIRSTNAME: System.String  ; LASTNAME: System.String  ; ADDRESS: System.String  ; CITY: System.String  ; STATE: System.String  ; POSTALCODE: System.String  ; COUNTRY: System.String  ; PHONE: System.String  ; EMAIL: System.String  ; TOTAL: System.Decimal ; PAYMENTTRANSACTIONID: System.String  ; HASBEENSHIPPED: System.String  ):System.Int32;

  end;

implementation

constructor orders;
begin
//yeps
end;

method orders.SaveChange:Int32;
begin
exit insert_or_update_orders(Orderid,Orderdate,Username,Firstname,Lastname,Address,City,State,Postalcode,Country,Phone, Email,Total, Paymenttransactionid, Hasbeenshipped  );
end;

class method orders.select_orders_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
begin
  exit DBorders.select_orders_Orderid_to_reader(Orderid );
end;

class method orders.select_orders_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
begin
  exit DBorders.select_orders_Orderid_to_datatable(Orderid );
end;

class method orders.select_orders_Orderid_to_list(Orderid: System.Int64 ):orders;
function convertDT(value : Object):DateTime;
begin
  if value <> DBNull.Value then
    exit Convert.ToDateTime(value);
  exit System.DateTime.MinValue;
end;
function convertI16(value : Object):Int16;
begin
  if value <> DBNull.Value then
    exit Convert.ToInt16(value);
  exit -1;
end;
function convertI32(value : Object):Int32;
begin
  if value <> DBNull.Value then
    exit Convert.ToInt32(value);
  exit -1;
end;
function convertI64(value : Object):Int64;
begin
  if value <> DBNull.Value then
    exit Convert.ToInt64(value);
  exit -1;
end;
function convertFL(value : Object):Decimal;
begin
  if value <> DBNull.Value then
    exit Convert.ToDecimal(value);
  exit -1;
end;
begin
  var tmpDB : DataTable := DBorders.select_orders_Orderid_to_datatable(Orderid );
  var ii : Integer := 0;
  
    var mp : orders := new orders;
  for each row:DataRow in tmpDB.Rows do begin
     mp.Orderid                                := convertI64(row[0]);
     mp.Orderdate                              := convertDT(row[1]);
     mp.Username                               := row[2].ToString ;
     mp.Firstname                              := row[3].ToString ;
     mp.Lastname                               := row[4].ToString ;
     mp.Address                                := row[5].ToString ;
     mp.City                                   := row[6].ToString ;
     mp.State                                  := row[7].ToString ;
     mp.Postalcode                             := row[8].ToString ;
     mp.Country                                := row[9].ToString ;
     mp.Phone                                  := row[10].ToString ;
     mp.Email                                  := row[11].ToString ;
     mp.Total                                  := convertFL(row[12]);
     mp.Paymenttransactionid                   := row[13].ToString ;
     mp.Hasbeenshipped                         := row[14].ToString ;
  end;
  exit mp;
end;

class method orders.select_orders_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
  exit DBorders.select_orders_with_spec_clause_where_to_reader(value);
end;

class method orders.select_orders_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
  exit DBorders.select_orders_with_spec_clause_where_to_datatable(value);
end;

class method orders.select_orders_with_spec_clause_where_to_list(value : System.String ):list<Iorders>;
function convertDT(value : Object):DateTime;
begin
  if value <> DBNull.Value then
    exit Convert.ToDateTime(value);
  exit System.DateTime.MinValue;
end;
function convertI16(value : Object):Int16;
begin
  if value <> DBNull.Value then
    exit Convert.ToInt16(value);
  exit -1;
end;
function convertI32(value : Object):Int32;
begin
  if value <> DBNull.Value then
    exit Convert.ToInt32(value);
  exit -1;
end;
function convertI64(value : Object):Int64;
begin
  if value <> DBNull.Value then
    exit Convert.ToInt64(value);
  exit -1;
end;
function convertFL(value : Object):Decimal;
begin
  if value <> DBNull.Value then
    exit Convert.ToDecimal(value);
  exit -1;
end;
begin
  var tmpDB : DataTable := DBorders.select_orders_with_spec_clause_where_to_datatable(value);
  var ii : Integer := 0;
  var tmpList : List<Iorders> := new List<Iorders>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : Iorders := new orders;
     mp.Orderid                                := convertI64(row[0]);
     mp.Orderdate                              := convertDT(row[1]);
     mp.Username                               := row[2].ToString ;
     mp.Firstname                              := row[3].ToString ;
     mp.Lastname                               := row[4].ToString ;
     mp.Address                                := row[5].ToString ;
     mp.City                                   := row[6].ToString ;
     mp.State                                  := row[7].ToString ;
     mp.Postalcode                             := row[8].ToString ;
     mp.Country                                := row[9].ToString ;
     mp.Phone                                  := row[10].ToString ;
     mp.Email                                  := row[11].ToString ;
     mp.Total                                  := convertFL(row[12]);
     mp.Paymenttransactionid                   := row[13].ToString ;
     mp.Hasbeenshipped                         := row[14].ToString ;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method orders.insert_or_update_orders( ORDERID: System.Int64   ; ORDERDATE: System.DateTime; USERNAME: System.String  ; FIRSTNAME: System.String  ; LASTNAME: System.String  ; ADDRESS: System.String  ; CITY: System.String  ; STATE: System.String  ; POSTALCODE: System.String  ; COUNTRY: System.String  ; PHONE: System.String  ; EMAIL: System.String  ; TOTAL: System.Decimal ; PAYMENTTRANSACTIONID: System.String  ; HASBEENSHIPPED: System.String  ):System.Int32;
begin
  exit DBorders.insert_or_update_orders( ORDERID, ORDERDATE, USERNAME, FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, POSTALCODE, COUNTRY, PHONE, EMAIL, TOTAL, PAYMENTTRANSACTIONID, HASBEENSHIPPED);
end;

method orders.Set_Orderid( Value: System.Int64);
begin
  _Orderid := Value;
end;

method orders.Get_Orderid: System.Int64;
begin
  exit _Orderid;
end;

method orders.Set_Orderdate( Value: System.DateTime);
begin
  _Orderdate := Value;
end;

method orders.Get_Orderdate: System.DateTime;
begin
  exit _Orderdate;
end;

method orders.Set_Username( Value: System.String);
begin
  _Username := Value;
end;

method orders.Get_Username: System.String;
begin
  exit _Username;
end;

method orders.Set_Firstname( Value: System.String);
begin
  _Firstname := Value;
end;

method orders.Get_Firstname: System.String;
begin
  exit _Firstname;
end;

method orders.Set_Lastname( Value: System.String);
begin
  _Lastname := Value;
end;

method orders.Get_Lastname: System.String;
begin
  exit _Lastname;
end;

method orders.Set_Address( Value: System.String);
begin
  _Address := Value;
end;

method orders.Get_Address: System.String;
begin
  exit _Address;
end;

method orders.Set_City( Value: System.String);
begin
  _City := Value;
end;

method orders.Get_City: System.String;
begin
  exit _City;
end;

method orders.Set_State( Value: System.String);
begin
  _State := Value;
end;

method orders.Get_State: System.String;
begin
  exit _State;
end;

method orders.Set_Postalcode( Value: System.String);
begin
  _Postalcode := Value;
end;

method orders.Get_Postalcode: System.String;
begin
  exit _Postalcode;
end;

method orders.Set_Country( Value: System.String);
begin
  _Country := Value;
end;

method orders.Get_Country: System.String;
begin
  exit _Country;
end;

method orders.Set_Phone( Value: System.String);
begin
  _Phone := Value;
end;

method orders.Get_Phone: System.String;
begin
  exit _Phone;
end;

method orders.Set_Email( Value: System.String);
begin
  _Email := Value;
end;

method orders.Get_Email: System.String;
begin
  exit _Email;
end;

method orders.Set_Total( Value: System.Decimal);
begin
  _Total := Value;
end;

method orders.Get_Total: System.Decimal;
begin
  exit _Total;
end;

method orders.Set_Paymenttransactionid( Value: System.String);
begin
  _Paymenttransactionid := Value;
end;

method orders.Get_Paymenttransactionid: System.String;
begin
  exit _Paymenttransactionid;
end;

method orders.Set_Hasbeenshipped( Value: System.String);
begin
  _Hasbeenshipped := Value;
end;

method orders.Get_Hasbeenshipped: System.String;
begin
  exit _Hasbeenshipped;
end;

end.
