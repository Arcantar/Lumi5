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
  products = public class(Iproducts)
  private
    var _Productid                       : System.Int64    := 0;
    var _Productname                     : System.String   := System.String.Empty;
    var _Description                     : System.String   := System.String.Empty;
    var _Imagepath                       : System.String   := System.String.Empty;
    var _Unitprice                       : System.Double   := 0; 
    var _Categoryid                      : System.Int64    := 0;
    var _ProductnameMini                 : System.String   := System.String.Empty;
    method Set_Productid( Value  :  System.Int64 );
    method Get_Productid :  System.Int64 ;
    method Set_Productname( Value  :  System.String );
    method Get_Productname :  System.String ;
    method Set_Description( Value  :  System.String );
    method Get_Description :  System.String ;
    method Set_Imagepath( Value  :  System.String );
    method Get_Imagepath :  System.String ;
    method Set_Unitprice( Value  :  System.Double );
    method Get_Unitprice :  System.Double ;
    method Set_Categoryid( Value  :  System.Int64 );
    method Get_Categoryid :  System.Int64 ;
    method Set_ProductnameMini( Value  :  System.String );
    method Get_ProductnameMini :  System.String ;
  protected
  public
    constructor;
  const
    C_Productid                             : Int16   =   0;
    C_Productname                           : Int16   =   1;
    C_Description                           : Int16   =   2;
    C_Imagepath                             : Int16   =   3;
    C_Unitprice                             : Int16   =   4;
    C_Categoryid                            : Int16   =   5;
    C_ProductnameMini                       : Int16   =   5;
    Property Productid                       : System.Int64    read Get_Productid                      write Set_Productid                     ;
    Property Productname                     : System.String   read Get_Productname                    write Set_Productname                   ;
    Property Description                     : System.String   read Get_Description                    write Set_Description                   ;
    Property Imagepath                       : System.String   read Get_Imagepath                      write Set_Imagepath                     ;
    Property Unitprice                       : System.Double   read Get_Unitprice                      write Set_Unitprice                     ;
    Property Categoryid                      : System.Int64    read Get_Categoryid                     write Set_Categoryid                    ;
    Property ProductnameMini                 : System.String   read Get_ProductnameMini                write Set_ProductnameMini               ;
    class method select_products_Productid_to_reader(Productid: System.Int64 ):IDataReader;
    class method select_products_Productid_to_datatable(Productid: System.Int64 ):DataTable;
    class method select_products_Productid_to_list(Productid: System.Int64 ):list<products>;
    class method select_products_Categoryid_to_reader(Categoryid: System.Int64 ):IDataReader;
    class method select_products_Categoryid_to_datatable(Categoryid: System.Int64 ):DataTable;
    class method select_products_Categoryid_to_list(Categoryid: System.Int64 ):list<products>;
    class method select_products_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_products_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method select_products_with_spec_clause_where_to_list(value : System.String ):list<products>;
    class method insert_or_update_products( PRODUCTID: System.Int64   ; PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64 ; PRODUCTNAMEMINI: System.String   ):System.Int32;
    class method insert_products( PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64  ; PRODUCTNAMEMINI: System.String  ):System.Int32;
    class method delete_products(PRODUCTID: System.Int64):System.Int32;
    
  end;

implementation

constructor products;
begin
//yeps
end;

class method products.select_products_Productid_to_reader(Productid: System.Int64 ):IDataReader;
begin
  exit DBproducts.select_products_Productid_to_reader(Productid );
end;

class method products.select_products_Productid_to_datatable(Productid: System.Int64 ):DataTable;
begin
  exit DBproducts.select_products_Productid_to_datatable(Productid );
end;

class method products.select_products_Productid_to_list(Productid: System.Int64 ):list<products>;
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
  var tmpDB : DataTable := DBproducts.select_products_Productid_to_datatable(Productid );
  var ii : Integer := 0;
  var tmpList : List<products> := new List<products>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : products := new products;
     mp.Productid                              := convertI64(row[0]);
     mp.Productname                            := row[1].ToString ;
     mp.Description                            := row[2].ToString ;
     mp.Imagepath                              := row[3].ToString ;
     mp.Unitprice                              := Convert.ToDouble(row[4]);
     mp.Categoryid                             := convertI32(row[5]);
     mp.ProductnameMini                        := row[6].ToString ;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method products.select_products_Categoryid_to_reader(Categoryid: System.Int64 ):IDataReader;
begin
  exit DBproducts.select_products_Categoryid_to_reader(Categoryid );
end;

class method products.select_products_Categoryid_to_datatable(Categoryid: System.Int64 ):DataTable;
begin
  exit DBproducts.select_products_Categoryid_to_datatable(Categoryid );
end;

class method products.select_products_Categoryid_to_list(Categoryid: System.Int64 ):list<products>;
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
  var tmpDB : DataTable := DBproducts.select_products_Categoryid_to_datatable(Categoryid );
  var ii : Integer := 0;
  var tmpList : List<products> := new List<products>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : products := new products;
     mp.Productid                              := convertI64(row[0]);
     mp.Productname                            := row[1].ToString ;
     mp.Description                            := row[2].ToString ;
     mp.Imagepath                              := row[3].ToString ;
     mp.Unitprice                              := Convert.ToDouble(row[4]);
     mp.Categoryid                             := convertI32(row[5]);
     mp.ProductnameMini                        := row[6].ToString ;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method products.select_products_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
  exit DBproducts.select_products_with_spec_clause_where_to_reader(value);
end;

class method products.select_products_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
  exit DBproducts.select_products_with_spec_clause_where_to_datatable(value);
end;

class method products.select_products_with_spec_clause_where_to_list(value : System.String ):list<products>;
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
  var tmpDB : DataTable := DBproducts.select_products_with_spec_clause_where_to_datatable(value);
  var ii : Integer := 0;
  var tmpList : List<products> := new List<products>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : products := new products;
     mp.Productid                              := convertI64(row[0]);
     mp.Productname                            := row[1].ToString ;
     mp.Description                            := row[2].ToString ;
     mp.Imagepath                              := row[3].ToString ;
     mp.Unitprice                              := Convert.ToDouble(row[4]);
     mp.Categoryid                             := convertI32(row[5]);
     mp.ProductnameMini                        := row[6].ToString ;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method products.insert_or_update_products( PRODUCTID: System.Int64   ; PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64 ; PRODUCTNAMEMINI: System.String  ):System.Int32;
begin
  exit DBproducts.insert_or_update_products( PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI);
end;

class method products.insert_products(  PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64 ; PRODUCTNAMEMINI: System.String  ):System.Int32;
begin
  exit DBproducts.insert_products( PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI);
end;

class method products.delete_products(PRODUCTID: System.Int64): System.Int32;
begin
  exit DBproducts.delete_products(PRODUCTID);
end;

method products.Set_Productid( Value: System.Int64);
begin
  _Productid := Value;
end;

method products.Get_Productid: System.Int64;
begin
  exit _Productid;
end;

method products.Set_Productname( Value: System.String);
begin
  _Productname := Value;
end;

method products.Get_Productname: System.String;
begin
  exit _Productname;
end;

method products.Set_Description( Value: System.String);
begin
  _Description := Value;
end;

method products.Get_Description: System.String;
begin
  exit _Description;
end;

method products.Set_Imagepath( Value: System.String);
begin
  _Imagepath := Value;
end;

method products.Get_Imagepath: System.String;
begin
  exit _Imagepath;
end;

method products.Set_Unitprice( Value: System.Double);
begin
  _Unitprice := Value;
end;

method products.Get_Unitprice: System.Double;
begin
  exit _Unitprice;
end;

method products.Set_Categoryid( Value: System.Int64);
begin
  _Categoryid := Value;
end;

method products.Get_Categoryid: System.Int64;
begin
  exit _Categoryid;
end;

method products.Set_ProductnameMini( Value: System.String);
begin
  _ProductnameMini := Value;
end;

method products.Get_ProductnameMini: System.String;
begin
  exit _ProductnameMini;
end;

end.
