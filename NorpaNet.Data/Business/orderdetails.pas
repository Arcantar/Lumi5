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
  orderdetails = public class(Iorderdetails)
  private
    var _Orderdetailid                   : System.Int64    := 0;
    var _Orderid                         : System.Int64    := 0;
    var _Username                        : System.String   := System.String.Empty;
    var _Productid                       : System.Int64    := 0;
    var _Quantity                        : System.Int32    := 0;
    var _Unitprice                       : System.Double   := 0;
    method Set_Orderdetailid( Value  :  System.Int64 );
    method Get_Orderdetailid :  System.Int64 ;
    method Set_Orderid( Value  :  System.Int64 );
    method Get_Orderid :  System.Int64 ;
    method Set_Username( Value  :  System.String );
    method Get_Username :  System.String ;
    method Set_Productid( Value  :  System.Int64 );
    method Get_Productid :  System.Int64 ;
    method Set_Quantity( Value  :  System.Int32 );
    method Get_Quantity :  System.Int32 ;
    method Set_Unitprice( Value  :  System.Double );
    method Get_Unitprice :  System.Double ;
  protected
  public
    constructor;
  const
    C_Orderdetailid                         : Int16   =   0;
    C_Orderid                               : Int16   =   1;
    C_Username                              : Int16   =   2;
    C_Productid                             : Int16   =   3;
    C_Quantity                              : Int16   =   4;
    C_Unitprice                             : Int16   =   5;
    Property Orderdetailid                   : System.Int64    read Get_Orderdetailid                  write Set_Orderdetailid                 ;
    Property Orderid                         : System.Int64    read Get_Orderid                        write Set_Orderid                       ;
    Property Username                        : System.String   read Get_Username                       write Set_Username                      ;
    Property Productid                       : System.Int64    read Get_Productid                      write Set_Productid                     ;
    Property Quantity                        : System.Int32    read Get_Quantity                       write Set_Quantity                      ;
    Property Unitprice                       : System.Double   read Get_Unitprice                      write Set_Unitprice                     ;
    method SaveChange:Int32;
    class method select_orderdetails_Orderdetailid_to_reader(Orderdetailid: System.Int64 ):IDataReader;
    class method select_orderdetails_Orderdetailid_to_datatable(Orderdetailid: System.Int64 ):DataTable;
    class method select_orderdetails_Orderdetailid_to_list(Orderdetailid: System.Int64 ):list<Iorderdetails>;
    class method select_orderdetails_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
    class method select_orderdetails_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
    class method select_orderdetails_Orderid_to_list(Orderid: System.Int64 ):list<Iorderdetails>;
    class method select_orderdetails_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_orderdetails_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method select_orderdetails_with_spec_clause_where_to_list(value : System.String ):list<Iorderdetails>;
    class method insert_or_update_orderdetails( ORDERDETAILID: System.Int64   ; ORDERID: System.Int64   ; USERNAME: System.String  ; PRODUCTID: System.Int64   ; QUANTITY: System.Int32   ; UNITPRICE: System.Double  ):System.Int32;
  end;

implementation

constructor orderdetails;
begin
//yeps
end;

method orderdetails.SaveChange: Int32;
begin
exit insert_or_update_orderdetails( Orderdetailid, Orderid, Username, Productid, Quantity, Unitprice);
end;

class method orderdetails.select_orderdetails_Orderdetailid_to_reader(Orderdetailid: System.Int64 ):IDataReader;
begin
  exit DBorderdetails.select_orderdetails_Orderdetailid_to_reader(Orderdetailid );
end;

class method orderdetails.select_orderdetails_Orderdetailid_to_datatable(Orderdetailid: System.Int64 ):DataTable;
begin
  exit DBorderdetails.select_orderdetails_Orderdetailid_to_datatable(Orderdetailid );
end;

class method orderdetails.select_orderdetails_Orderdetailid_to_list(Orderdetailid: System.Int64 ):list<Iorderdetails>;
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
  var tmpDB : DataTable := DBorderdetails.select_orderdetails_Orderdetailid_to_datatable(Orderdetailid );
  var ii : Integer := 0;
  var tmpList : List<Iorderdetails> := new List<Iorderdetails>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : Iorderdetails := new orderdetails;
     mp.Orderdetailid                          := convertI64(row[0]);
     mp.Orderid                                := convertI64(row[1]);
     mp.Username                               := row[2].ToString ;
     mp.Productid                              := convertI64(row[3]);
     mp.Quantity                               := convertI32(row[4]);
     mp.Unitprice                              := Convert.ToDouble(row[5]);
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method orderdetails.select_orderdetails_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
begin
  exit DBorderdetails.select_orderdetails_Orderid_to_reader(Orderid );
end;

class method orderdetails.select_orderdetails_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
begin
  exit DBorderdetails.select_orderdetails_Orderid_to_datatable(Orderid );
end;

class method orderdetails.select_orderdetails_Orderid_to_list(Orderid: System.Int64 ):list<Iorderdetails>;
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
  var tmpDB : DataTable := DBorderdetails.select_orderdetails_Orderid_to_datatable(Orderid );
  var ii : Integer := 0;
  var tmpList : List<Iorderdetails> := new List<Iorderdetails>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : Iorderdetails := new orderdetails;
     mp.Orderdetailid                          := convertI64(row[0]);
     mp.Orderid                                := convertI64(row[1]);
     mp.Username                               := row[2].ToString ;
     mp.Productid                              := convertI64(row[3]);
     mp.Quantity                               := convertI32(row[4]);
     mp.Unitprice                              := Convert.ToDouble (row[5]);
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method orderdetails.select_orderdetails_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
  exit DBorderdetails.select_orderdetails_with_spec_clause_where_to_reader(value);
end;

class method orderdetails.select_orderdetails_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
  exit DBorderdetails.select_orderdetails_with_spec_clause_where_to_datatable(value);
end;

class method orderdetails.select_orderdetails_with_spec_clause_where_to_list(value : System.String ):list<Iorderdetails>;
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
  var tmpDB : DataTable := DBorderdetails.select_orderdetails_with_spec_clause_where_to_datatable(value);
  var ii : Integer := 0;
  var tmpList : List<Iorderdetails> := new List<Iorderdetails>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : Iorderdetails := new orderdetails;
     mp.Orderdetailid                          := convertI64(row[0]);
     mp.Orderid                                := convertI64(row[1]);
     mp.Username                               := row[2].ToString ;
     mp.Productid                              := convertI64(row[3]);
     mp.Quantity                               := convertI32(row[4]);
     mp.Unitprice                              := Convert.ToDouble(row[5]);
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method orderdetails.insert_or_update_orderdetails( ORDERDETAILID: System.Int64   ; ORDERID: System.Int64   ; USERNAME: System.String  ; PRODUCTID: System.Int64   ; QUANTITY: System.Int32   ; UNITPRICE: System.Double  ):System.Int32;
begin
  exit DBorderdetails.insert_or_update_orderdetails( ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE);
end;

method orderdetails.Set_Orderdetailid( Value: System.Int64);
begin
  _Orderdetailid := Value;
end;

method orderdetails.Get_Orderdetailid: System.Int64;
begin
  exit _Orderdetailid;
end;

method orderdetails.Set_Orderid( Value: System.Int64);
begin
  _Orderid := Value;
end;

method orderdetails.Get_Orderid: System.Int64;
begin
  exit _Orderid;
end;

method orderdetails.Set_Username( Value: System.String);
begin
  _Username := Value;
end;

method orderdetails.Get_Username: System.String;
begin
  exit _Username;
end;

method orderdetails.Set_Productid( Value: System.Int64);
begin
  _Productid := Value;
end;

method orderdetails.Get_Productid: System.Int64;
begin
  exit _Productid;
end;

method orderdetails.Set_Quantity( Value: System.Int32);
begin
  _Quantity := Value;
end;

method orderdetails.Get_Quantity: System.Int32;
begin
  exit _Quantity;
end;

method orderdetails.Set_Unitprice( Value: System.Double);
begin
  _Unitprice := Value;
end;

method orderdetails.Get_Unitprice: System.Double;
begin
  exit _Unitprice;
end;

end.
