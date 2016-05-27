namespace NorpaNet.Helper;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.Web;

type
  WebUtilsHelper = public class
  private
    class method GetHost(protocol: System.String): System.String;
    // Returns hostname[:port] to use when constructing the site root URL.
    class method DetermineHost(protocol: System.String): System.String;
    class method DetermineSiteRoot: System.String;
    class method CalculateApplicationRoot: System.String;
  protected
  public
    class method GetSiteRoot: System.String;
    class method GetRelativeSiteRoot: System.String;
    class method GetHostRoot: System.String;
    class method GetApplicationRoot: System.String;
  end;

implementation

class method WebUtilsHelper.GetHostRoot: System.String;
begin
  var protocol: System.String := iif(HttpContext.Current.Request.IsSecureConnection, 'https', 'http');
  var host: System.String := GetHost(protocol);
  exit protocol + '://' + host
end;

class method WebUtilsHelper.GetHost(protocol: System.String): System.String;
begin
  if HttpContext.Current = nil then    exit String.Empty;
  if protocol = nil then    protocol := System.String.Empty;

  var host: System.String := System.String(HttpContext.Current.Items['host' + protocol]);
  if host = nil then begin
    host := DetermineHost(protocol);
    if host <> nil then      HttpContext.Current.Items['host' + protocol] := host
  end;
  exit host
end;

class method WebUtilsHelper.DetermineHost(protocol: System.String): System.String;
begin
  var serverName: System.String := HttpContext.Current.Request.ServerVariables['SERVER_NAME'];
  var serverPort: System.String := HttpContext.Current.Request.ServerVariables['SERVER_PORT'];
  // Most proxies add an X-Forwarded-Host header which contains the original Host header
  // including any non-default port.
  var forwardedHosts: System.String := HttpContext.Current.Request.Headers['X-Forwarded-Host'];
  if forwardedHosts <> nil then begin
    // If the request passed thru multiple proxies, they will be separated by commas.
    // We only care about the first one.
    var forwardedHost: System.String := forwardedHosts.Split(',')[0];
    var serverAndPort: array of System.String := forwardedHost.Split(':');
    serverName := serverAndPort[0];
    serverPort := nil;
    if serverAndPort.Length > 1 then begin
      serverPort := serverAndPort[1];
    end
  end;
end;

class method WebUtilsHelper.GetSiteRoot: System.String;
begin
  if HttpContext.Current = nil then    exit System.String.Empty;
  var siteRoot: System.String := System.String(HttpContext.Current.Items['siteRoot']);
  if siteRoot = nil then begin
    siteRoot := DetermineSiteRoot();
    if siteRoot <> nil then      HttpContext.Current.Items['siteRoot'] := siteRoot
  end;
  exit siteRoot
end;

class method WebUtilsHelper.GetRelativeSiteRoot: System.String;
begin
  if HttpContext.Current = nil then    exit System.String.Empty;
  var siteRoot: System.String := System.String(HttpContext.Current.Items['relativesiteRoot']);
  if siteRoot = nil then begin
    siteRoot := GetApplicationRoot();
    if siteRoot <> nil then      HttpContext.Current.Items['relativesiteRoot'] := siteRoot
  end;
  exit siteRoot
end;

class method WebUtilsHelper.GetApplicationRoot: System.String;
begin
  if HttpContext.Current = nil then    exit String.Empty;
  var applicationRoot: System.String := System.String(HttpContext.Current.Items['applicationRoot']);
  if applicationRoot = nil then begin
    applicationRoot := CalculateApplicationRoot();
    if applicationRoot <> nil then      HttpContext.Current.Items['applicationRoot'] := applicationRoot
  end;
  exit applicationRoot
end;

class method WebUtilsHelper.CalculateApplicationRoot: System.String;
begin
  if HttpContext.Current.Request.ApplicationPath.Length = 1 then begin
    exit System.String.Empty
  end
  else begin
    exit HttpContext.Current.Request.ApplicationPath
  end
end;

class method WebUtilsHelper.DetermineSiteRoot: System.String;
begin
  var protocol: System.String := iif(HttpContext.Current.Request.IsSecureConnection, 'https', 'http');
  var host: System.String := GetHost(protocol);
  exit protocol + '://' + host + GetApplicationRoot()
end;

end.
