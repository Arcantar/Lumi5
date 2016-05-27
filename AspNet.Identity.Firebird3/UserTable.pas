namespace AspNet.Identity.Firebird3;

interface

uses
  System,
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the Users table in the FirebirdSQL Database
  /// </summary>
  UserTable<TUser> = public class
  where TUser  is IdentityUser;
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
    /// Returns the user's name given a user id
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    method GetUserName(userId: String): String;
    /// <summary>
    /// Returns a User ID given a user name
    /// </summary>
    /// <param name="userName">The user's name</param>
    /// <returns></returns>
    method GetUserId(userName: String): String;
    /// <summary>
    /// Returns an TUser given the user's id
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method GetUserById(userId: String): TUser;
    /// <summary>
    /// Returns a list of TUser instances given a user name
    /// </summary>
    /// <param name="userName">User's name</param>
    /// <returns></returns>
    method GetUserByName(userName: String): List<TUser>;
    method GetUserByEmail(email: String): List<TUser>;
    /// <summary>
    /// Return the user's password hash
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method GetPasswordHash(userId: String): String;
    /// <summary>
    /// Sets the user's password hash
    /// </summary>
    /// <param name="userId"></param>
    /// <param name="passwordHash"></param>
    /// <returns></returns>
    method SetPasswordHash(userId: String; passwordHash: String): Integer;
    /// <summary>
    /// Returns the user's security stamp
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    method GetSecurityStamp(userId: String): String;
    /// <summary>
    /// Inserts a new user in the Users table
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method Insert(user: TUser): Integer;
  private
    /// <summary>
    /// Deletes a user from the Users table
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
  public
    /// <summary>
    /// Deletes a user from the Users table
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method Delete(user: TUser): Integer;
    /// <summary>
    /// Updates a user in the Users table
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method Update(user: TUser): Integer;
  end;

implementation

uses 
  System.Data, 
  System.Text,
  FirebirdSql.Data.FirebirdClient;

constructor UserTable<TUser>(database: FBDatabase);
begin
  if database=nil then
    _database := new FBDatabase else
  _database := database;
end;

method UserTable<TUser>.GetUserName(userId: String): String;
begin
  var commandText: String := 'Select Name from Users where Id = @ID rows 1';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   var obj : Object := FBSqlHelper.ExecuteScalar(_database.connectionString,CommandType.Text, commandText,arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit String.Empty;
   exit Convert.ToString(obj);
end;

method UserTable<TUser>.GetUserId(userName: String): String;
begin
  var commandText: String := 'Select Id from Users where UserName = @USERNAME rows 1';
   var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@USERNAME',FbDbType.VarChar, 75);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Iso8859_1 ;
   arParams[0].Value := userName;
   var obj : Object := FBSqlHelper.ExecuteScalar(_database.connectionString,CommandType.Text, commandText,arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit nil;
   exit new Guid(obj.ToString).ToString
end;

method UserTable<TUser>.GetUserById(userId: String): TUser;
begin
  var user: TUser := nil;
  var commandText: String := 'Select * from Users where Id = @id';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
  var row : IDataReader := FBSqlHelper.ExecuteReader(_database.connectionString, commandText, arParams);
  while row.Read do begin
    user := TUser(Activator.CreateInstance(typeOf(TUser)));
    user.Id := new Guid(row['Id'].ToString).ToString;
    user.UserName := row['UserName'].ToString;
    user.PasswordHash := if String.IsNullOrEmpty(row['PasswordHash'].ToString) then nil else row['PasswordHash'].ToString;
    user.SecurityStamp := if String.IsNullOrEmpty(row['SecurityStamp'].ToString) then nil else row['SecurityStamp'].ToString;
    user.Email := if String.IsNullOrEmpty(row['Email'].ToString) then nil else row['Email'].ToString;
    user.EmailConfirmed := if row['EmailConfirmed'].ToString = '1' then true else false;
    user.PhoneNumber := if String.IsNullOrEmpty(row['PhoneNumber'].ToString) then nil else row['PhoneNumber'].ToString;
    user.PhoneNumberConfirmed := if row['PhoneNumberConfirmed'].ToString = '1' then true else false;
    user.LockoutEnabled := if row['LockoutEnabled'].ToString = '1' then true else false;
    user.TwoFactorEnabled := if row['TwoFactorEnabled'].ToString = '1' then true else false;
    user.LockoutEndDateUtc := if String.IsNullOrEmpty(row['LockoutEndDateUtc'].ToString) then DateTime.Now else DateTime.Parse(row['LockoutEndDateUtc'].ToString);
    user.AccessFailedCount := if String.IsNullOrEmpty(row['AccessFailedCount'].ToString) then 0 else Integer.Parse(row['AccessFailedCount'].ToString);
  end;
  exit user;
end;

method UserTable<TUser>.GetUserByName(userName: String): List<TUser>;
begin
  var users: List<TUser> := new List<TUser>();
  var commandText: String := 'Select * from Users where UserName collate fr_ca_ci_ai = @USERNAME';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@USERNAME',FbDbType.VarChar, 75);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Iso8859_1 ;
   arParams[0].Value := userName;
  var row : IDataReader := FBSqlHelper.ExecuteReader(_database.connectionString, commandText, arParams);
  while row.Read do begin
    var user: TUser :=  TUser(Activator.CreateInstance(typeOf(TUser)));
    user.Id := new Guid(row['Id'].ToString).ToString;
    user.UserName := row['UserName'].ToString;
    user.PasswordHash := if String.IsNullOrEmpty(row['PasswordHash'].ToString) then nil else row['PasswordHash'].ToString;
    user.SecurityStamp := if String.IsNullOrEmpty(row['SecurityStamp'].ToString) then nil else row['SecurityStamp'].ToString;
    user.Email := if String.IsNullOrEmpty(row['Email'].ToString) then nil else row['Email'].ToString;
    user.EmailConfirmed := if row['EmailConfirmed'].ToString = '1' then true else false;
    user.PhoneNumber := if String.IsNullOrEmpty(row['PhoneNumber'].ToString) then nil else row['PhoneNumber'].ToString;
    user.PhoneNumberConfirmed := if row['PhoneNumberConfirmed'].ToString = '1' then true else false;
    user.LockoutEnabled := if row['LockoutEnabled'].ToString = '1' then true else false;
    user.TwoFactorEnabled := if row['TwoFactorEnabled'].ToString = '1' then true else false;
    user.LockoutEndDateUtc := if String.IsNullOrEmpty(row['LockoutEndDateUtc'].ToString) then DateTime.Now else DateTime.Parse(row['LockoutEndDateUtc'].ToString);
    user.AccessFailedCount := if String.IsNullOrEmpty(row['AccessFailedCount'].ToString) then 0 else Integer.Parse(row['AccessFailedCount'].ToString);
    users.Add(user as TUser);
  end;
  exit users;
end;

method UserTable<TUser>.GetUserByEmail(email: String): List<TUser>;
begin
  var users: List<TUser> := new List<TUser>();
  var commandText: String := 'Select * from Users where EMAIL collate fr_ca_ci_ai = @email';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@email',FbDbType.VarChar, 75);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Iso8859_1 ;
   arParams[0].Value := email;
  var row : IDataReader := FBSqlHelper.ExecuteReader(_database.connectionString, commandText, arParams);
  while row.Read do begin
    var user: TUser :=  TUser(Activator.CreateInstance(typeOf(TUser)));
    user.Id := new Guid(row['Id'].ToString).ToString;
    user.UserName := row['UserName'].ToString;
    user.PasswordHash := if String.IsNullOrEmpty(row['PasswordHash'].ToString) then nil else row['PasswordHash'].ToString;
    user.SecurityStamp := if String.IsNullOrEmpty(row['SecurityStamp'].ToString) then nil else row['SecurityStamp'].ToString;
    user.Email := if String.IsNullOrEmpty(row['Email'].ToString) then nil else row['Email'].ToString;
    user.EmailConfirmed := if row['EmailConfirmed'].ToString = '1' then true else false;
    user.PhoneNumber := if String.IsNullOrEmpty(row['PhoneNumber'].ToString) then nil else row['PhoneNumber'].ToString;
    user.PhoneNumberConfirmed := if row['PhoneNumberConfirmed'].ToString = '1' then true else false;
    user.LockoutEnabled := if row['LockoutEnabled'].ToString = '1' then true else false;
    user.TwoFactorEnabled := if row['TwoFactorEnabled'].ToString = '1' then true else false;
    user.LockoutEndDateUtc := if String.IsNullOrEmpty(row['LockoutEndDateUtc'].ToString) then DateTime.Now else DateTime.Parse(row['LockoutEndDateUtc'].ToString);
    user.AccessFailedCount := if String.IsNullOrEmpty(row['AccessFailedCount'].ToString) then 0 else Integer.Parse(row['AccessFailedCount'].ToString);
    users.Add(user as TUser);
  end;
  exit users;
end;

method UserTable<TUser>.GetPasswordHash(userId: String): String;
begin
  var commandText: String := 'Select PasswordHash from Users where Id = @id rows 1';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   var obj : Object := FBSqlHelper.ExecuteScalar(_database.connectionString,CommandType.Text, commandText,arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit nil;
   exit Convert.ToString(obj);
end;

method UserTable<TUser>.SetPasswordHash(userId: String; passwordHash: String): Integer;
begin
  var commandText: String := 'Update Users set PasswordHash = @pwdHash where Id = @id';
  var arParams: array of FbParameter := new FbParameter[2];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   arParams[1] := new FbParameter('@pwdHash',FbDbType.VarChar, 254);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := passwordHash;
  var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text, commandText, arParams);
  exit rowsAffected;
end;

method UserTable<TUser>.GetSecurityStamp(userId: String): String;
begin
  var commandText: String := 'Select SecurityStamp from Users where Id = @ID rows 1';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   var obj : Object := FBSqlHelper.ExecuteScalar(_database.connectionString,CommandType.Text, commandText,arParams);
   if (obj = nil) or (obj = DBNull.Value) then exit nil;
   exit Convert.ToString(obj);
end;

method UserTable<TUser>.Insert(user: TUser): Integer;
begin
  var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('UPDATE or INSERT INTO users ( ID, EMAIL, EMAILCONFIRMED, PASSWORDHASH, SECURITYSTAMP, PHONENUMBER, PHONENUMBERCONFIRMED, TWOFACTORENABLED, LOCKOUTENDDATEUTC, LOCKOUTENABLED, ACCESSFAILEDCOUNT, USERNAME)');
   sqlCommand.Append('  VALUES ( @ID, @EMAIL, @EMAILCONFIRMED, @PASSWORDHASH, @SECURITYSTAMP, @PHONENUMBER, @PHONENUMBERCONFIRMED, @TWOFACTORENABLED, @LOCKOUTENDDATEUTC, @LOCKOUTENABLED, @ACCESSFAILEDCOUNT, @USERNAME)');
  sqlCommand.Append('  matching (ID);');
   var arParams: array of FbParameter := new FbParameter[12];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(user.Id);
   arParams[1] := new FbParameter('@EMAIL',FbDbType.VarChar, 254);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := user.Email;
   arParams[2] := new FbParameter('@EMAILCONFIRMED',FbDbType.SmallInt);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Value := user.EmailConfirmed;
   arParams[3] := new FbParameter('@PASSWORDHASH',FbDbType.VarChar, 254);
   arParams[3].Direction := ParameterDirection.Input;
   arParams[3].Charset := FbCharset.Iso8859_1 ;
   arParams[3].Value := user.PasswordHash;
   arParams[4] := new FbParameter('@SECURITYSTAMP',FbDbType.VarChar, 254);
   arParams[4].Direction := ParameterDirection.Input;
   arParams[4].Charset := FbCharset.Iso8859_1 ;
   arParams[4].Value := user.SecurityStamp;
   arParams[5] := new FbParameter('@PHONENUMBER',FbDbType.VarChar, 54);
   arParams[5].Direction := ParameterDirection.Input;
   arParams[5].Charset := FbCharset.Iso8859_1 ;
   arParams[5].Value := user.PhoneNumber;
   arParams[6] := new FbParameter('@PHONENUMBERCONFIRMED',FbDbType.SmallInt);
   arParams[6].Direction := ParameterDirection.Input;
   arParams[6].Value := user.PhoneNumberConfirmed;
   arParams[7] := new FbParameter('@TWOFACTORENABLED',FbDbType.SmallInt);
   arParams[7].Direction := ParameterDirection.Input;
   arParams[7].Value := user.TwoFactorEnabled;
   arParams[8] := new FbParameter('@LOCKOUTENDDATEUTC',FbDbType.TimeStamp);
   arParams[8].Direction := ParameterDirection.Input;
   arParams[8].Value := user.LockoutEndDateUtc;
   arParams[9] := new FbParameter('@LOCKOUTENABLED',FbDbType.SmallInt);
   arParams[9].Direction := ParameterDirection.Input;
   arParams[9].Value := user.LockoutEnabled;
   arParams[10] := new FbParameter('@ACCESSFAILEDCOUNT',FbDbType.SmallInt);
   arParams[10].Direction := ParameterDirection.Input;
   arParams[10].Value := user.AccessFailedCount;
   arParams[11] := new FbParameter('@USERNAME',FbDbType.VarChar, 75);
   arParams[11].Direction := ParameterDirection.Input;
   arParams[11].Charset := FbCharset.Iso8859_1 ;
   arParams[11].Value := user.UserName;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text, sqlCommand.ToString, arParams);
   exit rowsAffected;
end;

method UserTable<TUser>.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from Users where Id = @userId';
  var arParams: array of FbParameter := new FbParameter[1];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(userId);
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text,commandText, arParams);
   exit rowsAffected;
end;

method UserTable<TUser>.Delete(user: TUser): Integer;
begin
  exit Delete(user.Id);
end;

method UserTable<TUser>.Update(user: TUser): Integer;
begin
   var sqlCommand: StringBuilder := new StringBuilder;
   sqlCommand.Append('UPDATE or INSERT INTO users ( ID, EMAIL, EMAILCONFIRMED, PASSWORDHASH, SECURITYSTAMP, PHONENUMBER, PHONENUMBERCONFIRMED, TWOFACTORENABLED, LOCKOUTENDDATEUTC, LOCKOUTENABLED, ACCESSFAILEDCOUNT, USERNAME)');
   sqlCommand.Append('  VALUES ( @ID, @EMAIL, @EMAILCONFIRMED, @PASSWORDHASH, @SECURITYSTAMP, @PHONENUMBER, @PHONENUMBERCONFIRMED, @TWOFACTORENABLED, @LOCKOUTENDDATEUTC, @LOCKOUTENABLED, @ACCESSFAILEDCOUNT, @USERNAME)');
   sqlCommand.Append('  matching (ID);');
   var arParams: array of FbParameter := new FbParameter[12];
   arParams[0] := new FbParameter('@ID',FbDbType.Guid);
   arParams[0].Direction := ParameterDirection.Input;
   arParams[0].Charset := FbCharset.Octets ;
   arParams[0].Value := uuidTXTtoguid(user.Id);
   arParams[1] := new FbParameter('@EMAIL',FbDbType.VarChar, 254);
   arParams[1].Direction := ParameterDirection.Input;
   arParams[1].Charset := FbCharset.Iso8859_1 ;
   arParams[1].Value := user.Email;
   arParams[2] := new FbParameter('@EMAILCONFIRMED',FbDbType.SmallInt);
   arParams[2].Direction := ParameterDirection.Input;
   arParams[2].Value := user.EmailConfirmed;
   arParams[3] := new FbParameter('@PASSWORDHASH',FbDbType.VarChar, 254);
   arParams[3].Direction := ParameterDirection.Input;
   arParams[3].Charset := FbCharset.Iso8859_1 ;
   arParams[3].Value := user.PasswordHash;
   arParams[4] := new FbParameter('@SECURITYSTAMP',FbDbType.VarChar, 254);
   arParams[4].Direction := ParameterDirection.Input;
   arParams[4].Charset := FbCharset.Iso8859_1 ;
   arParams[4].Value := user.SecurityStamp;
   arParams[5] := new FbParameter('@PHONENUMBER',FbDbType.VarChar, 54);
   arParams[5].Direction := ParameterDirection.Input;
   arParams[5].Charset := FbCharset.Iso8859_1 ;
   arParams[5].Value := user.PhoneNumber;
   arParams[6] := new FbParameter('@PHONENUMBERCONFIRMED',FbDbType.SmallInt);
   arParams[6].Direction := ParameterDirection.Input;
   arParams[6].Value := user.PhoneNumberConfirmed;
   arParams[7] := new FbParameter('@TWOFACTORENABLED',FbDbType.SmallInt);
   arParams[7].Direction := ParameterDirection.Input;
   arParams[7].Value := user.TwoFactorEnabled;
   arParams[8] := new FbParameter('@LOCKOUTENDDATEUTC',FbDbType.TimeStamp);
   arParams[8].Direction := ParameterDirection.Input;
   arParams[8].Value := user.LockoutEndDateUtc;
   arParams[9] := new FbParameter('@LOCKOUTENABLED',FbDbType.SmallInt);
   arParams[9].Direction := ParameterDirection.Input; 
   arParams[9].Value := user.LockoutEnabled;
   arParams[10] := new FbParameter('@ACCESSFAILEDCOUNT',FbDbType.SmallInt);
   arParams[10].Direction := ParameterDirection.Input;
   arParams[10].Value := user.AccessFailedCount;
   arParams[11] := new FbParameter('@USERNAME',FbDbType.VarChar, 75);
   arParams[11].Direction := ParameterDirection.Input;
   arParams[11].Charset := FbCharset.Iso8859_1 ;
   arParams[11].Value := user.UserName;
   var rowsAffected: System.Int32 := FBSqlHelper.ExecuteNonQuery(_database.connectionString, CommandType.Text, sqlCommand.ToString(), arParams);
   exit rowsAffected;
end;


function UserTable<TUser>.uuidTXTtoguid(fvalue : String) : Guid;
begin
  exit new Guid(fvalue);
end;
end.
