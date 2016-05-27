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
  DBorderdetails = public static class
  private
  class method connectionString: String;
  class method GetReadConnectionString: String;
  protected
  public
    class method select_orderdetails_Orderdetailid_to_reader(Orderdetailid: System.Int64 ):IDataReader;
    class method select_orderdetails_Orderdetailid_to_datatable(Orderdetailid: System.Int64 ):DataTable;
    class method select_orderdetails_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
    class method select_orderdetails_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
    class method select_orderdetails_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_orderdetails_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method insert_or_update_orderdetails( ORDERDETAILID: System.Int64   ; ORDERID: System.Int64   ; USERNAME: System.String  ; PRODUCTID: System.Int64   ; QUANTITY: System.Int32   ; UNITPRICE: System.Double  ):System.Int32;
end;

implementation

class method DBorderdetails.GetReadConnectionString: String;
begin
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBorderdetails.connectionString: String;
begin
    if ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString'] <> nil then begin
      exit ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString']
    end;
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBorderdetails.select_orderdetails_Orderdetailid_to_reader(Orderdetailid: System.Int64 ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE from orderdetails where ORDERDETAILID= @ORDERDETAILID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ORDERDETAILID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Orderdetailid <> nil then 
   arParams[0].Value := Orderdetailid;
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString, arParams);
end;
class method DBorderdetails.select_orderdetails_Orderdetailid_to_datatable(Orderdetailid: System.Int64 ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE from orderdetails where ORDERDETAILID= @ORDERDETAILID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ORDERDETAILID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Orderdetailid <> nil then 
   arParams[0].Value := Orderdetailid;
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString, arParams);
end;
class method DBorderdetails.select_orderdetails_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE from orderdetails where ORDERID= @ORDERID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ORDERID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Orderid <> nil then 
   arParams[0].Value := Orderid;
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString, arParams);
end;
class method DBorderdetails.select_orderdetails_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE from orderdetails where ORDERID= @ORDERID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ORDERID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Orderid <> nil then 
   arParams[0].Value := Orderid;
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString, arParams);
end;
class method DBorderdetails.select_orderdetails_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE from orderdetails where '+value);
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString);
end;
class method DBorderdetails.select_orderdetails_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE from orderdetails where '+value );
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString);
end;

class method DBorderdetails.insert_or_update_orderdetails( ORDERDETAILID: System.Int64   ; ORDERID: System.Int64   ; USERNAME: System.String  ; PRODUCTID: System.Int64   ; QUANTITY: System.Int32   ; UNITPRICE: System.Double  ):System.Int32;
Begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('UPDATE or INSERT INTO orderdetails ( ORDERDETAILID, ORDERID, USERNAME, PRODUCTID, QUANTITY, UNITPRICE)');
   sqlCommand.Append('  VALUES ( @ORDERDETAILID, @ORDERID, @USERNAME, @PRODUCTID, @QUANTITY, @UNITPRICE)');
   sqlCommand.Append('  matching (ORDERDETAILID);');
   var arParams: array of FbParameter := new FbParameter[6];
   arParams[0] := new FbParameter('@ORDERDETAILID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if ORDERDETAILID <> nil then 
   arParams[0].Value := ORDERDETAILID;
   arParams[1] := new FbParameter('@ORDERID',FbDbType.BigInt);
   arParams[1].Direction := ParameterDirection.Input;
   if ORDERID <> nil then 
   arParams[1].Value := ORDERID;
   arParams[2] := new FbParameter('@USERNAME',FbDbType.VarChar, 100);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Charset := FbCharset.Iso8859_1 ;
   if USERNAME <> nil then 
   arParams[2].Value := USERNAME;
   arParams[3] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[3].Direction := ParameterDirection.Input;
   if PRODUCTID <> nil then 
   arParams[3].Value := PRODUCTID;
   arParams[4] := new FbParameter('@QUANTITY',FbDbType.Integer);
   arParams[4].Direction := ParameterDirection.Input;
   if QUANTITY <> nil then 
   arParams[4].Value := QUANTITY;
   arParams[5] := new FbParameter('@UNITPRICE',FbDbType.Double);
   arParams[5].Direction := ParameterDirection.Input;
   if UNITPRICE <> nil then 
   arParams[5].Value := UNITPRICE;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;
end.
