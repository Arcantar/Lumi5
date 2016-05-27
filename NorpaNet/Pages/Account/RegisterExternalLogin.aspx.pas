namespace NorpaNet.Account;

interface

uses
  System,
  System.Web,
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin,
  Microsoft.Owin.Security,
  Owin,
  NorpaNet.Helper,
  NorpaNet.Models;

type
  RegisterExternalLogin = public class(System.Web.UI.Page)
  protected
    property ProviderName: String read String(if ViewState['ProviderName'] = nil then String.Empty else ViewState['ProviderName']) write ViewState['ProviderName'];
    property ProviderAccountKey: String read String(if ViewState['ProviderAccountKey'] = nil then String.Empty else ViewState['ProviderAccountKey']) write ViewState['ProviderAccountKey'];
  private
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
    method RedirectOnFail;
  protected
    method Page_Load;
    method LogIn_Click(sender: Object; e: EventArgs);
  var email: System.Web.UI.WebControls.TextBox;
  private
    method CreateAndLoginUser;
    method AddErrors(&result: IdentityResult);
  

  end;

implementation

uses 
  AspNet.Identity.Firebird3,
  NorpaNet;

method RegisterExternalLogin.RedirectOnFail;
begin
    Response.Redirect(if (User.Identity.IsAuthenticated) then '~/Account/Manage' else '~/Account/Login');

end;

method RegisterExternalLogin.Page_Load;
begin
  //  Process the result from an auth provider in the request
  ProviderName := IdentityHelper.GetProviderNameFromRequest(Request);
  if String.IsNullOrEmpty(ProviderName) then begin
    RedirectOnFail();
    exit;
  end;
  if not IsPostBack then begin
    var loginInfo := Context.GetOwinContext().Authentication.GetExternalLoginInfo();
    if loginInfo = nil then begin
      RedirectOnFail();
      exit;
    end;
    var user := manager.Find(loginInfo.Login);
    if user <> nil then begin
      IdentityHelper.SignIn(manager, user,  false);
      IdentityHelper.RedirectToReturnUrl(Request.QueryString['ReturnUrl'], Response);
    end
    else
      if HttpContext.Current.User.Identity.IsAuthenticated then begin
        //  Apply Xsrf check when linking
        var verifiedloginInfo := Context.GetOwinContext().Authentication.GetExternalLoginInfo(IdentityHelper.XsrfKey, HttpContext.Current.User.Identity.GetUserId());
        if verifiedloginInfo = nil then begin
          RedirectOnFail();
          exit;
        end;
        var &result:= manager.AddLogin(HttpContext.Current.User.Identity.GetUserId(), verifiedloginInfo.Login);
        if &result.Succeeded then begin
          IdentityHelper.RedirectToReturnUrl(Request.QueryString['ReturnUrl'], Response);
        end
        else begin
          AddErrors(&result);
          exit;
        end;
      end
      else begin
        email.Text := loginInfo.Email;
      end;
  end;
end;

method RegisterExternalLogin.LogIn_Click(sender: Object; e: EventArgs);
begin
  CreateAndLoginUser();
end;

method RegisterExternalLogin.CreateAndLoginUser;
begin
  if not IsValid then begin
    exit;
  end;
  var user := new ApplicationUser;
  user.UserName := email.Text;
  user.Email    := email.Text;
  var fresult: IdentityResult := manager.&Create(user);
  if fresult.Succeeded then begin
    var loginInfo := Context.GetOwinContext().Authentication.GetExternalLoginInfo();
    if loginInfo = nil then begin
      RedirectOnFail();
      exit;
    end;
    fresult := manager.AddLogin(user.Id, loginInfo.Login);
    if fresult.Succeeded then begin
      IdentityHelper.SignIn(manager, user, false);
      //  For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
      //  var code = manager.GenerateEmailConfirmationToken(user.Id);
      //  Send this link via email: IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id)
      IdentityHelper.RedirectToReturnUrl(Request.QueryString['ReturnUrl'], Response);
      exit;
    end;
  end;
  AddErrors(fresult);
end;

method RegisterExternalLogin.AddErrors(&result: IdentityResult);
begin
  for each error in &result.Errors do begin
    ModelState.AddModelError('', error);
  end;
end;

end.
