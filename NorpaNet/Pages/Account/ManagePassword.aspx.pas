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
  Microsoft.AspNet.Identity.Owin, 
  NorpaNet, 
  NorpaNet.Helper;

type
  ManagePassword = public partial class(System.Web.UI.Page)
  protected
    property SuccessMessage: String;
  private
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
    method HasPassword(fmanager: ApplicationUserManager): Boolean;
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method ChangePassword_Click(sender: Object; e: EventArgs);
    method SetPassword_Click(sender: Object; e: EventArgs);
  private
    method AddErrors(&result: IdentityResult);
  end;

implementation

method ManagePassword.HasPassword(fmanager: ApplicationUserManager): Boolean;
begin
  exit fmanager.HasPassword(User.Identity.GetUserId());
end;

method ManagePassword.Page_Load(sender: Object; e: EventArgs);
begin
  if not IsPostBack then begin
    //  Determine the sections to render
    if HasPassword(manager) then begin
      changePasswordHolder.Visible := true;
    end
    else begin
      setPassword.Visible := true;
      changePasswordHolder.Visible := false;
    end;
    //  Render success message
    var message := Request.QueryString['m'];
    if message <> nil then begin
      //  Strip the query string from action
      Form.Action := ResolveUrl('~/Account/Manage');
    end;
  end;
end;

method ManagePassword.ChangePassword_Click(sender: Object; e: EventArgs);
begin
  if IsValid then begin
    var &result: IdentityResult := manager.ChangePassword(User.Identity.GetUserId(), CurrentPassword.Text, NewPassword.Text);
    if &result.Succeeded then begin
      IdentityHelper.SignIn(manager, fuser, false);
      Response.Redirect('~/Account/Manage?m=ChangePwdSuccess');
    end
    else begin
      AddErrors(&result);
    end;
  end;
end;

method ManagePassword.SetPassword_Click(sender: Object; e: EventArgs);
begin
  if IsValid then begin
    //  Create the local login info and link the local account to the user
    var &result: IdentityResult := manager.AddPassword(User.Identity.GetUserId(), password.Text);
    if &result.Succeeded then begin
      Response.Redirect('~/Account/Manage?m=SetPwdSuccess');
    end
    else begin
      AddErrors(&result);
    end;
  end;
end;

method ManagePassword.AddErrors(&result: IdentityResult);
begin
  for each error in &result.Errors do begin
    ModelState.AddModelError('', error);
  end;
end;

end.
