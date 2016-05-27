namespace NorpaNet.Helper;

interface

uses
  System,
  System.Configuration,
  System.Globalization,
  System.Threading,
  System.Web,
  System.Web.Security,  
  System.Net.NetworkInformation,
  NorpaNet, 
  NorpaNet.Components, 
  NorpaNet.Helper.Cache;

type
  CultureHelperHttpModule = public class(IHttpModule)
  private 
    class var starttickcount : Int32 := System.Environment.TickCount;
    class var session_id     : String := system.String.Empty;

  public
    method Init(application: HttpApplication);


  private
    method BeginRequest(sender: System.Object; e: EventArgs);


    method Error(sender: System.Object; e: EventArgs);


    method EndRequest(sender: System.Object; e: EventArgs);




  public
    method Dispose;

  end;



implementation


method CultureHelperHttpModule.Init(application: HttpApplication);
begin
  application.Error += new EventHandler(self.Error);
  application.BeginRequest += new EventHandler(BeginRequest);
  application.EndRequest += new EventHandler(self.EndRequest)
end;

method CultureHelperHttpModule.BeginRequest(sender: System.Object; e: EventArgs);
begin
  starttickcount := System.Environment.TickCount;
  var app: HttpApplication := HttpApplication(sender);
  var gh : System.String := WebConfigSettings.GetDefaultCulture;
  if gh <> '' then begin
   var siteCulture: CultureInfo := new CultureInfo(gh);
   System.Threading.Thread.CurrentThread.CurrentCulture := siteCulture;
   System.Threading.Thread.CurrentThread.CurrentUICulture := siteCulture;
  end else
    if WebConfigSettings.UseCultureOverride then begin
     var siteCulture: CultureInfo;
     var siteUICulture: CultureInfo;
     try
      siteCulture := new CultureInfo( WebConfigSettings.GetDefaultCulture);
      siteUICulture := new CultureInfo(WebConfigSettings.GetDefaultUICulture);
    
     except      
       on InvalidOperationException do begin
        exit
       end;
       on System.Data.Common.DbException do begin
        exit
       end;
     end;

    if siteCulture.IsNeutralCulture then begin

    end
    else begin
      try
        Thread.CurrentThread.CurrentCulture := siteCulture;
        if WebConfigSettings.SetUICultureWhenSettingCulture then begin
          Thread.CurrentThread.CurrentUICulture := siteUICulture
        end;

      except        on ex: ArgumentException do begin
        end;
        on ex: NotSupportedException do begin
        end;
      end
    end
  end;



    if WebConfigSettings.UseCustomHandlingForPersianCulture then begin

      if ((CultureInfo.CurrentCulture.Name = 'fa-IR')) or ((CultureInfo.CurrentCulture.TwoLetterISOLanguageName = 'fa')) then begin
        try
          var PersianCulture: CultureInfo := CultureHelper.GetPersianCulture();
          Thread.CurrentThread.CurrentCulture := PersianCulture;
          Thread.CurrentThread.CurrentUICulture := PersianCulture
      
        except        on ex: System.Security.SecurityException do begin
        end;
        on ex: ArgumentException do begin
        end;
      end
    end
  end;


end;


method CultureHelperHttpModule.Error(sender: System.Object; e: EventArgs);
begin
end;


method CultureHelperHttpModule.EndRequest(sender: System.Object; e: EventArgs);

begin

  
  var app: HttpApplication := HttpApplication(sender);
  var NP_IPADRESSV4: System.String      := app.Request.UserHostAddress; 
  var NP_DATETIME: DateTime             := DateTime.Now; 
  var NP_METHODE: System.String         := app.Request.HttpMethod;  
  var NP_CULTURE: System.String         := CultureInfo.CurrentCulture.Name;  
  var NP_URL: System.String             := app.Request.Url.ToString();  
  var NP_USERNAME: System.String        := app.Request.ServerVariables['LOGON_USER'];  
  var NP_USERAGENT: System.String       := app.Request.UserAgent;  
  var NP_RESPONSECODE: System.String    := app.Response.StatusCode.ToString;  
  var NP_SITENAME: System.String        := WebConfigSettings.GetSiteName;  
  var NP_APPLICATIONNAME: System.String := app.Request.ApplicationPath;  
  var NP_REFFERT: System.String ;
  if app.Request.UrlReferrer <> nil then
     NP_REFFERT  := app.Request.UrlReferrer.ToString else
     NP_REFFERT  := '';
  var cachekey: System.String := 'IPV4_' + NP_IPADRESSV4;
  var expiration: DateTime := DateTime.Now.AddDays(1);
  var ipUser : IPLocation := CacheManager.Cache.Get<IPLocation>(cachekey, expiration, () -> begin
               var fipl := new IPLocation(NP_IPADRESSV4);
               exit fipl;
               end,true);
               
  var NP_RESPONSETIME: System.Int32 := System.Environment.TickCount - starttickcount;

  NorpaNet.Data.DBSystemLog.NP_LOG_I(NP_DATETIME, NP_METHODE, NP_CULTURE,NP_IPADRESSV4 ,NP_URL, NP_USERNAME ,NP_USERAGENT ,NP_RESPONSECODE ,NP_SITENAME ,NP_APPLICATIONNAME ,NP_REFFERT, NP_RESPONSETIME, session_id, ipUser.ipfrom ,ipUser.ipto ,ipUser.country_code ,ipUser.country_name ,ipUser.continent_code ,ipUser.continent_name ,ipUser.time_zone ,ipUser.region_code ,ipUser.region_name ,ipUser.owner ,ipUser.city_name , ipUser.county_name ,ipUser.latitude ,ipUser.longitude );

end;


method CultureHelperHttpModule.Dispose;
begin
end;

end.
