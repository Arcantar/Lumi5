namespace NorpaNet;

interface


uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.Routing,
  System.Web.UI,
  System.Web.UI.WebControls,
  Microsoft.AspNet.FriendlyUrls.Resolvers;


type
  ViewSwitcher = public partial class(System.Web.UI.UserControl)
  protected
    property CurrentView: String;
    property AlternateView: String;
    property SwitchUrl: String;
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

method ViewSwitcher.Page_Load(sender: Object; e: EventArgs);
begin
// var isMobile := WebFormsFriendlyUrlResolver.IsMobileView(new HttpContextWrapper(Context));
// CurrentView := if isMobile then 'Mobile' else 'Desktop';
// AlternateView := if isMobile then 'Desktop' else 'Mobile';
// var switchViewRouteName := 'AspNet.FriendlyUrls.SwitchView';
// var switchViewRoute:= RouteTable.Routes[switchViewRouteName];
// if switchViewRoute = nil then begin
//   //  Friendly URLs is not enabled or the name of the switch view route is out of sync
//   self.Visible := false;
//   exit;
// end;
//
// var furl := self.GetRouteUrl(switchViewRouteName, new routevaluedictionary{ view = AlternateView, __FriendlyUrls_SwitchViews = true }); //boxon ici voir doc??!!
// furl := furl+"?ReturnUrl=" + HttpUtility.UrlEncode(Request.RawUrl);
// SwitchUrl := furl;
//var url: &var := GetRouteUrl(switchViewRouteName, new routevaluedictionary(AlternateView, true));

end;

end.




