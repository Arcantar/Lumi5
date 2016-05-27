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
  cartitem = public class(Icartitems)
  private
    var _Itemid                          : System.Guid     := System.Guid.Empty;
    var _Cartid                          : System.Guid     := System.Guid.Empty;
    var _Quantity                        : System.Int32    := 0;
    var _Datecreated                     : System.DateTime := System.DateTime.MinValue;
    var _Productid                       : System.Int64    := 0;
    var _Product                         : products ;
    method Set_Itemid( Value  :  System.Guid );
    method Get_Itemid :  System.Guid ;
    method Set_Cartid( Value  :  System.Guid );
    method Get_Cartid :  System.Guid ;
    method Set_Quantity( Value  :  System.Int32 );
    method Get_Quantity :  System.Int32 ;
    method Set_Datecreated( Value  :  System.DateTime );
    method Get_Datecreated :  System.DateTime ;
    method Set_Productid( Value  :  System.Int64 );
    method Get_Productid :  System.Int64 ;
  protected
  public
    constructor;
  const
    C_Itemid                                : Int16   =   0;
    C_Cartid                                : Int16   =   1;
    C_Quantity                              : Int16   =   2;
    C_Datecreated                           : Int16   =   3;
    C_Productid                             : Int16   =   4;
    Property Itemid                          : System.Guid     read Get_Itemid                         write Set_Itemid                        ;
    Property Cartid                          : System.Guid     read Get_Cartid                         write Set_Cartid                        ;
    Property Quantity                        : System.Int32    read Get_Quantity                       write Set_Quantity                      ;
    Property Datecreated                     : System.DateTime read Get_Datecreated                    write Set_Datecreated                   ;
    Property Productid                       : System.Int64    read Get_Productid                      write Set_Productid                     ;
    property Product                         : Iproducts       read write;                        
    class method select_cartitems_Itemid_to_reader(Itemid: System.Guid ):IDataReader;
    class method select_cartitems_Itemid_to_datatable(Itemid: System.Guid ):DataTable;
    class method select_cartitems_Itemid_to_list(Itemid: System.Guid ):list<cartitem>;
    class method select_cartitems_Productid_to_reader(Productid: System.Int64 ):IDataReader;
    class method select_cartitems_Productid_to_datatable(Productid: System.Int64 ):DataTable;
    class method select_cartitems_Productid_to_list(Productid: System.Int64 ):list<cartitem>;
    class method select_cartitems_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_cartitems_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method select_cartitems_with_spec_clause_where_to_list(value : System.String ):list<cartitem>;
    class method insert_or_update_cartitems( ITEMID: System.Guid    ; CARTID: System.Guid    ; QUANTITY: System.Int32   ; DATECREATED: System.DateTime; PRODUCTID: System.Int64   ):System.Int32;
    class method delete_productID_from_cart(CartId : System.Guid; ProductID : System.Int64):Int32;
    class method update_cartitem(updateCartID: System.Guid; updateProductID: Integer; quantity: Integer):Int32;
    class method delete_cart(CartId : System.Guid):Int32;
    class method count_cart(CartId : System.Guid):Int32;
    class method MigrateCart(CartId : System.Guid; newCartID : System.Guid):Int32;
    class method SumCart(CartId : System.Guid):Double;
  end;

implementation

constructor cartitem;
begin
//yeps
end;

class method cartitem.select_cartitems_Itemid_to_reader(Itemid: System.Guid ):IDataReader;
begin
  exit DBcartitems.select_cartitems_Itemid_to_reader(Itemid );
end;

class method cartitem.select_cartitems_Itemid_to_datatable(Itemid: System.Guid ):DataTable;
begin
  exit DBcartitems.select_cartitems_Itemid_to_datatable(Itemid );
end;

class method cartitem.select_cartitems_Itemid_to_list(Itemid: System.Guid ):list<cartitem>;
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
  var tmpDB : DataTable := DBcartitems.Select_cart(Itemid );
  var ii : Integer := 0;
  var tmpList : List<cartitem> := new List<cartitem>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : cartitem := new cartitem;
     mp.Itemid                                 := new Guid(row[0].ToString) ;
     mp.Cartid                                 := new Guid(row[1].ToString) ;
     mp.Quantity                               := convertI32(row[2]);
     mp.Datecreated                            := convertDT(row[3]);
     mp.Productid                              := convertI64(row[4]);
     mp.Product                                := products.select_products_Productid_to_list(mp.Productid).SingleOrDefault;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method cartitem.select_cartitems_Productid_to_reader(Productid: System.Int64 ):IDataReader;
begin
  exit DBcartitems.select_cartitems_Productid_to_reader(Productid );
end;

class method cartitem.select_cartitems_Productid_to_datatable(Productid: System.Int64 ):DataTable;
begin
  exit DBcartitems.select_cartitems_Productid_to_datatable(Productid );
end;

class method cartitem.select_cartitems_Productid_to_list(Productid: System.Int64 ):list<cartitem>;
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
  var tmpDB : DataTable := DBcartitems.select_cartitems_Productid_to_datatable(Productid );
  var ii : Integer := 0;
  var tmpList : List<cartitem> := new List<cartitem>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : cartitem := new cartitem;
     mp.Itemid                                 := new Guid(row[0].ToString) ;
     mp.Cartid                                 := new Guid(row[1].ToString) ;
     mp.Quantity                               := convertI32(row[2]);
     mp.Datecreated                            := convertDT(row[3]);
     mp.Productid                              := convertI64(row[4]);
     mp.Product                                := products.select_products_Productid_to_list(mp.Productid).SingleOrDefault;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method cartitem.select_cartitems_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
  exit DBcartitems.select_cartitems_with_spec_clause_where_to_reader(value);
end;

class method cartitem.select_cartitems_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
  exit DBcartitems.select_cartitems_with_spec_clause_where_to_datatable(value);
end;

class method cartitem.select_cartitems_with_spec_clause_where_to_list(value : System.String ):list<cartitem>;
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
  var tmpDB : DataTable := DBcartitems.select_cartitems_with_spec_clause_where_to_datatable(value);
  var ii : Integer := 0;
  var tmpList : List<cartitem> := new List<cartitem>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : cartitem := new cartitem;
     mp.Itemid                                 := new Guid(row[0].ToString) ;
     mp.Cartid                                 := new Guid(row[1].ToString) ;
     mp.Quantity                               := convertI32(row[2]);
     mp.Datecreated                            := convertDT(row[3]);
     mp.Productid                              := convertI64(row[4]);
     mp.Product                                := products.select_products_Productid_to_list(mp.Productid).SingleOrDefault;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method cartitem.insert_or_update_cartitems( ITEMID: System.Guid    ; CARTID: System.Guid    ; QUANTITY: System.Int32   ; DATECREATED: System.DateTime; PRODUCTID: System.Int64   ):System.Int32;
begin
  exit DBcartitems.insert_or_update_cartitems( ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID);
end;

method cartitem.Set_Itemid( Value: System.Guid);
begin
  _Itemid := Value;
end;

method cartitem.Get_Itemid: System.Guid;
begin
  exit _Itemid;
end;

method cartitem.Set_Cartid( Value: System.Guid);
begin
  _Cartid := Value;
end;

method cartitem.Get_Cartid: System.Guid;
begin
  exit _Cartid;
end;

method cartitem.Set_Quantity( Value: System.Int32);
begin
  _Quantity := Value;
end;

method cartitem.Get_Quantity: System.Int32;
begin
  exit _Quantity;
end;

method cartitem.Set_Datecreated( Value: System.DateTime);
begin
  _Datecreated := Value;
end;

method cartitem.Get_Datecreated: System.DateTime;
begin
  exit _Datecreated;
end;

method cartitem.Set_Productid( Value: System.Int64);
begin
  _Productid := Value;
end;

method cartitem.Get_Productid: System.Int64;
begin
  exit _Productid;
end;

class method cartitem.delete_productID_from_cart(CartId : System.Guid; ProductID : System.Int64):Int32;
begin
  exit DBcartitems.delete_productID_from_cart(CartId,ProductID);
end;

class method cartitem.update_cartitem(updateCartID: System.Guid; updateProductID: Integer; quantity: Integer):Int32;
begin
  exit DBcartitems.update_cartitem(updateCartID,updateProductID,quantity);
end;

class method cartitem.delete_cart(CartId : System.Guid):Int32;
begin
  exit DBcartitems.delete_cart(CartId);
end;

class method cartitem.count_cart(CartId : System.Guid):Int32;
begin
  exit DBcartitems.count_cart(CartId);
end;

class method cartitem.MigrateCart(CartId : System.Guid; newCartID : System.Guid):Int32;
begin
  exit DBcartitems.MigrateCart(CartId,newCartID);
end;

class method cartitem.SumCart(CartId : System.Guid):Double;
begin
  exit DBcartitems.SumCart(CartId);
end;

end.
