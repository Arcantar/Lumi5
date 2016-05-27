namespace NorpaNet;

interface

uses
  System,
  System.Security.Claims,
  System.Threading.Tasks,
  System.Web,
  Microsoft.AspNet.Identity,
  AspNet.Identity.Firebird3,
  Microsoft.AspNet.Identity.Owin,
  Microsoft.Owin.Security,
  NorpaNet.Models;







type
  ApplicationUser = public class(IdentityUser)
  public
    method GenerateUserIdentity(manager: ApplicationUserManager): ClaimsIdentity;
    method GenerateUserIdentityAsync(manager: ApplicationUserManager): Task<ClaimsIdentity>;
  end;

  ApplicationDbContext = public class(FBDatabase)
  public
    constructor(connectionName: String);
    class method &Create: ApplicationDbContext;
    class method &Create(connection:String): ApplicationDbContext;
  end;

  IdentityHelper = public static class
  public
    class const XsrfKey: String = 'XsrfId';
    class const ProviderNameKey: String = 'providerName';
    class const CodeKey: String = 'code';
    class const UserIdKey: String = 'userId';
    class method SignIn(manager: ApplicationUserManager; user: ApplicationUser; isPersistent: Boolean);
    class method GetProviderNameFromRequest(request: HttpRequest): String;
    class method GetCodeFromRequest(request: HttpRequest): String;
    class method GetUserIdFromRequest(request: HttpRequest): String;
    class method GetResetPasswordRedirectUrl(code: String; request: HttpRequest): String;
    class method GetUserConfirmationRedirectUrl(code: String; userId: String; request: HttpRequest): String;
  private
    class method IsLocalUrl(url: String): Boolean;
  public
    class method RedirectToReturnUrl(returnUrl: String; response: HttpResponse);
  end;

implementation

method ApplicationUser.GenerateUserIdentity(manager: ApplicationUserManager): ClaimsIdentity;
begin
  //  Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
  var userIdentity := manager.CreateIdentity(self, DefaultAuthenticationTypes.ApplicationCookie);
  //  Add custom user claims here
  exit userIdentity;
end;

method ApplicationUser.GenerateUserIdentityAsync(manager: ApplicationUserManager): Task<ClaimsIdentity>;
begin
  exit Task.FromResult(GenerateUserIdentity(manager));
end;



constructor ApplicationDbContext(connectionName: String);
begin
end;

class method ApplicationDbContext.&Create: ApplicationDbContext;
begin
  exit new ApplicationDbContext('DefaultConnection');
end;
class method ApplicationDbContext.&Create(connection:String): ApplicationDbContext;
begin
  exit new ApplicationDbContext(connection);
end;





class method IdentityHelper.SignIn(manager: ApplicationUserManager; user: ApplicationUser; isPersistent: Boolean);
begin
  (*
  var authenticationManager: IAuthenticationManager := HttpContext.Current.GetOwinContext().Authentication;
  authenticationManager.SignOut(DefaultAuthenticationTypes.ExternalCookie);
  var identity := manager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
  authenticationManager.SignIn(new AuthenticationProperties(isPersistent := isPersistent), identity);
*)
end;

class method IdentityHelper.GetProviderNameFromRequest(request: HttpRequest): String;
begin
  exit request.QueryString[ProviderNameKey];
end;

class method IdentityHelper.GetCodeFromRequest(request: HttpRequest): String;
begin
  exit request.QueryString[CodeKey];
end;

class method IdentityHelper.GetUserIdFromRequest(request: HttpRequest): String;
begin
  exit HttpUtility.UrlDecode(request.QueryString[UserIdKey]);
end;

class method IdentityHelper.GetResetPasswordRedirectUrl(code: String; request: HttpRequest): String;
begin
  var absoluteUri := (('/Account/ResetPassword?' + CodeKey) + '=') + HttpUtility.UrlEncode(code);
  exit new Uri(request.Url, absoluteUri).AbsoluteUri.ToString();
end;

class method IdentityHelper.GetUserConfirmationRedirectUrl(code: String; userId: String; request: HttpRequest): String;
begin
  var absoluteUri := (((((('/Account/Confirm?' + CodeKey) + '=') + HttpUtility.UrlEncode(code)) + '&') + UserIdKey) + '=') + HttpUtility.UrlEncode(userId);
  exit new Uri(request.Url, absoluteUri).AbsoluteUri.ToString();
end;

class method IdentityHelper.IsLocalUrl(url: String): Boolean;
begin
  exit not String.IsNullOrEmpty(url) and (((url[0] = '/') and ((url.Length = 1) or ((url[1] <> '/') and (url[1] <> '\')))) or (((url.Length > 1) and (url[0] = '~')) and (url[1] = '/')));
end;

class method IdentityHelper.RedirectToReturnUrl(returnUrl: String; response: HttpResponse);
begin
  if not String.IsNullOrEmpty(returnUrl) and IsLocalUrl(returnUrl) then begin
    response.Redirect(returnUrl);
  end
  else begin
    response.Redirect('~/');
  end;
end;

end.
