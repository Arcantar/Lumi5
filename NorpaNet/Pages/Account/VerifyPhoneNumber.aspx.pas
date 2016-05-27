namespace NorpaNet.Account;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin;

type
  VerifyPhoneNumber = public class(System.Web.UI.Page)
  private    
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method Code_Click(sender: Object; e: EventArgs);
    var ErrorMessage: System.Web.UI.WebControls.Literal;
    var PhoneNumber: System.Web.UI.WebControls.HiddenField;
    var Code: System.Web.UI.WebControls.TextBox;

  end;

implementation

uses 
  NorpaNet, 
  NorpaNet.Helper;

method VerifyPhoneNumber.Page_Load(sender: Object; e: EventArgs);
begin
  var phonenumberstr:= Request.QueryString['PhoneNumber'];
 
  var smsservice := Request.QueryString['sms'];
  if smsservice<> nil then begin
    var &result := manager.ChangePhoneNumber(User.Identity.GetUserId(), phonenumberstr, smsservice);
    if &result.Succeeded then begin
      if fuser <> nil then begin
        IdentityHelper.SignIn(manager, fuser, false);
        Response.Redirect('/Account/Manage?m=AddPhoneNumberSuccess');
      end else ModelState.AddModelError('', 'Failed to modify your phone number');
    end;
  end;
  PhoneNumber.Value := phonenumberstr;
end;

method VerifyPhoneNumber.Code_Click(sender: Object; e: EventArgs);
begin
  if not ModelState.IsValid then begin
    ModelState.AddModelError('', 'Invalid code');
    exit;
  end;
  var &result := manager.ChangePhoneNumber(User.Identity.GetUserId(), PhoneNumber.Value, Code.Text);
  if &result.Succeeded then begin
    if fuser <> nil then begin
      IdentityHelper.SignIn(manager, fuser, false);
      Response.Redirect('/Account/Manage?m=AddPhoneNumberSuccess');
    end;
  end;
  //  If we got this far, something failed, redisplay form
  ModelState.AddModelError('', 'Failed to verify phone');
end;

end.
