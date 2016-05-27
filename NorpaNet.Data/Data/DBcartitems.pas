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
  DBcartitems = public static class
  private
  class method connectionString: String;
  class method GetReadConnectionString: String;
  protected
  public
    class method select_cartitems_Itemid_to_reader(Itemid: System.Guid ):IDataReader;
    class method select_cartitems_Itemid_to_datatable(Itemid: System.Guid ):DataTable;
    class method select_cartitems_Productid_to_reader(Productid: System.Int64 ):IDataReader;
    class method select_cartitems_Productid_to_datatable(Productid: System.Int64 ):DataTable;
    class method select_cartitems_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_cartitems_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method insert_or_update_cartitems( ITEMID: System.Guid    ; CARTID: System.Guid    ; QUANTITY: System.Int32   ; DATECREATED: System.DateTime; PRODUCTID: System.Int64   ):System.Int32;
    class method delete_productID_from_cart(CartId : System.Guid; ProductID : System.Int64):Int32;
    class method update_cartitem(updateCartID: System.Guid; updateProductID: Integer; quantity: Integer):Int32;
    class method delete_cart(CartId : System.Guid):Int32;
    class method count_cart(CartId : System.Guid):Int32;
    class method Select_cart(CartId : System.Guid):DataTable;
    class method MigrateCart(CartId : System.Guid; newCartId : System.Guid):Int32;
    class method SumCart(CartId : System.Guid):Double;
end;

implementation

class method DBcartitems.GetReadConnectionString: String;
begin
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBcartitems.connectionString: String;
begin
    if ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString'] <> nil then begin
      exit ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString']
    end;
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBcartitems.select_cartitems_Itemid_to_reader(Itemid: System.Guid ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID from cartitems where ITEMID= @ITEMID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ITEMID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   if Itemid <> nil then 
   arParams[0].Value := Itemid;
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString, arParams);
end;
class method DBcartitems.select_cartitems_Itemid_to_datatable(Itemid: System.Guid ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID from cartitems where ITEMID= @ITEMID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ITEMID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   if Itemid <> nil then 
   arParams[0].Value := Itemid;
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString, arParams);
end;
class method DBcartitems.select_cartitems_Productid_to_reader(Productid: System.Int64 ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID from cartitems where PRODUCTID= @PRODUCTID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Productid <> nil then 
   arParams[0].Value := Productid;
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString, arParams);
end;
class method DBcartitems.select_cartitems_Productid_to_datatable(Productid: System.Int64 ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID from cartitems where PRODUCTID= @PRODUCTID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Productid <> nil then 
   arParams[0].Value := Productid;
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString, arParams);
end;
class method DBcartitems.select_cartitems_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID from cartitems where '+value);
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString);
end;
class method DBcartitems.select_cartitems_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID from cartitems where '+value );
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString);
end;

class method DBcartitems.insert_or_update_cartitems( ITEMID: System.Guid    ; CARTID: System.Guid    ; QUANTITY: System.Int32   ; DATECREATED: System.DateTime; PRODUCTID: System.Int64   ):System.Int32;
Begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('UPDATE or INSERT INTO cartitems ( ITEMID, CARTID, QUANTITY, DATECREATED, PRODUCTID)');
   sqlCommand.Append('  VALUES ( @ITEMID, @CARTID, @QUANTITY, @DATECREATED, @PRODUCTID)');
   sqlCommand.Append('  matching (ITEMID);');
   var arParams: array of FbParameter := new FbParameter[5];
   arParams[0] := new FbParameter('@ITEMID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   if ITEMID <> nil then 
   arParams[0].Value := ITEMID;
   arParams[1] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Octets ;
   if CARTID <> nil then 
   arParams[1].Value := CARTID;
   arParams[2] := new FbParameter('@QUANTITY',FbDbType.Integer);
   arParams[2].Direction := ParameterDirection.Input;
   if QUANTITY <> nil then 
   arParams[2].Value := QUANTITY;
   arParams[3] := new FbParameter('@DATECREATED',FbDbType.TimeStamp);
   arParams[3].Direction := ParameterDirection.Input;
   if DATECREATED <> nil then 
   arParams[3].Value := DATECREATED;
   arParams[4] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[4].Direction := ParameterDirection.Input;
   if PRODUCTID <> nil then 
   arParams[4].Value := PRODUCTID;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;

class method DBcartitems.delete_productID_from_cart(CartId : System.Guid; ProductID : System.Int64):Int32;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('delete from cartitems where CARTID= @CARTID and PRODUCTID = @PRODUCTID;');
   var arParams: array of FbParameter := new FbParameter[2];
   arParams[0] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := CartId;  
   arParams[1] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Value := ProductID;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;

class method DBcartitems.update_cartitem(updateCartID: System.Guid; updateProductID: Integer; quantity: Integer):Int32;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append(' select row_affected from PS_UPDATE_CARTITEMS(@CARTID, @QUANTITY, @PRODUCTID)');
   var arParams: array of FbParameter := new FbParameter[3];
   arParams[0] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := updateCartID;
   arParams[1] := new FbParameter('@QUANTITY',FbDbType.Integer);
   arParams[1].Direction := ParameterDirection.Input; 
   arParams[1].Value := quantity;
   arParams[2] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Value := updateProductID;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteScalar(connectionString, sqlCommand.ToString(), arParams) as Int32;
   exit rowsAffected;
end;

class method DBcartitems.delete_cart(CartId : System.Guid):Int32;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('delete from cartitems where CARTID= @CARTID');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := CartId;  
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;

class method DBcartitems.count_cart(CartId : System.Guid):Int32;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select count(1) from cartitems where CARTID= @CARTID');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := CartId;  
   var obj := FBSqlHelper.ExecuteScalar(connectionString, sqlCommand.ToString(), arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit 0;
   exit Convert.ToInt32(obj);
end;

class method DBcartitems.Select_cart(CartId : System.Guid):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select * from cartitems where CARTID= @CARTID');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := CartId;  
   exit  FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString(), arParams);
end;

class method DBcartitems.MigrateCart(CartId : System.Guid; newCartId : System.Guid):Int32;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('update cartitems set CARTID= @newCARTID where CARTID= @CARTID ;');
   var arParams: array of FbParameter := new FbParameter[2];
   arParams[0] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := CartId;  
   arParams[1] := new FbParameter('@newCARTID',FbDbType.Guid);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Octets ;
   arParams[1].Value := newCartId;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;


class method DBcartitems.SumCart(CartId : System.Guid):Double;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select sum(a.quantity * b.unitprice) from cartitems a join products b on b.productid = a.productid where a.cartid = @CARTID ;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@CARTID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := CartId;
   var obj := FBSqlHelper.ExecuteScalar(connectionString, sqlCommand.ToString(), arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit 0;
   exit Convert.ToDouble(obj);
end;
end.
