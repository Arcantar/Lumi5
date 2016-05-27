namespace NorpaNet.Account;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Threading.Tasks,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin,
  NorpaNet,
  NorpaNet.Helper,
  NorpaNet.Models;

type
  TwoFactorAuthenticationSignIn = public class(System.Web.UI.Page)
  private
    var signinManager: ApplicationSignInManager;   
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
  public
    constructor;
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method CodeSubmit_Click(sender: Object; e: EventArgs);
    method ProviderSubmit_Click(sender: Object; e: EventArgs);
    var sendcode: System.Web.UI.WebControls.PlaceHolder;
    var Providers: System.Web.UI.WebControls.DropDownList;
    var ProviderSubmit: System.Web.UI.WebControls.Button;
    var verifycode: System.Web.UI.WebControls.PlaceHolder;
    var SelectedProvider: System.Web.UI.WebControls.HiddenField;
    var ErrorMessage: System.Web.UI.WebControls.PlaceHolder;
    var FailureText: System.Web.UI.WebControls.Literal;
    var Code: System.Web.UI.WebControls.TextBox;
    var RememberBrowser: System.Web.UI.WebControls.CheckBox;
    var CodeSubmit: System.Web.UI.WebControls.Button;

  end;

implementation

constructor TwoFactorAuthenticationSignIn;
begin
  signinManager := Context.GetOwinContext().GetUserManager<ApplicationSignInManager>;
end;

method TwoFactorAuthenticationSignIn.Page_Load(sender: Object; e: EventArgs);
begin
  var userId := signinManager.GetVerifiedUserId();
  if userId = nil then begin
    Response.Redirect('/Account/Error', true);
  end;
  var userFactors := manager.GetValidTwoFactorProviders(userId);
  Providers.DataSource := userFactors.Select(x -> x).ToList();
  Providers.DataBind();
end;

method TwoFactorAuthenticationSignIn.CodeSubmit_Click(sender: Object; e: EventArgs);
begin
  var rememberMe: Boolean := false;
  Boolean.TryParse(Request.QueryString['RememberMe'], out rememberMe);
  var fresult := signinManager.TwoFactorSignIn(SelectedProvider.Value, Code.Text, rememberMe,  RememberBrowser.Checked);
  case fresult of
    SignInStatus.Success: begin
      IdentityHelper.RedirectToReturnUrl(Request.QueryString['ReturnUrl'], Response);
    end;
    SignInStatus.LockedOut: begin
      Response.Redirect('/Account/Lockout');
    end;
    SignInStatus.Failure: begin
    end;
    else begin
      FailureText.Text := 'Invalid code';
      ErrorMessage.Visible := true;
    end;
  end;
end;

method TwoFactorAuthenticationSignIn.ProviderSubmit_Click(sender: Object; e: EventArgs);
begin
  if not signinManager.SendTwoFactorCode(Providers.SelectedValue) then begin
    Response.Redirect('/Account/Error');
  end;
  if fuser <> nil then begin
    var code := manager.GenerateTwoFactorToken(fuser.Id, Providers.SelectedValue);
  end;
  SelectedProvider.Value := Providers.SelectedValue;
  sendcode.Visible := false;
  verifycode.Visible := true;
end;

end.
