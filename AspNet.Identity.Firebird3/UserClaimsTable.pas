namespace AspNet.Identity.Firebird3;

interface

uses
  System.Collections.Generic,
  System.Security.Claims;

type
  /// <summary>
  /// Class that represents the UserClaims table in the FirebirdSQL Database
  /// </summary>
  UserClaimsTable = public class
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
    /// Returns a ClaimsIdentity instance given a userId
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method FindByUserId(userId: String): ClaimsIdentity;
    /// <summary>
    /// Deletes all claims from a user given a userId
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
    /// <summary>
    /// Inserts a new claim in UserClaims table
    /// </summary>
    /// <param name="userClaim">User's claim to be added</param>
    /// <param name="userId">User's id</param>
    /// <returns></returns>
    method Insert(userClaim: Claim; userId: String): Integer;
    /// <summary>
    /// Deletes a claim from a user
    /// </summary>
    /// <param name="user">The user to have a claim deleted</param>
    /// <param name="claim">A claim to be deleted from user</param>
    /// <returns></returns>
    method Delete(user: IdentityUser; claim: Claim): Integer;
  end;

implementation

uses 
  System.Data,
  FirebirdSql.Data.FirebirdClient;

constructor UserClaimsTable(database: FBDatabase);
begin
  _database := database;
end;

method UserClaimsTable.FindByUserId(userId: String): ClaimsIdentity;
begin
  var claims: ClaimsIdentity := new ClaimsIdentity();
  var commandText: String := 'Select * from UserClaims where UserId = @userId';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@userId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
  var row : IDataReader := FBSqlHelper.ExecuteReader(_database.connectionString, commandText, arParams);
  while row.Read do begin
    var claim: Claim := new Claim(row['ClaimType'].ToString, row['ClaimValue'].ToString);
    claims.AddClaim(claim);
  end;
  exit claims;
end;

method UserClaimsTable.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from UserClaims where UserId = @userId';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@userId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text,commandText, arParams);
   exit rowsAffected;
end;

method UserClaimsTable.Insert(userClaim: Claim; userId: String): Integer;
begin
  var commandText: String := 'Insert into UserClaims (ClaimValue, ClaimType, UserId) values (@value, @type, @userId)';
  var arParams: array of FbParameter := new FbParameter[3];
   arParams[0] := new FbParameter('@userId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   arParams[1] := new FbParameter('@type',FbDbType.VarChar, 254);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := userClaim.Type;
   arParams[2] := new FbParameter('@value',FbDbType.VarChar, 254);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Charset := FbCharset.Iso8859_1 ;
   arParams[2].Value :=  userClaim.Value;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, commandText, arParams);
   exit rowsAffected;
end;

method UserClaimsTable.Delete(user: IdentityUser; claim: Claim): Integer;
begin
  var commandText: String := 'Delete from UserClaims where UserId = @userId and @ClaimValue = @value and ClaimType = @type';
  var arParams: array of FbParameter := new FbParameter[3];
   arParams[0] := new FbParameter('@userId',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(user.Id);
   arParams[1] := new FbParameter('@type',FbDbType.VarChar, 254);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := claim.Type;
   arParams[2] := new FbParameter('@ClaimValue',FbDbType.VarChar, 254);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Charset := FbCharset.Iso8859_1 ;
   arParams[2].Value :=  claim.Value;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, commandText, arParams);
   exit rowsAffected;
end;

function UserClaimsTable.uuidTXTtoguid(fvalue : String) : Guid;
begin
  exit new Guid(fvalue);
end;
end.
