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
  ManageLogins = public partial class(System.Web.UI.Page)
  protected
    property SuccessMessage: String;
    property CanRemoveExternalLogins: Boolean;
  private
    var manager  := CacheHelper.RetrieveManager(Context);
    var fuser    := CacheHelper.RetrieveUser(User.Identity.GetUserId, Context);
    method HasPassword(manager: ApplicationUserManager): Boolean;
  protected
    method Page_Load(sender: Object; e: EventArgs);
  public
    method GetLogins: IEnumerable<UserLoginInfo>;
    method RemoveLogin(loginProvider: String; providerKey: String);
  end;

implementation

method ManageLogins.HasPassword(manager: ApplicationUserManager): Boolean;
begin
  exit manager.HasPassword(User.Identity.GetUserId());
end;

method ManageLogins.Page_Load(sender: Object; e: EventArgs);
begin
  CanRemoveExternalLogins := manager.GetLogins(User.Identity.GetUserId()).Count() > 1;
  SuccessMessage := String.&Empty;
  successMessageolder.Visible := not String.IsNullOrEmpty(SuccessMessage);
end;

method ManageLogins.GetLogins: IEnumerable<UserLoginInfo>;
begin
  var accounts := manager.GetLogins(User.Identity.GetUserId());
  CanRemoveExternalLogins := (accounts.Count() > 1) or HasPassword(manager);
  exit accounts;
end;

method ManageLogins.RemoveLogin(loginProvider: String; providerKey: String);
begin
  var &result := manager.RemoveLogin(User.Identity.GetUserId(), new UserLoginInfo(loginProvider, providerKey));
  var msg: String := String.&Empty;
  if &result.Succeeded then begin
    IdentityHelper.SignIn(manager, fuser, false);
    msg := '?m=RemoveLoginSuccess';
  end;
  Response.Redirect('~/Account/ManageLogins' + msg);
end;

end.
