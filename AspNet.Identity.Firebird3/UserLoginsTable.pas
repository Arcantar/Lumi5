namespace AspNet.Identity.Firebird3;

interface

uses
  Microsoft.AspNet.Identity,
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the UserLogins table in the FirebirdSQL Database
  /// </summary>
  UserLoginsTable = public class
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
    /// Deletes a login from a user in the UserLogins table
    /// </summary>
    /// <param name="user">User to have login deleted</param>
    /// <param name="login">Login to be deleted from user</param>
    /// <returns></returns>
    method Delete(user: IdentityUser; login: UserLoginInfo): Integer;
    /// <summary>
    /// Deletes all Logins from a user in the UserLogins table
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
    /// <summary>
    /// Inserts a new login in the UserLogins table
    /// </summary>
    /// <param name="user">User to have new login added</param>
    /// <param name="login">Login to be added</param>
    /// <returns></returns>
    method Insert(user: IdentityUser; login: UserLoginInfo): Integer;
    /// <summary>
    /// Return a userId given a user's login
    /// </summary>
    /// <param name="userLogin">The user's login info</param>
    /// <returns></returns>
    method FindUserIdByLogin(userLogin: UserLoginInfo): String;
    /// <summary>
    /// Returns a list of user's logins
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method FindByUserId(userId: String): List<UserLoginInfo>;
  end;

implementation
uses 
  System.Data, 
  System.Text, 
  FirebirdSql.Data.FirebirdClient;

constructor UserLoginsTable(database: FBDatabase);
begin
  _database := database;
end;

method UserLoginsTable.Delete(user: IdentityUser; login: UserLoginInfo): Integer;
begin
  var commandText: String := 'Delete from UserLogins where UserId = @userId and LoginProvider = @loginProvider and ProviderKey = @providerKey';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('UserId', user.Id);
  parameters.Add('loginProvider', login.LoginProvider);
  parameters.Add('providerKey', login.ProviderKey);
  exit _database.Execute(commandText, parameters);
end;

method UserLoginsTable.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from UserLogins where UserId = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('UserId', userId);
  exit _database.Execute(commandText, parameters);
end;

method UserLoginsTable.Insert(user: IdentityUser; login: UserLoginInfo): Integer;
begin
  var commandText: String := 'Insert into UserLogins (LoginProvider, ProviderKey, UserId) values (@loginProvider, @providerKey, @userId)';
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('INSERT INTO userlogins ( LOGINPROVIDER, PROVIDERKEY, USERID)');
   sqlCommand.Append('  VALUES ( @LOGINPROVIDER, @PROVIDERKEY, @USERID);');
   var arParams: array of FbParameter := new FbParameter[3];
   arParams[0] := new FbParameter('@LOGINPROVIDER',FbDbType.VarChar, 128);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Iso8859_1 ; 
   arParams[0].Value := login.LoginProvider;
   arParams[1] := new FbParameter('@PROVIDERKEY',FbDbType.VarChar, 128);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := login.ProviderKey;
   arParams[2] := new FbParameter('@USERID',FbDbType.Guid);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Charset := FbCharset.Octets ;
   arParams[2].Value := user.Id;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text,commandText, arParams);
   exit rowsAffected;
end;

method UserLoginsTable.FindUserIdByLogin(userLogin: UserLoginInfo): String;
begin
  var commandText: String := 'Select UserId from UserLogins where LoginProvider = @loginProvider and ProviderKey = @providerKey';
  var arParams: array of FbParameter := new FbParameter[2];
   arParams[0] := new FbParameter('@loginProvider',FbDbType.VarChar, 128);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Iso8859_1 ;
   arParams[0].Value := userLogin.LoginProvider;
   arParams[1] := new FbParameter('@providerKey',FbDbType.VarChar, 128);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := userLogin.ProviderKey;
   var obj : Object := FBSqlHelper.ExecuteScalar(_database.connectionString,CommandType.Text, commandText,arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit nil;
   exit new Guid(obj.ToString).ToString;
end;

method UserLoginsTable.FindByUserId(userId: String): List<UserLoginInfo>;
begin
  var logins: List<UserLoginInfo> := new List<UserLoginInfo>();
  var commandText: String := 'Select * from UserLogins where UserId = @userId';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@userId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
  var row : IDataReader := FBSqlHelper.ExecuteReader(_database.connectionString, commandText, arParams);
    while row.Read do begin
    var login := new UserLoginInfo(row['LoginProvider'].ToString, row['ProviderKey'].ToString);
    logins.Add(login);
  end;
  exit logins;
end;

function UserLoginsTable.uuidTXTtoguid(fvalue : String) : Guid;
begin
  exit new Guid(fvalue);
end;

end.
