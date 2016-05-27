namespace AspNet.Identity.Firebird3;

interface

uses
  System,
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the Role table in the FirebirdSQL Database
  /// </summary>
  RoleTable = public class
  private
    var _database: FBDatabase;
    function uuidTXTtoguid(fvalue : String) : Guid;
  public
    /// <summary>
    /// Constructor that takes a FBDatabase instance
    /// </summary>
    /// <param name="database"></param>
    constructor(database: FBDatabase);
    /// <summary>
    /// Deltes a role from the Roles table
    /// </summary>
    /// <param name="roleId">The role Id</param>
    /// <returns></returns>
    method Delete(roleId: String): Integer;
    /// <summary>
    /// Inserts a new Role in the Roles table
    /// </summary>
    /// <param name="roleName">The role's name</param>
    /// <returns></returns>
    method Insert(role: IdentityRole): Integer;
    /// <summary>
    /// Returns a role name given the roleId
    /// </summary>
    /// <param name="roleId">The role Id</param>
    /// <returns>Role name</returns>
    method GetRoleName(roleId: String): String;
    /// <summary>
    /// Returns the role Id given a role name
    /// </summary>
    /// <param name="roleName">Role's name</param>
    /// <returns>Role's Id</returns>
    method GetRoleId(roleName: String): String;
    /// <summary>
    /// Gets the IdentityRole given the role Id
    /// </summary>
    /// <param name="roleId"></param>
    /// <returns></returns>
    method GetRoleById(roleId: String): IdentityRole;
    /// <summary>
    /// Gets the IdentityRole given the role name
    /// </summary>
    /// <param name="roleName"></param>
    /// <returns></returns>
    method GetRoleByName(roleName: String): IdentityRole;
    method Update(role: IdentityRole): Integer;
  end;

implementation

uses 
  System.Data,
  FirebirdSql.Data.FirebirdClient;

constructor RoleTable(database: FBDatabase);
begin
  _database := database;
end;

method RoleTable.Delete(roleId: String): Integer;
begin
  var commandText: String := 'Delete from Roles where Id = @roleId';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@roleId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(roleId);
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text,commandText, arParams);
   exit rowsAffected;
end;

method RoleTable.Insert(role: IdentityRole): Integer;
begin
  var commandText: String := 'Insert into Roles (Id, Name) values (@ID, @name)';
  var arParams: array of FbParameter := new FbParameter[2];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(role.Id);
   arParams[1] := new FbParameter('@name',FbDbType.VarChar, 75);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := role.Name;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text,commandText, arParams);
   exit rowsAffected;
end;

method RoleTable.GetRoleName(roleId: String): String;
begin
  var commandText: String := 'Select Name from Roles where Id = @ID rows 1';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(roleId);
   var obj : Object := FBSqlHelper.ExecuteScalar(_database.connectionString,CommandType.Text, commandText,arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit String.Empty;
   exit Convert.ToString(obj);
end;

method RoleTable.GetRoleId(roleName: String): String;
begin
  var roleId: String := nil;
  var commandText: String := 'Select Id from Roles where Name = @name rows 1';
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@name',FbDbType.VarChar, 75);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Iso8859_1 ;
   arParams[0].Value := roleName;
   var obj : Object := FBSqlHelper.ExecuteScalar(_database.connectionString,CommandType.Text, commandText,arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit nil;
   exit new Guid(obj.ToString).ToString
end;

method RoleTable.GetRoleById(roleId: String): IdentityRole;
begin
  var roleName := GetRoleName(roleId);
  var role: IdentityRole := nil;
  if roleName <> nil then begin
    role := new IdentityRole(roleName, roleId);
  end;
  exit role;
end;

method RoleTable.GetRoleByName(roleName: String): IdentityRole;
begin
  var roleId:= GetRoleId(roleName);
  var role: IdentityRole := nil;
  if roleId <> nil then begin
    role := new IdentityRole(roleName, roleId);
  end;
  exit role;
end;

method RoleTable.Update(role: IdentityRole): Integer;
begin
  var commandText: String := 'Update Roles set Name = @name where Id = @ID';
  var arParams: array of FbParameter := new FbParameter[2];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(role.Id);
   arParams[1] := new FbParameter('@name',FbDbType.VarChar, 75);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := role.Name;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text,commandText, arParams);
   exit rowsAffected;
end;



function RoleTable.uuidTXTtoguid(fvalue : String) : Guid;
begin
  exit new Guid(fvalue);
end;

end.
