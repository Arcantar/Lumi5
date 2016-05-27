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
  categories = public class(Icategories)
  private
    var _Categoryid                      : System.Int64    := 0;
    var _Categoryname                    : System.String   := System.String.Empty;
    var _Description                     : System.String   := System.String.Empty;
    var _imagepath                       : System.String   := System.String.Empty;
    method Set_Categoryid( Value  :  System.Int64 );
    method Get_Categoryid :  System.Int64 ;
    method Set_Categoryname( Value  :  System.String );
    method Get_Categoryname :  System.String ;
    method Set_Description( Value  :  System.String );
    method Get_Description :  System.String ;    
    method Set_ImagePath( Value  :  System.String );
    method Get_ImagePath :  System.String ;
  protected
  public
    constructor;
  const
    C_Categoryid                            : Int16   =   0;
    C_Categoryname                          : Int16   =   1;
    C_Description                           : Int16   =   2;
    C_ImagePath                             : Int16   =   3;
    Property Categoryid                      : System.Int64    read Get_Categoryid                     write Set_Categoryid                    ;
    Property Categoryname                    : System.String   read Get_Categoryname                   write Set_Categoryname                  ;
    Property Description                     : System.String   read Get_Description                    write Set_Description                   ;
    Property ImagePath                       : System.String   read Get_ImagePath                      write Set_ImagePath                     ;
    class method select_categories_Categoryid_to_reader(Categoryid: System.Int64 ):IDataReader;
    class method select_categories_Categoryid_to_datatable(Categoryid: System.Int64 ):DataTable;
    class method select_categories_Categoryid_to_list(Categoryid: System.Int64 ):list<Icategories>;
    class method select_categories_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
    class method select_categories_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
    class method select_categories_with_spec_clause_where_to_list(value : System.String ):list<categories>;
    class method insert_or_update_categories( CATEGORYID: System.Int64   ; CATEGORYNAME: System.String  ; DESCRIPTION: System.String; IMAGEPATH : String  ):System.Int32;
  end;

implementation

constructor categories;
begin
//yeps
end;

class method categories.select_categories_Categoryid_to_reader(Categoryid: System.Int64 ):IDataReader;
begin
  exit DBcategories.select_categories_Categoryid_to_reader(Categoryid );
end;

class method categories.select_categories_Categoryid_to_datatable(Categoryid: System.Int64 ):DataTable;
begin
  exit DBcategories.select_categories_Categoryid_to_datatable(Categoryid );
end;

class method categories.select_categories_Categoryid_to_list(Categoryid: System.Int64 ):list<Icategories>;
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
  var tmpDB : DataTable := DBcategories.select_categories_Categoryid_to_datatable(Categoryid );
  var ii : Integer := 0;
  var tmpList : List<Icategories> := new List<Icategories>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : Icategories := new categories;
     mp.Categoryid                             := convertI64(row[0]);
     mp.Categoryname                           := row[1].ToString ;
     mp.Description                            := row[2].ToString ;
     mp.ImagePath                              := row[3].ToString ;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method categories.select_categories_with_spec_clause_where_to_reader(value : System.String ):IDataReader;
begin
  exit DBcategories.select_categories_with_spec_clause_where_to_reader(value);
end;

class method categories.select_categories_with_spec_clause_where_to_datatable(value : System.String ):DataTable;
begin
  exit DBcategories.select_categories_with_spec_clause_where_to_datatable(value);
end;

class method categories.select_categories_with_spec_clause_where_to_list(value : System.String ):list<categories>;
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
  var tmpDB : DataTable := DBcategories.select_categories_with_spec_clause_where_to_datatable(value);
  var ii : Integer := 0;
  var tmpList : List<categories> := new List<categories>;
  for each row:DataRow in tmpDB.Rows do begin
    var mp : categories := new categories;
     mp.Categoryid                             := convertI64(row[0]);
     mp.Categoryname                           := row[1].ToString ;
     mp.Description                            := row[2].ToString ;
     mp.ImagePath                              := row[3].ToString ;
    tmpList.Add(mp);
  end;
  exit tmpList;
end;

class method categories.insert_or_update_categories( CATEGORYID: System.Int64   ; CATEGORYNAME: System.String  ; DESCRIPTION: System.String; IMAGEPATH : String  ):System.Int32;
begin
  exit DBcategories.insert_or_update_categories( CATEGORYID, CATEGORYNAME, DESCRIPTION, IMAGEPATH);
end;

method categories.Set_Categoryid( Value: System.Int64);
begin
  _Categoryid := Value;
end;

method categories.Get_Categoryid: System.Int64;
begin
  exit _Categoryid;
end;

method categories.Set_Categoryname( Value: System.String);
begin
  _Categoryname := Value;
end;

method categories.Get_Categoryname: System.String;
begin
  exit _Categoryname;
end;

method categories.Set_Description( Value: System.String);
begin
  _Description := Value;
end;

method categories.Get_Description: System.String;
begin
  exit _Description;
end;

method categories.Set_ImagePath( Value: System.String);
begin
  _imagepath := Value;
end;

method categories.Get_ImagePath: System.String;
begin
  exit _imagepath;
end;

end.
