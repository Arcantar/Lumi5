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
  Confirm = public partial class(Page)
  private    
    var manager  := CacheHelper.RetrieveManager(Context);
  protected
    property StatusMessage: String;
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

uses 
  NorpaNet;

method Confirm.Page_Load(sender: Object; e: EventArgs);
begin
  var code: String := IdentityHelper.GetCodeFromRequest(Request);
  var userId: String := IdentityHelper.GetUserIdFromRequest(Request);
  if (code <> nil) and (userId <> nil) then begin
    var &result := manager.ConfirmEmail(userId, code);
    if &result.Succeeded then begin
      successPanel.Visible := true;
      exit;
    end;
  end;
  successPanel.Visible := false;
  errorPanel.Visible := true;
end;

end.
