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
  DBproducts = public static class
  private
  class method connectionString: String;
  class method GetReadConnectionString: String;
  protected
  public
    class method select_products_Productid_to_reader(Productid: System.Int64 ):IDataReader;
    class method select_products_Productid_to_datatable(Productid: System.Int64 ):DataTable;
    class method select_products_Categoryid_to_reader(Categoryid: System.Int64 ):IDataReader;
    class method select_products_Categoryid_to_datatable(Categoryid: System.Int64 ):DataTable;
    class method select_products_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_products_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method insert_or_update_products( PRODUCTID: System.Int64   ; PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64 ; PRODUCTNAMEMINI:System.String  ):System.Int32;
    class method insert_products( PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64 ; PRODUCTNAMEMINI:System.String  ):System.Int32;
    class method delete_products( PRODUCTID: System.Int64):System.Int32;
end;

implementation

class method DBproducts.GetReadConnectionString: String;
begin
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBproducts.connectionString: String;
begin
    if ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString'] <> nil then begin
      exit ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString']
    end;
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBproducts.select_products_Productid_to_reader(Productid: System.Int64 ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI  from products where PRODUCTID= @PRODUCTID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Productid <> nil then 
   arParams[0].Value := Productid;
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString, arParams);
end;
class method DBproducts.select_products_Productid_to_datatable(Productid: System.Int64 ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI  from products where PRODUCTID= @PRODUCTID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Productid <> nil then 
   arParams[0].Value := Productid;
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString, arParams);
end;
class method DBproducts.select_products_Categoryid_to_reader(Categoryid: System.Int64 ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI  from products where CATEGORYID= @CATEGORYID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@CATEGORYID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Categoryid <> nil then 
   arParams[0].Value := Categoryid;
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString, arParams);
end;
class method DBproducts.select_products_Categoryid_to_datatable(Categoryid: System.Int64 ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI  from products where CATEGORYID= @CATEGORYID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@CATEGORYID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Categoryid <> nil then 
   arParams[0].Value := Categoryid;
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString, arParams);
end;
class method DBproducts.select_products_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI  from products where '+value);
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString);
end;
class method DBproducts.select_products_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI from products where '+value );
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString);
end;

class method DBproducts.insert_or_update_products( PRODUCTID: System.Int64   ; PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64 ; PRODUCTNAMEMINI:System.String  ):System.Int32;
Begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('UPDATE or INSERT INTO products ( PRODUCTID, PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI )');
   sqlCommand.Append('  VALUES ( @PRODUCTID, @PRODUCTNAME, @DESCRIPTION, @IMAGEPATH, @UNITPRICE, @CATEGORYID, @PRODUCTNAMEMINI )');
   sqlCommand.Append('  matching (PRODUCTID);');
   var arParams: array of FbParameter := new FbParameter[7];
   arParams[0] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if PRODUCTID <> nil then 
   arParams[0].Value := PRODUCTID;
   arParams[1] := new FbParameter('@PRODUCTNAME',FbDbType.VarChar, 100);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := PRODUCTNAME;
   arParams[2] := new FbParameter('@DESCRIPTION',FbDbType.VarChar, 8000);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Charset := FbCharset.Iso8859_1 ;
   if DESCRIPTION <> nil then 
   arParams[2].Value := DESCRIPTION;
   arParams[3] := new FbParameter('@IMAGEPATH',FbDbType.VarChar, 255);
   arParams[3].Direction := ParameterDirection.Input;
   arParams[3].Charset := FbCharset.Iso8859_1 ;
   if IMAGEPATH <> nil then 
   arParams[3].Value := IMAGEPATH;
   arParams[4] := new FbParameter('@UNITPRICE',FbDbType.Double);
   arParams[4].Direction := ParameterDirection.Input;
   if UNITPRICE <> nil then 
   arParams[4].Value := UNITPRICE;
   arParams[5] := new FbParameter('@CATEGORYID',FbDbType.BigInt);
   arParams[5].Direction := ParameterDirection.Input;
   if CATEGORYID <> nil then 
   arParams[5].Value := CATEGORYID;
   arParams[6] := new FbParameter('@PRODUCTNAMEMINI',FbDbType.VarChar, 100);
   arParams[6].Direction := ParameterDirection.Input;
   arParams[6].Charset := FbCharset.Iso8859_1 ;
   arParams[6].Value := PRODUCTNAMEMINI;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;

class method DBproducts.insert_products(  PRODUCTNAME: System.String  ; DESCRIPTION: System.String  ; IMAGEPATH: System.String  ; UNITPRICE: System.Double  ; CATEGORYID: System.Int64 ; PRODUCTNAMEMINI:System.String  ):System.Int32;
Begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('INSERT INTO products ( PRODUCTNAME, DESCRIPTION, IMAGEPATH, UNITPRICE, CATEGORYID, PRODUCTNAMEMINI )');
   sqlCommand.Append('  VALUES (  @PRODUCTNAME, @DESCRIPTION, @IMAGEPATH, @UNITPRICE, @CATEGORYID, @PRODUCTNAMEMINI )');
   var arParams: array of FbParameter := new FbParameter[6];

   arParams[0] := new FbParameter('@PRODUCTNAME',FbDbType.VarChar, 100);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Iso8859_1 ;
   if PRODUCTNAME <> nil then 
   arParams[0].Value := PRODUCTNAME;
   arParams[1] := new FbParameter('@DESCRIPTION',FbDbType.VarChar, 8000);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   if DESCRIPTION <> nil then 
   arParams[1].Value := DESCRIPTION;
   arParams[2] := new FbParameter('@IMAGEPATH',FbDbType.VarChar, 255);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Charset := FbCharset.Iso8859_1 ;
   if IMAGEPATH <> nil then 
   arParams[2].Value := IMAGEPATH;
   arParams[3] := new FbParameter('@UNITPRICE',FbDbType.Double);
   arParams[3].Direction := ParameterDirection.Input;
   if UNITPRICE <> nil then 
   arParams[3].Value := UNITPRICE;
   arParams[4] := new FbParameter('@CATEGORYID',FbDbType.BigInt);
   arParams[4].Direction := ParameterDirection.Input;
   if CATEGORYID <> nil then 
   arParams[4].Value := CATEGORYID;
   arParams[5] := new FbParameter('@PRODUCTNAMEMINI',FbDbType.VarChar, 100);
   arParams[5].Direction := ParameterDirection.Input;
   arParams[5].Charset := FbCharset.Iso8859_1 ;
   arParams[5].Value := PRODUCTNAMEMINI;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;

class method DBproducts.delete_products(PRODUCTID: System.Int64): System.Int32;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('delete from products where PRODUCTID = @PRODUCTID ;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@PRODUCTID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Value := PRODUCTID;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;
end.
