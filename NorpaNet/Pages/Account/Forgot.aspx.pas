namespace NorpaNet.Account;

interface

uses
  System,
  System.Web,
  System.Web.UI,
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin,
  Owin,
  NorpaNet.Helper,
  NorpaNet.Models;

type
  ForgotPassword = public partial class(Page)
  private
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method Forgot(sender: Object; e: EventArgs);
  end;

implementation

uses 
  NorpaNet;

method ForgotPassword.Page_Load(sender: Object; e: EventArgs);
begin
end;

method ForgotPassword.Forgot(sender: Object; e: EventArgs);
begin
  if IsValid then begin
    //  Validate the user's email address
    if (fuser = nil) or not fuser.EmailConfirmed then begin
      FailureText.Text := 'The user either does not exist or is not confirmed.';
      ErrorMessage.Visible := true;
      exit;
    end;
    //  For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
    //  Send email with the code and the redirect to reset password page
    //  string code = manager.GeneratePasswordResetToken(user.Id);
    //  string callbackUrl = IdentityHelper.GetResetPasswordRedirectUrl(code, Request);
    //  manager.SendEmail(user.Id, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>.");
    loginForm.Visible := false;
    DisplayEmail.Visible := true;
  end;
end;

end.
