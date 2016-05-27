namespace NorpaNet.Account;

interface

uses
  System,
  System.Web,
  System.Web.UI,
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin,
  Owin,
  NorpaNet,
  NorpaNet.Helper,
  NorpaNet.Models;

type
  Login = public partial class(Page)
  private
    var manager  := CacheHelper.RetrieveManager(Context);
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method LogIn(sender: Object; e: EventArgs);
  end;

implementation

uses 
  NorpaNet.Logic;

method Login.Page_Load(sender: Object; e: EventArgs);
begin
  RegisterHyperLink.NavigateUrl := '/Account/Register';
  //  Enable this once you have account confirmation enabled for password reset functionality
  ForgotPasswordHyperLink.NavigateUrl := "/Account/Forgot";
  //OpenAuthLogin.ReturnUrl := Request.QueryString['ReturnUrl'];
  var returnUrl:= HttpUtility.UrlEncode(Request.QueryString['ReturnUrl']);
  if not String.IsNullOrEmpty(returnUrl) then begin
    RegisterHyperLink.NavigateUrl := '?ReturnUrl=' + returnUrl;
  end;
end;

method Login.LogIn(sender: Object; e: EventArgs);
begin
  if IsValid then begin
    //  Validate the user password
    var signinManager := Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
    //  This doen't count login failures towards account lockout
    //  To enable password failures to trigger lockout, change to shouldLockout: true
    var fresult := signinManager.PasswordSignIn(Email.Text, Password.Text, RememberMe.Checked, false);
    case fresult of
      SignInStatus.Success: begin
        var usersShoppingCart: ShoppingCartActions := new ShoppingCartActions();
        var cartId: String := usersShoppingCart.GetCartId();
        var fuser := CacheHelper.RetrieveUserByEmail(Email.Text, Context);
        IdentityHelper.SignIn(manager, fuser,  false); 
        usersShoppingCart.MigrateCart(cartId, fuser.Id);
        IdentityHelper.RedirectToReturnUrl(Request.QueryString['ReturnUrl'], Response);
      end;
      SignInStatus.LockedOut: begin
        Response.Redirect('/Account/Lockout');
      end;
      SignInStatus.RequiresVerification: begin
        Response.Redirect(String.Format('/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}', Request.QueryString['ReturnUrl'], RememberMe.Checked), true);
      end;
      SignInStatus.Failure: begin
      end;
      else begin
        FailureText.Text := 'Invalid login attempt';
        ErrorMessage.Visible := true;
      end;
    end;
  end;
end;

end.
