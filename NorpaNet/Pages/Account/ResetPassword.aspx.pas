namespace NorpaNet.Account;

interface

uses
  System,
  System.Linq,
  System.Web,
  System.Web.UI,
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin,
  Owin,
  NorpaNet.Helper,
  NorpaNet.Models;

type
  ResetPassword = public class(Page)
  private
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
  protected
    property StatusMessage: String;
    method Reset_Click(sender: Object; e: EventArgs);
    var ErrorMessage: System.Web.UI.WebControls.Literal;
    var Email: System.Web.UI.WebControls.TextBox;
    var Password: System.Web.UI.WebControls.TextBox;
    var ConfirmPassword: System.Web.UI.WebControls.TextBox;


  end;

implementation

uses 
  NorpaNet;

method ResetPassword.Reset_Click(sender: Object; e: EventArgs);
begin
  var code: String := IdentityHelper.GetCodeFromRequest(Request);
  if code <> nil then begin
    if fuser = nil then begin
      ErrorMessage.Text := 'No user found';
      exit;
    end;
    var &result:= manager.ResetPassword(fuser.Id, code, Password.Text);
    if &result.Succeeded then begin
      Response.Redirect('~/Account/ResetPasswordConfirmation');
      exit;
    end;
    ErrorMessage.Text := &result.Errors.FirstOrDefault();
    exit;
  end;
  ErrorMessage.Text := 'An error has occurred';
end;

end.
