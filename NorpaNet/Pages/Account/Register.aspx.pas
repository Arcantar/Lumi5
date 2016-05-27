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
  NorpaNet,
  NorpaNet.Helper,
  NorpaNet.Models;

type
  &Register = public partial class(Page)
  private
    var manager  := CacheHelper.RetrieveManager(Context);
  protected
    method CreateUser_Click(sender: Object; e: EventArgs);
  end;

implementation

method &Register.CreateUser_Click(sender: Object; e: EventArgs);
begin
  var user := new ApplicationUser;
  user.UserName := Email.Text;
  user.Email := Email.Text;
  var fresult: IdentityResult := manager.&Create(user, Password.Text);
  if fresult.Succeeded then begin
    //  For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
     var code :String := manager.GenerateEmailConfirmationToken(user.Id);
     var callbackUrl:String  := IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
     manager.SendEmail(user.Id, 'Confirm your account', 'Please confirm your account by clicking <a href="' + callbackUrl + '">here</a>.');
    IdentityHelper.SignIn(manager, user,  false);
    using usersShoppingCart: NorpaNet.Logic.ShoppingCartActions := new NorpaNet.Logic.ShoppingCartActions() do
    begin
      var cartId: String := usersShoppingCart.GetCartId();
      usersShoppingCart.MigrateCart(cartId, user.Id);
    end;
    IdentityHelper.RedirectToReturnUrl(Request.QueryString['ReturnUrl'], Response);
  end
  else begin
    ErrorMessage.Text := fresult.Errors.FirstOrDefault();
  end;
end;

end.
