namespace NorpaNet;

interface

uses
  System,
  System.Collections.Generic,
  System.Security.Claims,
  System.Security.Principal,
  System.Text.RegularExpressions,
  System.Web,
  System.Web.Security,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Linq,
  NorpaNet.Models,
  NorpaNet.Logic;

type
  Site = public partial class(System.Web.UI.MasterPage)
  protected 
    method Page_Load(sender : Object; e : EventArgs);
    method Page_Init(sender: Object; e: EventArgs);
    method master_Page_PreLoad(sender: Object; e: EventArgs);
    method Unnamed_LoggingOut(sender: Object; e: LoginCancelEventArgs);
    method Page_PreRender(sender: Object; e: EventArgs);    
    method Render(writer: HtmlTextWriter);override;
   private
    var _antiXsrfTokenValue: String;
    class const AntiXsrfTokenKey: String = '__AntiXsrfToken';
    class const AntiXsrfUserNameKey: String = '__AntiXsrfUserName';
    class var Pattern: Regex := new Regex('^\s+', RegexOptions.Multiline or RegexOptions.Compiled); readonly;
    class var REGEX_BETWEEN_TAGS: Regex := new Regex('>\s+<', RegexOptions.Compiled);
    class var REGEX_LINE_BREAKS: Regex := new Regex('\n\s+', RegexOptions.Compiled);
  public
    property html : System.Web.UI.HtmlControls.HtmlElement read htmlControl write htmlControl;
 
  end;

implementation

uses 
  System.IO,
  System.Text,
  NorpaNet.Components,
  NorpaNet.Helper;

method Site.Page_Load(sender : Object; e : EventArgs);
begin

end;

method Site.Page_Init(sender: Object; e: EventArgs);
begin

  //  The code below helps to protect against XSRF attacks
  var requestCookie := Request.Cookies[AntiXsrfTokenKey];
  var requestCookieGuidValue: Guid;
  if (requestCookie <> nil) and Guid.TryParse(requestCookie.Value, out requestCookieGuidValue) then begin
    //  Use the Anti-XSRF token from the cookie
    _antiXsrfTokenValue := requestCookie.Value;
    Page.ViewStateUserKey := _antiXsrfTokenValue;
  end
  else begin
    //  Generate a new Anti-XSRF token and save to the cookie
    _antiXsrfTokenValue := Guid.NewGuid().ToString('N');
    Page.ViewStateUserKey := _antiXsrfTokenValue;
    var responseCookie := new HttpCookie(AntiXsrfTokenKey);
    responseCookie.Value := _antiXsrfTokenValue;
    responseCookie.HttpOnly := true;

    if FormsAuthentication.RequireSSL and Request.IsSecureConnection then begin
      responseCookie.Secure := true;
    end;
    Response.Cookies.&Set(responseCookie);
  end;
 // Page.PreLoad += master_Page_PreLoad;//(nil,nil);
end;

method Site.master_Page_PreLoad(sender: Object; e: EventArgs);
begin
  if not IsPostBack then begin
    //  Set Anti-XSRF token
    ViewState[AntiXsrfTokenKey] := Page.ViewStateUserKey;
    ViewState[AntiXsrfUserNameKey] := Context.User.Identity.Name;
  end
  else begin
    //  Validate the Anti-XSRF token
    if (String(ViewState[AntiXsrfTokenKey]) <> _antiXsrfTokenValue) or (String(ViewState[AntiXsrfUserNameKey]) <> (Context.User.Identity.Name)) then    //  ?? String.Empty))
    begin
      raise new InvalidOperationException('Validation of Anti-XSRF token failed.');
    end;
  end;
end;



method Site.Unnamed_LoggingOut(sender: Object; e: LoginCancelEventArgs);
begin
  Context.GetOwinContext().Authentication.SignOut();
end;


method Site.Page_PreRender(sender: Object; e: EventArgs);
begin
//  using usersShoppingCart: ShoppingCartActions := new ShoppingCartActions() do
//  begin
//    var cartStr: String := String.Format('Cart ({0})', usersShoppingCart.GetCount());
//    cartCount.InnerText := cartStr;
//  end;
end;

method Site.Render(writer: HtmlTextWriter);
begin
  var sb: StringBuilder := new StringBuilder();
  var sw: StringWriter := new StringWriter(sb);
  var ht: HtmlTextWriter := new HtmlTextWriter(sw);
  inherited Render(ht);
  var html: String := sb.ToString();    
  html := html.Replace('<title>'#13#10#9,'<title>').Replace(#13#10'</title>','</title>');
  html := REGEX_BETWEEN_TAGS.Replace(html, '><');
  html := REGEX_LINE_BREAKS.Replace(html, String.Empty);
  //The remove the value and it id from the view status this next line
  // html := Regex.Replace(html, '<input[^>]*id="(__VIEWSTATE)"[^>]*>', '<input type="hidden" name="__VIEWSTATE" value=""/>', RegexOptions.IgnoreCase);
  //To completely remove the view state use the line below
  // html = Regex.Replace(html, "<input[^>]*id=\"(__VIEWSTATE)\"[^>]*>", "", RegexOptions.IgnoreCase);
  writer.Write(html);
  sb := nil;
  html := nil;
  ht.Dispose();
  sw.Dispose()
end;

end.
