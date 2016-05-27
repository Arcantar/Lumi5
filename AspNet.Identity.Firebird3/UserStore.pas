namespace AspNet.Identity.Firebird3;

interface

uses
  Microsoft.AspNet.Identity,
  System,
  System.Collections.Generic,
  System.Linq,
  System.Security.Claims,
  System.Threading.Tasks;





type
  /// <summary>
  /// Class that implements the key ASP.NET Identity user store iterfaces
  /// </summary>
  UserStore<TUser> =  public  class (IUserStore<TUser>, IUserLoginStore<TUser>, IUserClaimStore<TUser>, IUserRoleStore<TUser>, IUserPasswordStore<TUser>, IUserSecurityStampStore<TUser>, IQueryableUserStore<TUser>, IUserEmailStore<TUser>, IUserPhoneNumberStore<TUser>, IUserTwoFactorStore<TUser,String>, IUserLockoutStore<TUser, String>, IUserStore<TUser>, IUserStore<TUser,String>, IDisposable)
  where TUser is IdentityUser;
  private
    var userTable: UserTable<TUser>;
    var roleTable: RoleTable;
    var userRolesTable: UserRolesTable;
    var userClaimsTable: UserClaimsTable;
    var userLoginsTable: UserLoginsTable;
  public
    property Database: FBDatabase;
    property Users: IQueryable<TUser> read getUsers;
  private
    method getUsers: IQueryable<TUser>;
  public
    /// <summary>
    /// Default constructor that initializes a new FBDatabase
    /// instance using the Default Connection string
    /// </summary>
    constructor;
    /// <summary>
    /// Constructor that takes a FBDatabase as argument
    /// </summary>
    /// <param name="database"></param>
    constructor(fdatabase: FBDatabase);
    /// <summary>
    /// Insert a new TUser in the UserTable
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method CreateAsync(user: TUser): Task;
    /// <summary>
    /// Returns an TUser instance based on a userId query
    /// </summary>
    /// <param name="userId">The user's Id</param>
    /// <returns></returns>
    method FindByIdAsync(userId: String): Task<TUser>;
    /// <summary>
    /// Returns an TUser instance based on a userName query
    /// </summary>
    /// <param name="userName">The user's name</param>
    /// <returns></returns>
    method FindByNameAsync(userName: String): Task<TUser>;
    /// <summary>
    /// Updates the UsersTable with the TUser instance values
    /// </summary>
    /// <param name="user">TUser to be updated</param>
    /// <returns></returns>
    method UpdateAsync(user: TUser): Task;
    method Dispose;
    /// <summary>
    /// Inserts a claim to the UserClaimsTable for the given user
    /// </summary>
    /// <param name="user">User to have claim added</param>
    /// <param name="claim">Claim to be added</param>
    /// <returns></returns>
    method AddClaimAsync(user: TUser; claim: Claim): Task;
    /// <summary>
    /// Returns all claims for a given user
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetClaimsAsync(user: TUser): Task<iList<Claim>>;
    /// <summary>
    /// Removes a claim froma user
    /// </summary>
    /// <param name="user">User to have claim removed</param>
    /// <param name="claim">Claim to be removed</param>
    /// <returns></returns>
    method RemoveClaimAsync(user: TUser; claim: Claim): Task;
    /// <summary>
    /// Inserts a Login in the UserLoginsTable for a given User
    /// </summary>
    /// <param name="user">User to have login added</param>
    /// <param name="login">Login to be added</param>
    /// <returns></returns>
    method AddLoginAsync(user: TUser; login: UserLoginInfo): Task;
    /// <summary>
    /// Returns an TUser based on the Login info
    /// </summary>
    /// <param name="login"></param>
    /// <returns></returns>
    method FindAsync(login: UserLoginInfo): Task<TUser>;
    /// <summary>
    /// Returns list of UserLoginInfo for a given TUser
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetLoginsAsync(user: TUser): Task<IList<UserLoginInfo>>;
    /// <summary>
    /// Deletes a login from UserLoginsTable for a given TUser
    /// </summary>
    /// <param name="user">User to have login removed</param>
    /// <param name="login">Login to be removed</param>
    /// <returns></returns>
    method RemoveLoginAsync(user: TUser; login: UserLoginInfo): Task;
    /// <summary>
    /// Inserts a entry in the UserRoles table
    /// </summary>
    /// <param name="user">User to have role added</param>
    /// <param name="roleName">Name of the role to be added to user</param>
    /// <returns></returns>
    method AddToRoleAsync(user: TUser; roleName: String): Task;
    /// <summary>
    /// Returns the roles for a given TUser
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetRolesAsync(user: TUser): Task<iList<String>>;
    /// <summary>
    /// Verifies if a user is in a role
    /// </summary>
    /// <param name="user"></param>
    /// <param name="role"></param>
    /// <returns></returns>
    method IsInRoleAsync(user: TUser; role: String): Task<Boolean>;
    /// <summary>
    /// Removes a user from a role
    /// </summary>
    /// <param name="user"></param>
    /// <param name="role"></param>
    /// <returns></returns>
    method RemoveFromRoleAsync(user: TUser; role: String): Task;
    /// <summary>
    /// Deletes a user
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method DeleteAsync(user: TUser): Task;
    /// <summary>
    /// Returns the PasswordHash for a given TUser
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetPasswordHashAsync(user: TUser): Task<String>;
    /// <summary>
    /// Verifies if user has password
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method HasPasswordAsync(user: TUser): Task<Boolean>;
    /// <summary>
    /// Sets the password hash for a given TUser
    /// </summary>
    /// <param name="user"></param>
    /// <param name="passwordHash"></param>
    /// <returns></returns>
    method SetPasswordHashAsync(user: TUser; passwordHash: String): Task;
    /// <summary>
    /// Set security stamp
    /// </summary>
    /// <param name="user"></param>
    /// <param name="stamp"></param>
    /// <returns></returns>
    method SetSecurityStampAsync(user: TUser; stamp: String): Task;
    /// <summary>
    /// Get security stamp
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetSecurityStampAsync(user: TUser): Task<String>;
    /// <summary>
    /// Set email on user
    /// </summary>
    /// <param name="user"></param>
    /// <param name="email"></param>
    /// <returns></returns>
    method SetEmailAsync(user: TUser; email: String): Task;
    /// <summary>
    /// Get email from user
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetEmailAsync(user: TUser): Task<String>;
    /// <summary>
    /// Get if user email is confirmed
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetEmailConfirmedAsync(user: TUser): Task<Boolean>;
    /// <summary>
    /// Set when user email is confirmed
    /// </summary>
    /// <param name="user"></param>
    /// <param name="confirmed"></param>
    /// <returns></returns>
    method SetEmailConfirmedAsync(user: TUser; confirmed: Boolean): Task;
    /// <summary>
    /// Get user by email
    /// </summary>
    /// <param name="email"></param>
    /// <returns></returns>
    method FindByEmailAsync(email: String): Task<TUser>;
    /// <summary>
    /// Set user phone number
    /// </summary>
    /// <param name="user"></param>
    /// <param name="phoneNumber"></param>
    /// <returns></returns>
    method SetPhoneNumberAsync(user: TUser; phoneNumber: String): Task;
    /// <summary>
    /// Get user phone number
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetPhoneNumberAsync(user: TUser): Task<String>;
    /// <summary>
    /// Get if user phone number is confirmed
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetPhoneNumberConfirmedAsync(user: TUser): Task<Boolean>;
    /// <summary>
    /// Set phone number if confirmed
    /// </summary>
    /// <param name="user"></param>
    /// <param name="confirmed"></param>
    /// <returns></returns>
    method SetPhoneNumberConfirmedAsync(user: TUser; confirmed: Boolean): Task;
    /// <summary>
    /// Set two factor authentication is enabled on the user
    /// </summary>
    /// <param name="user"></param>
    /// <param name="enabled"></param>
    /// <returns></returns>
    method SetTwoFactorEnabledAsync(user: TUser; enabled: Boolean): Task;
    /// <summary>
    /// Get if two factor authentication is enabled on the user
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetTwoFactorEnabledAsync(user: TUser): Task<Boolean>;
    /// <summary>
    /// Get user lock out end date
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetLockoutEndDateAsync(user: TUser): Task<DateTimeOffset>;
    /// <summary>
    /// Set user lockout end date
    /// </summary>
    /// <param name="user"></param>
    /// <param name="lockoutEnd"></param>
    /// <returns></returns>
    method SetLockoutEndDateAsync(user: TUser; lockoutEnd: DateTimeOffset): Task;
    /// <summary>
    /// Increment failed access count
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method IncrementAccessFailedCountAsync(user: TUser): Task<Integer>;
    /// <summary>
    /// Reset failed access count
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method ResetAccessFailedCountAsync(user: TUser): Task;
    /// <summary>
    /// Get failed access count
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetAccessFailedCountAsync(user: TUser): Task<Integer>;
    /// <summary>
    /// Get if lockout is enabled for the user
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method GetLockoutEnabledAsync(user: TUser): Task<Boolean>;
    /// <summary>
    /// Set lockout enabled for user
    /// </summary>
    /// <param name="user"></param>
    /// <param name="enabled"></param>
    /// <returns></returns>
    method SetLockoutEnabledAsync(user: TUser; enabled: Boolean): Task;
  end;

implementation

method UserStore<TUser>.getUsers: IQueryable<TUser>;
begin
  raise new NotImplementedException();
end;

constructor UserStore<TUser>;
begin
  new UserStore<TUser>(new FBDatabase());
end;

constructor UserStore<TUser>(fdatabase: FBDatabase);
begin
  Database := fdatabase;
  userTable := new userTable<TUser>(Database);
  roleTable := new RoleTable(Database);
  userRolesTable := new UserRolesTable(Database);
  userClaimsTable := new UserClaimsTable(Database);
  userLoginsTable := new UserLoginsTable(Database);
end;


method UserStore<TUser>.CreateAsync(user: TUser): Task;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  
  exit Task.FromResult(userTable.Insert(user));
end;

method UserStore<TUser>.FindByIdAsync(userId: String): Task<TUser>;
begin
  if String.IsNullOrEmpty(userId) then begin
    raise new ArgumentException('Null or empty argument: userId');
  end;
  var fresult: TUser := TUser(userTable.GetUserById(userId));
  if fresult <> nil then begin
    exit Task.FromResult<TUser>(fresult);
  end;
  exit Task.FromResult<TUser>(nil);
end;

method UserStore<TUser>.FindByNameAsync(userName: String): Task<TUser>;
begin
  if String.IsNullOrEmpty(userName) then begin
    raise new ArgumentException('Null or empty argument: userName');
  end;
  var fresult: List<TUser> := if userName.Contains('@') then userTable.GetUserByEmail(userName) else userTable.GetUserByName(userName) ;
  //  Should I throw if > 1 user?
  if (fresult <> nil) and (fresult.Count <> 0) then begin
    exit Task.FromResult<TUser>(fresult[0]);
  end;
  exit Task.FromResult<TUser>(nil);
end;

method UserStore<TUser>.UpdateAsync(user: TUser): Task;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  
  exit Task.FromResult(userTable.Update(user));
end;

method UserStore<TUser>.Dispose;
begin
  if Database <> nil then begin
    Database.Dispose();
    Database := nil;
  end;
end;

method UserStore<TUser>.AddClaimAsync(user: TUser; claim: Claim): Task;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  if claim = nil then begin
    raise new ArgumentNullException('user');
  end;
  
  exit Task.FromResult(userClaimsTable.Insert(claim, user.Id));
end;

method UserStore<TUser>.GetClaimsAsync(user: TUser): Task<iList<Claim>>;
begin
  var identity: ClaimsIdentity := userClaimsTable.FindByUserId(user.Id);
  exit Task.FromResult(identity.Claims.ToList as IList<Claim>);
end;

method UserStore<TUser>.RemoveClaimAsync(user: TUser; claim: Claim): Task;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  if claim = nil then begin
    raise new ArgumentNullException('claim');
  end;
  
  exit Task.FromResult(userClaimsTable.Delete(IdentityUser(user), claim));
end;

method UserStore<TUser>.AddLoginAsync(user: TUser; login: UserLoginInfo): Task;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  if login = nil then begin
    raise new ArgumentNullException('login');
  end;
  
  exit Task.FromResult(userLoginsTable.Insert(IdentityUser(user), login));
end;

method UserStore<TUser>.FindAsync(login: UserLoginInfo): Task<TUser>;
begin
  if login = nil then begin
    raise new ArgumentNullException('login');
  end;
  var userId := userLoginsTable.FindUserIdByLogin(login);
  if userId <> nil then begin
    var user := userTable.GetUserById(userId);
    if user <> nil then begin
      exit Task.FromResult<TUser>(user as TUser);
    end;
  end;
  exit Task.FromResult(IdentityRole(nil) as TUser);
end;

method UserStore<TUser>.GetLoginsAsync(user: TUser): Task<IList<UserLoginInfo>>;
begin
  var userLogins: List<UserLoginInfo> := new List<UserLoginInfo>();
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  var logins: iList<UserLoginInfo> := userLoginsTable.FindByUserId(user.Id);
  if logins <> nil then begin
    exit Task.FromResult(logins);
  end;
  exit Task.FromResult(logins);
end;

method UserStore<TUser>.RemoveLoginAsync(user: TUser; login: UserLoginInfo): Task;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  if login = nil then begin
    raise new ArgumentNullException('login');
  end;
  
  exit Task.FromResult(userLoginsTable.Delete(IdentityUser(user), login));
end;

method UserStore<TUser>.AddToRoleAsync(user: TUser; roleName: String): Task;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  if String.IsNullOrEmpty(roleName) then begin
    raise new ArgumentException('Argument cannot be null or empty: roleName.');
  end;
  var roleId: String := roleTable.GetRoleId(roleName);
  if not String.IsNullOrEmpty(roleId) then begin
    userRolesTable.Insert(IdentityUser(user), roleId);
  end;
  exit Task.FromResult(0);
end;

method UserStore<TUser>.GetRolesAsync(user: TUser): Task<iList<String>>;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  var roles: iList<String> := userRolesTable.FindByUserId(user.Id);
  begin
    if roles <> nil then begin
      exit Task.FromResult(roles);
    end;
  end;
  exit Task.FromResult(roles);
end;

method UserStore<TUser>.IsInRoleAsync(user: TUser; role: String): Task<Boolean>;
begin
  if user = nil then begin
    raise new ArgumentNullException('user');
  end;
  if String.IsNullOrEmpty(role) then begin
    raise new ArgumentNullException('role');
  end;
  var roles: List<String> := userRolesTable.FindByUserId(user.Id);
  begin
    if (roles <> nil) and roles.Contains(role) then begin
      exit Task.FromResult(true);
    end;
  end;
  exit Task.FromResult(false);
end;

method UserStore<TUser>.RemoveFromRoleAsync(user: TUser; role: String): Task;
begin
  raise new NotImplementedException();
end;

method UserStore<TUser>.DeleteAsync(user: TUser): Task;
begin
  if user <> nil then begin
    userTable.Delete(user);
  end;
  exit Task.FromResult(0);
end;

method UserStore<TUser>.GetPasswordHashAsync(user: TUser): Task<String>;
begin
  var passwordHash: String := userTable.GetPasswordHash(user.Id);
  exit Task.FromResult(passwordHash);
end;

method UserStore<TUser>.HasPasswordAsync(user: TUser): Task<Boolean>;
begin
  var hasPassword := not String.IsNullOrEmpty(userTable.GetPasswordHash(user.Id));
  exit Task.FromResult(Boolean.Parse(hasPassword.ToString()));
end;

method UserStore<TUser>.SetPasswordHashAsync(user: TUser; passwordHash: String): Task;
begin
  user.PasswordHash := passwordHash;
  exit Task.FromResult(0);
end;

method UserStore<TUser>.SetSecurityStampAsync(user: TUser; stamp: String): Task;
begin
  user.SecurityStamp := stamp;
  exit Task.FromResult(0);
end;

method UserStore<TUser>.GetSecurityStampAsync(user: TUser): Task<String>;
begin
  exit Task.FromResult(user.SecurityStamp);
end;

method UserStore<TUser>.SetEmailAsync(user: TUser; email: String): Task;
begin
  user.Email := email;
  userTable.Update(user);
  exit Task.FromResult(0);
end;

method UserStore<TUser>.GetEmailAsync(user: TUser): Task<String>;
begin
  exit Task.FromResult(user.Email);
end;

method UserStore<TUser>.GetEmailConfirmedAsync(user: TUser): Task<Boolean>;
begin
  exit Task.FromResult(user.EmailConfirmed);
end;

method UserStore<TUser>.SetEmailConfirmedAsync(user: TUser; confirmed: Boolean): Task;
begin
  user.EmailConfirmed := confirmed;
  userTable.Update(user);
  exit Task.FromResult(0);
end;

method UserStore<TUser>.FindByEmailAsync(email: String): Task<TUser>;
begin
  if String.IsNullOrEmpty(email) then begin
    raise new ArgumentNullException('email');
  end;
  var fresult:List<TUser> := userTable.GetUserByEmail(email) as list<TUser>;
  if (fresult <> nil) and (fresult.Count<> 0) then begin
    exit Task.FromResult<TUser>(fresult[0]);
  end;
  exit Task.FromResult<TUser>(nil);
end;

method UserStore<TUser>.SetPhoneNumberAsync(user: TUser; phoneNumber: String): Task;
begin
  user.PhoneNumber := phoneNumber;
  userTable.Update(user);
  exit Task.FromResult(0);
end;

method UserStore<TUser>.GetPhoneNumberAsync(user: TUser): Task<String>;
begin
  exit Task.FromResult(user.PhoneNumber);
end;

method UserStore<TUser>.GetPhoneNumberConfirmedAsync(user: TUser): Task<Boolean>;
begin
  exit Task.FromResult(user.PhoneNumberConfirmed);
end;

method UserStore<TUser>.SetPhoneNumberConfirmedAsync(user: TUser; confirmed: Boolean): Task;
begin
  user.PhoneNumberConfirmed := confirmed;
  userTable.Update(user);
  exit Task.FromResult(0);
end;

method UserStore<TUser>.SetTwoFactorEnabledAsync(user: TUser; enabled: Boolean): Task;
begin
  user.TwoFactorEnabled := enabled;
  userTable.Update(user);
  exit Task.FromResult(0);
end;

method UserStore<TUser>.GetTwoFactorEnabledAsync(user: TUser): Task<Boolean>;
begin
  exit Task.FromResult(user.TwoFactorEnabled);
end;

method UserStore<TUser>.GetLockoutEndDateAsync(user: TUser): Task<DateTimeOffset>;
begin
  exit Task.FromResult(if user.LockoutEndDateUtc <> nil then new DateTimeOffset(DateTime.SpecifyKind(user.LockoutEndDateUtc, DateTimeKind.Utc)) else new DateTimeOffset());
end;

method UserStore<TUser>.SetLockoutEndDateAsync(user: TUser; lockoutEnd: DateTimeOffset): Task;
begin
  IdentityUser(user).LockoutEndDateUtc := lockoutEnd.UtcDateTime;
  userTable.Update(user);
  exit Task.FromResult(0);
end;

method UserStore<TUser>.IncrementAccessFailedCountAsync(user: TUser): Task<Integer>;
begin
  inc(IdentityUser(user).AccessFailedCount);  
  userTable.Update(user);
  exit Task.FromResult(user.AccessFailedCount);
end;

method UserStore<TUser>.ResetAccessFailedCountAsync(user: TUser): Task;
begin
  user.AccessFailedCount := 0;
  exit Task.FromResult(userTable.Update(user));
end;

method UserStore<TUser>.GetAccessFailedCountAsync(user: TUser): Task<Integer>;
begin
  exit Task.FromResult(user.AccessFailedCount);
end;

method UserStore<TUser>.GetLockoutEnabledAsync(user: TUser): Task<Boolean>;
begin
  exit Task.FromResult(user.LockoutEnabled);
end;

method UserStore<TUser>.SetLockoutEnabledAsync(user: TUser; enabled: Boolean): Task;
begin
  user.LockoutEnabled := enabled;
  
  exit Task.FromResult(userTable.Update(user));
end;

end.
