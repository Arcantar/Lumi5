namespace NorpaNet;

interface

uses
  System,
  System.Collections.Generic,
  System.Web,
  System.Web.Routing,
  Microsoft.AspNet.FriendlyUrls;

type
  RouteConfig = public static class
  public
    class method RegisterRoutes(routes: RouteCollection);
  end;

implementation

class method RouteConfig.RegisterRoutes(routes: RouteCollection);
begin
  var settings := new FriendlyUrlSettings();
  settings.AutoRedirectMode := RedirectMode.Permanent;
  routes.EnableFriendlyUrls(settings);
end;

end.
