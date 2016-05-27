namespace AspNet.Identity.Firebird3;

interface

uses
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the UserRoles table in the FirebirdSQL Database
  /// </summary>
  UserRolesTable = public class
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
    /// Returns a list of user's roles
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method FindByUserId(userId: String): List<String>;
    /// <summary>
    /// Deletes all roles from a user in the UserRoles table
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
    /// <summary>
    /// Inserts a new role for a user in the UserRoles table
    /// </summary>
    /// <param name="user">The User</param>
    /// <param name="roleId">The Role's id</param>
    /// <returns></returns>
    method Insert(user: IdentityUser; roleId: String): Integer;
  end;

implementation

uses 
  System.Data, 
  System.Text,
  FirebirdSql.Data.FirebirdClient;

constructor UserRolesTable(database: FBDatabase);
begin
  _database := database;
end;

method UserRolesTable.FindByUserId(userId: String): List<String>;
begin
  var roles: List<String> := new List<String>();
  var commandText: String := 'Select Roles.Name from UserRoles, Roles where UserRoles.UserId = @userId and UserRoles.RoleId = Roles.Id';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@userId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
  var row : IDataReader := FBSqlHelper.ExecuteReader(_database.connectionString, commandText, arParams);
  while row.Read do begin
    roles.Add(row['Name'].ToString);
  end;
  exit roles;
end;

method UserRolesTable.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from UserRoles where UserId = @userId';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@userId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text,commandText, arParams);
   exit rowsAffected;
end;

method UserRolesTable.Insert(user: IdentityUser; roleId: String): Integer;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('INSERT INTO userroles ( USERID, ROLEID)');
   sqlCommand.Append('  VALUES ( @USERID, @ROLEID);');
   var arParams: array of FbParameter := new FbParameter[2];
   arParams[0] := new FbParameter('@USERID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(user.Id);
   arParams[1] := new FbParameter('@ROLEID',FbDbType.Guid);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Octets ;
   arParams[1].Value := uuidTXTtoguid(roleId);
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;

function UserRolesTable.uuidTXTtoguid(fvalue : String) : Guid;
begin
  exit new Guid(fvalue);
end;

end.
