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
  DBorders = public static class
  private
  class method connectionString: String;
  class method GetReadConnectionString: String;
  protected
  public
    class method select_orders_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
    class method select_orders_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
    class method select_orders_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_orders_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method insert_or_update_orders( ORDERID: System.Int64   ; ORDERDATE: System.DateTime; USERNAME: System.String  ; FIRSTNAME: System.String  ; LASTNAME: System.String  ; ADDRESS: System.String  ; CITY: System.String  ; STATE: System.String  ; POSTALCODE: System.String  ; COUNTRY: System.String  ; PHONE: System.String  ; EMAIL: System.String  ; TOTAL: System.Decimal ; PAYMENTTRANSACTIONID: System.String  ; HASBEENSHIPPED: System.String  ):System.Int32;
end;

implementation

class method DBorders.GetReadConnectionString: String;
begin
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBorders.connectionString: String;
begin
    if ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString'] <> nil then begin
      exit ConfigurationManager.AppSettings['FirebirdSqlWriteConnectionString']
    end;
    exit ConfigurationManager.AppSettings['FirebirdConnectionString']
end;
class method DBorders.select_orders_Orderid_to_reader(Orderid: System.Int64 ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERID, ORDERDATE, USERNAME, FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, POSTALCODE, COUNTRY, PHONE, EMAIL, TOTAL, PAYMENTTRANSACTIONID, HASBEENSHIPPED from orders where ORDERID= @ORDERID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ORDERID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Orderid <> nil then 
   arParams[0].Value := Orderid;
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString, arParams);
end;
class method DBorders.select_orders_Orderid_to_datatable(Orderid: System.Int64 ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERID, ORDERDATE, USERNAME, FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, POSTALCODE, COUNTRY, PHONE, EMAIL, TOTAL, PAYMENTTRANSACTIONID, HASBEENSHIPPED from orders where ORDERID= @ORDERID;');
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ORDERID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if Orderid <> nil then 
   arParams[0].Value := Orderid;
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString, arParams);
end;
class method DBorders.select_orders_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERID, ORDERDATE, USERNAME, FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, POSTALCODE, COUNTRY, PHONE, EMAIL, TOTAL, PAYMENTTRANSACTIONID, HASBEENSHIPPED from orders where '+value);
   exit FBSqlHelper.ExecuteReader(connectionString, sqlCommand.ToString);
end;
class method DBorders.select_orders_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('select  ORDERID, ORDERDATE, USERNAME, FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, POSTALCODE, COUNTRY, PHONE, EMAIL, TOTAL, PAYMENTTRANSACTIONID, HASBEENSHIPPED from orders where '+value );
   exit FBSqlHelper.ExecuteDataTable(connectionString, sqlCommand.ToString);
end;

class method DBorders.insert_or_update_orders( ORDERID: System.Int64   ; ORDERDATE: System.DateTime; USERNAME: System.String  ; FIRSTNAME: System.String  ; LASTNAME: System.String  ; ADDRESS: System.String  ; CITY: System.String  ; STATE: System.String  ; POSTALCODE: System.String  ; COUNTRY: System.String  ; PHONE: System.String  ; EMAIL: System.String  ; TOTAL: System.Decimal ; PAYMENTTRANSACTIONID: System.String  ; HASBEENSHIPPED: System.String  ):System.Int32;
Begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('UPDATE or INSERT INTO orders ( ORDERID, ORDERDATE, USERNAME, FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, POSTALCODE, COUNTRY, PHONE, EMAIL, TOTAL, PAYMENTTRANSACTIONID, HASBEENSHIPPED)');
   sqlCommand.Append('  VALUES ( @ORDERID, @ORDERDATE, @USERNAME, @FIRSTNAME, @LASTNAME, @ADDRESS, @CITY, @STATE, @POSTALCODE, @COUNTRY, @PHONE, @EMAIL, @TOTAL, @PAYMENTTRANSACTIONID, @HASBEENSHIPPED)');
   sqlCommand.Append('  matching (ORDERID);');
   var arParams: array of FbParameter := new FbParameter[15];
   arParams[0] := new FbParameter('@ORDERID',FbDbType.BigInt);
   arParams[0].Direction := ParameterDirection.Input;
   if ORDERID <> nil then 
   arParams[0].Value := ORDERID;
   arParams[1] := new FbParameter('@ORDERDATE',FbDbType.TimeStamp);
   arParams[1].Direction := ParameterDirection.Input;
   if ORDERDATE <> nil then 
   arParams[1].Value := ORDERDATE;
   arParams[2] := new FbParameter('@USERNAME',FbDbType.VarChar, 100);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Charset := FbCharset.Iso8859_1 ;
   if USERNAME <> nil then 
   arParams[2].Value := USERNAME;
   arParams[3] := new FbParameter('@FIRSTNAME',FbDbType.VarChar, 160);
   arParams[3].Direction := ParameterDirection.Input;
   arParams[3].Charset := FbCharset.Iso8859_1 ;
   if FIRSTNAME <> nil then 
   arParams[3].Value := FIRSTNAME;
   arParams[4] := new FbParameter('@LASTNAME',FbDbType.VarChar, 160);
   arParams[4].Direction := ParameterDirection.Input;
   arParams[4].Charset := FbCharset.Iso8859_1 ;
   if LASTNAME <> nil then 
   arParams[4].Value := LASTNAME;
   arParams[5] := new FbParameter('@ADDRESS',FbDbType.VarChar, 70);
   arParams[5].Direction := ParameterDirection.Input;
   arParams[5].Charset := FbCharset.Iso8859_1 ;
   if ADDRESS <> nil then 
   arParams[5].Value := ADDRESS;
   arParams[6] := new FbParameter('@CITY',FbDbType.VarChar, 40);
   arParams[6].Direction := ParameterDirection.Input;
   arParams[6].Charset := FbCharset.Iso8859_1 ;
   if CITY <> nil then 
   arParams[6].Value := CITY;
   arParams[7] := new FbParameter('@STATE',FbDbType.VarChar, 40);
   arParams[7].Direction := ParameterDirection.Input;
   arParams[7].Charset := FbCharset.Iso8859_1 ;
   if STATE <> nil then 
   arParams[7].Value := STATE;
   arParams[8] := new FbParameter('@POSTALCODE',FbDbType.VarChar, 10);
   arParams[8].Direction := ParameterDirection.Input;
   arParams[8].Charset := FbCharset.Iso8859_1 ;
   if POSTALCODE <> nil then 
   arParams[8].Value := POSTALCODE;
   arParams[9] := new FbParameter('@COUNTRY',FbDbType.VarChar, 40);
   arParams[9].Direction := ParameterDirection.Input;
   arParams[9].Charset := FbCharset.Iso8859_1 ;
   if COUNTRY <> nil then 
   arParams[9].Value := COUNTRY;
   arParams[10] := new FbParameter('@PHONE',FbDbType.VarChar, 24);
   arParams[10].Direction := ParameterDirection.Input;
   arParams[10].Charset := FbCharset.Iso8859_1 ;
   if PHONE <> nil then 
   arParams[10].Value := PHONE;
   arParams[11] := new FbParameter('@EMAIL',FbDbType.VarChar, 75);
   arParams[11].Direction := ParameterDirection.Input;
   arParams[11].Charset := FbCharset.Iso8859_1 ;
   if EMAIL <> nil then 
   arParams[11].Value := EMAIL;
   arParams[12] := new FbParameter('@TOTAL',FbDbType.Decimal);
   arParams[12].Direction := ParameterDirection.Input;
   if TOTAL <> nil then 
   arParams[12].Value := TOTAL;
   arParams[13] := new FbParameter('@PAYMENTTRANSACTIONID',FbDbType.VarChar, 255);
   arParams[13].Direction := ParameterDirection.Input;
   arParams[13].Charset := FbCharset.Iso8859_1 ;
   if PAYMENTTRANSACTIONID <> nil then 
   arParams[13].Value := PAYMENTTRANSACTIONID;
   arParams[14] := new FbParameter('@HASBEENSHIPPED',Char(1));
   arParams[14].Direction := ParameterDirection.Input;
   arParams[14].Charset := FbCharset.Iso8859_1 ;
   if HASBEENSHIPPED <> nil then 
   arParams[14].Value := HASBEENSHIPPED;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(connectionString, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;
end.
