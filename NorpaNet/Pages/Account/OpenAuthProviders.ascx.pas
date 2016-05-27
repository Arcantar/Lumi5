namespace NorpaNet.Account;

interface

uses
  System,
  System.Collections.Generic,
  System.Globalization,
  System.Linq,
  System.Web,
  System.Web.UI,
  Microsoft.AspNet.Identity,
  Microsoft.Owin.Security,
  NorpaNet;

type
  OpenAuthProviders = public partial class(System.Web.UI.UserControl)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  public
    method GetProviderNames: IEnumerable<String>;
    var ReturnUrl: String;
  end;

implementation

method OpenAuthProviders.Page_Load(sender: Object; e: EventArgs);
begin
 if IsPostBack then begin
    var provider := Request.Form['provider'];
    if provider = nil then begin
      exit;
    end;
    //  Request a redirect to the external login provider
    var redirectUrl: String := ResolveUrl(String.Format(CultureInfo.InvariantCulture, '~/Account/RegisterExternalLogin?{0}={1}&returnUrl={2}', IdentityHelper.ProviderNameKey, provider, ReturnUrl));
    var properties := new AuthenticationProperties(RedirectUri := redirectUrl);
    //  Add xsrf verification when linking accounts
    if Context.User.Identity.IsAuthenticated then begin
      properties.Dictionary[IdentityHelper.XsrfKey] := Context.User.Identity.GetUserId();
    end;
    Context.GetOwinContext().Authentication.Challenge(properties, provider);
    Response.StatusCode := 401;
    Response.End();
  end;
end;

method OpenAuthProviders.GetProviderNames: IEnumerable<String>;
begin
  try
    exit Context.GetOwinContext().Authentication.GetExternalAuthenticationTypes().&Select(t -> t.AuthenticationType);
  except
    //
  end;
end;
end.
