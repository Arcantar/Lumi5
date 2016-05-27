namespace AspNet.Identity.Firebird3;

interface

uses
  System;

type
  IUserStore2<IdentityRole> = private interface 
    property Database: FBDatabase read write;
    method AddClaimAsync(user: IdentityRole; claim: System.Security.Claims.Claim): System.Threading.Tasks.Task;
    method AddLoginAsync(user: IdentityRole; login: Microsoft.AspNet.Identity.UserLoginInfo): System.Threading.Tasks.Task;
    method AddToRoleAsync(user: IdentityRole; roleName: String): System.Threading.Tasks.Task;
    method CreateAsync(user: IdentityRole): System.Threading.Tasks.Task;
    method DeleteAsync(user: IdentityRole): System.Threading.Tasks.Task;
    method Dispose;
    method FindAsync(login: Microsoft.AspNet.Identity.UserLoginInfo): System.Threading.Tasks.Task<IdentityRole>;
    method FindByEmailAsync(email: String): System.Threading.Tasks.Task<IdentityRole>;
    method FindByIdAsync(userId: String): System.Threading.Tasks.Task<IdentityRole>;
    method FindByNameAsync(userName: String): System.Threading.Tasks.Task<IdentityRole>;
    method GetAccessFailedCountAsync(user: IdentityRole): System.Threading.Tasks.Task<Integer>;
    method GetClaimsAsync(user: IdentityRole): System.Threading.Tasks.Task<System.Collections.Generic.IList<System.Security.Claims.Claim>>;
    method GetEmailAsync(user: IdentityRole): System.Threading.Tasks.Task<String>;
    method GetEmailConfirmedAsync(user: IdentityRole): System.Threading.Tasks.Task<Boolean>;
    method GetLockoutEnabledAsync(user: IdentityRole): System.Threading.Tasks.Task<Boolean>;
    method GetLockoutEndDateAsync(user: IdentityRole): System.Threading.Tasks.Task<DateTimeOffset>;
    method GetLoginsAsync(user: IdentityRole): System.Threading.Tasks.Task<System.Collections.Generic.IList<Microsoft.AspNet.Identity.UserLoginInfo>>;
    method GetPasswordHashAsync(user: IdentityRole): System.Threading.Tasks.Task<String>;
    method GetPhoneNumberAsync(user: IdentityRole): System.Threading.Tasks.Task<String>;
    method GetPhoneNumberConfirmedAsync(user: IdentityRole): System.Threading.Tasks.Task<Boolean>;
    method GetRolesAsync(user: IdentityRole): System.Threading.Tasks.Task<System.Collections.Generic.IList<String>>;
    method GetSecurityStampAsync(user: IdentityRole): System.Threading.Tasks.Task<String>;
    method GetTwoFactorEnabledAsync(user: IdentityRole): System.Threading.Tasks.Task<Boolean>;
    method HasPasswordAsync(user: IdentityRole): System.Threading.Tasks.Task<Boolean>;
    method IncrementAccessFailedCountAsync(user: IdentityRole): System.Threading.Tasks.Task<Integer>;
    method IsInRoleAsync(user: IdentityRole; role: String): System.Threading.Tasks.Task<Boolean>;
    method RemoveClaimAsync(user: IdentityRole; claim: System.Security.Claims.Claim): System.Threading.Tasks.Task;
    method RemoveFromRoleAsync(user: IdentityRole; role: String): System.Threading.Tasks.Task;
    method RemoveLoginAsync(user: IdentityRole; login: Microsoft.AspNet.Identity.UserLoginInfo): System.Threading.Tasks.Task;
    method ResetAccessFailedCountAsync(user: IdentityRole): System.Threading.Tasks.Task;
    method SetEmailAsync(user: IdentityRole; email: String): System.Threading.Tasks.Task;
    method SetEmailConfirmedAsync(user: IdentityRole; confirmed: Boolean): System.Threading.Tasks.Task;
    method SetLockoutEnabledAsync(user: IdentityRole; enabled: Boolean): System.Threading.Tasks.Task;
    method SetLockoutEndDateAsync(user: IdentityRole; lockoutEnd: DateTimeOffset): System.Threading.Tasks.Task;
    method SetPasswordHashAsync(user: IdentityRole; passwordHash: String): System.Threading.Tasks.Task;
    method SetPhoneNumberAsync(user: IdentityRole; phoneNumber: String): System.Threading.Tasks.Task;
    method SetPhoneNumberConfirmedAsync(user: IdentityRole; confirmed: Boolean): System.Threading.Tasks.Task;
    method SetSecurityStampAsync(user: IdentityRole; stamp: String): System.Threading.Tasks.Task;
    method SetTwoFactorEnabledAsync(user: IdentityRole; enabled: Boolean): System.Threading.Tasks.Task;
    method UpdateAsync(user: IdentityRole): System.Threading.Tasks.Task;
  end;

implementation

end.
