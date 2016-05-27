namespace NorpaNet.Account;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Threading.Tasks,
  System.Web,
  Microsoft.AspNet.Identity,
  AspNet.Identity.Firebird3,
  Microsoft.AspNet.Identity.Owin,
  Microsoft.Owin.Security,
  Owin,
  NorpaNet,
  NorpaNet.Models;

type
  Manage = public partial class(System.Web.UI.Page)
  protected
    property SuccessMessage: String;
  public
    property HasPhoneNumber: Boolean;
    property TwoFactorEnabled: Boolean;
    property TwoFactorBrowserRemembered: Boolean;
    property LoginsCount: Integer;
  private
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
    method HasPassword(fmanager: ApplicationUserManager): Boolean;
  protected
    method Page_Load;
  private
    method AddErrors(&result: IdentityResult);
  protected
    //  Remove phonenumber from user
    method RemovePhone_Click(sender: Object; e: EventArgs);
    //  DisableTwoFactorAuthentication
    method TwoFactorDisable_Click(sender: Object; e: EventArgs);
    //  EnableTwoFactorAuthentication
    method TwoFactorEnable_Click(sender: Object; e: EventArgs);
  end;

implementation

uses 
  NorpaNet.Helper;

method Manage.HasPassword(fmanager: ApplicationUserManager): Boolean;
begin
  exit fmanager.HasPassword(User.Identity.GetUserId());
end;

method Manage.Page_Load;
begin  
  HasPhoneNumber := String.IsNullOrEmpty(fuser.PhoneNumber);
  PhoneAdd.Visible := HasPhoneNumber;
  PhoneRemove.Visible := not HasPhoneNumber;
  PhoneChange.Visible := not HasPhoneNumber;
  //  Enable this after setting up two-factor authentientication
  PhoneNumber.Text := fuser.PhoneNumber;
  TwoFactorEnabled := fuser.TwoFactorEnabled;
  LoginsCount := manager.GetLogins(User.Identity.GetUserId()).Count;
  if not IsPostBack then begin
    //  Determine the sections to render
    if HasPassword(manager) then begin
      ChangePassword.Visible := true;
    end
    else begin
      CreatePassword.Visible := true;
      ChangePassword.Visible := false;
    end;
    //  Render success message
    var message := Request.QueryString['m'];
    if message <> nil then begin
      //  Strip the query string from action
      Form.Action := ResolveUrl('~/Account/Manage');
      SuccessMessage := if message = 'ChangePwdSuccess' then 'Your password has been changed.' else if message = 'SetPwdSuccess' then 'Your password has been set.' else if message = 'RemoveLoginSuccess' then 'The account was removed.' else if message = 'AddPhoneNumberSuccess' then 'Phone number has been added' else if message = 'RemovePhoneNumberSuccess' then 'Phone number was removed' else String.&Empty;
      successMessageolder.Visible := not String.IsNullOrEmpty(SuccessMessage);
    end;
  end;
end;

method Manage.AddErrors(&result: IdentityResult);
begin
  for each errorr in &result.Errors do begin
    ModelState.AddModelError('', errorr);
  end;
end;

method Manage.RemovePhone_Click(sender: Object; e: EventArgs);
begin
  var &result := manager.SetPhoneNumber(User.Identity.GetUserId(), nil);
  if not &result.Succeeded then begin
    exit;
  end;
  var fuser := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);manager.FindById(User.Identity.GetUserId());
  if fuser <> nil then begin
    IdentityHelper.SignIn(manager, fuser, false);
    Response.Redirect('/Account/Manage?m=RemovePhoneNumberSuccess');
  end;
end;

method Manage.TwoFactorDisable_Click(sender: Object; e: EventArgs);
begin
  manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);
  Response.Redirect('/Account/Manage');
end;

method Manage.TwoFactorEnable_Click(sender: Object; e: EventArgs);
begin
  manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);
  Response.Redirect('/Account/Manage');
end;

end.
