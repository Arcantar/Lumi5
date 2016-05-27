namespace NorpaNet.Components;


interface

uses
  System,
  System.Data,
  System.Text,
  System.Web,
  NorpaNet;



type
  UrlRewriter = public class(IHttpModule)
  private
    
  public
    method Init(app: HttpApplication);



    method Dispose;

  protected
    method UrlRewriter_BeginRequest(sender: System.Object; e: EventArgs);

  private
    class method RewriteUrl(app: HttpApplication);

/// <summary>
/// note the expected targetUrl and returned url are not fully qualified, but relative without a /
/// </summary>
/// <param name="targetUrl"></param>
/// <returns></returns>
    class method GetRedirectUrl(targetUrl: System.String): System.String;

    class method Do301Redirect(app: HttpApplication; newUrl: System.String);





  end;


implementation


method UrlRewriter.Init(app: HttpApplication);
begin
  app.BeginRequest += new EventHandler(self.UrlRewriter_BeginRequest)
end;


method UrlRewriter.Dispose;
begin
end;

method UrlRewriter.UrlRewriter_BeginRequest(sender: System.Object; e: EventArgs);
begin
  if sender = nil then    exit;
  var app: HttpApplication := HttpApplication(sender);
 RewriteUrl(app);
 (*
  var app: HttpApplication := HttpApplication(sender);

  //if ((app.Request.Path.EndsWith('ScriptResource.axd',StringComparison.InvariantCultureIgnoreCase)) or  (app.Request.Path.EndsWith('WebResource.axd',StringComparison.InvariantCultureIgnoreCase))) then
  //  exit;

  if not WebConfigSettings.UseUrlReWritingForStaticFiles then begin

    if WebUtils.IsRequestForStaticFile(app.Request.Path) then begin
      exit
    end;

    if ((((app.Request.Path.EndsWith('csshandler.ashx', StringComparison.InvariantCultureIgnoreCase))) or ((app.Request.Path.EndsWith('CaptchaImage.ashx', StringComparison.InvariantCultureIgnoreCase)))) or ((app.Request.Path.EndsWith('/Data/', StringComparison.InvariantCultureIgnoreCase)))) or ((app.Request.Path.StartsWith('/Data/', StringComparison.InvariantCultureIgnoreCase))) then begin
      exit
    end

  end;

  if WebConfigSettings.UseUrlReWriting then begin
    try
      RewriteUrl(app)
    
    except      on ex: InvalidOperationException do begin
        
      end;
      on ex: System.Data.Common.DbException do begin
        
      end;
      on ex: Exception do begin

      end;
    end
  end

*)
end;

class method UrlRewriter.RewriteUrl(app: HttpApplication);
begin
  if app = nil then    exit;

  var requestPath: System.String := app.Request.Path;
  var requestQuery: System.String := app.Request.QueryString.ToString;
  if requestPath = '/' then exit;

  requestPath := requestPath.Replace('+',' ').Trim;

  if requestPath.Contains('/Admin/') then begin
  var pathToUse   : String := system.String.Empty;
  var querystring : String := System.String.Empty;
   // if requestPath.IndexOf('?')>0 then begin
       pathToUse   := requestPath.Replace('/Admin/','~/Pages/Admin/'); 
       querystring := requestQuery;
  app.Context.Items['norpaNetDidRewriteUrl'] := true;
  app.Context.RewritePath(pathToUse, System.String.Empty, querystring, false);
  end;

  if requestPath.Contains('/Account/') then begin
  var pathToUse   : String := system.String.Empty;
  var querystring : String := System.String.Empty;
       pathToUse   := requestPath.Replace('/Account/','~/Pages/Account/');
       querystring := requestQuery;
  app.Context.Items['norpaNetDidRewriteUrl'] := true;
  app.Context.RewritePath(pathToUse, System.String.Empty, querystring, false);
  end;

  if requestPath.Contains('/Checkout/') then begin
  var pathToUse   : String := system.String.Empty;
  var querystring : String := System.String.Empty;
       pathToUse   := requestPath.Replace('/Checkout/','~/Pages/Checkout/');
       querystring := requestQuery;
  app.Context.Items['norpaNetDidRewriteUrl'] := true;
  app.Context.RewritePath(pathToUse, System.String.Empty, querystring, false);
  end;


  (*
 
  if requestPath.Contains('/in/nyt/') then begin
    var innyt : String := requestPath.Remove(0,8);
    innyt := innyt.Remove(innyt.IndexOf('/'));
    var farray := innyt.Split('~');
    
    var pathToUse : String :='~/Blog/ViewPost.aspx';
    var querystring : String := 'pageid=' + farray[0] + '&ItemID=' + farray[2] + '&mid=' + farray[1];
    app.Context.Items['norpaNetDidRewriteUrl'] := true;
    app.Context.RewritePath(pathToUse, System.String.Empty, querystring, false);
    exit;
  end;

  if requestPath.Contains('/in/cat/') then begin
    var innyt : String := requestPath.Remove(0,8);
    innyt := innyt.Remove(innyt.IndexOf('/'));
    var farray := innyt.Split('~');
    
    var pathToUse : String :='~/Blog/ViewCategory.aspx';
    var querystring : String := 'pageid=' + farray[0] + '&cat=' + farray[2] + '&mid=' + farray[1];
    app.Context.Items['norpaNetDidRewriteUrl'] := true;
    app.Context.RewritePath(pathToUse, System.String.Empty, querystring, false);
    exit;
  end;

  if requestPath.Contains('/hae/') then begin
    var haePos : System.Int32 := requestPath.IndexOf('/hae/');
    var pathToUse : System.String := '~/rm/'+requestPath.Substring(1,haePos)+'Search.aspx';
    var QueryString : System.String := system.String.Empty;
    var tmpquery : System.String := requestPath.Substring(haePos+5,requestPath.Length-(haePos+5));
    haePos:= tmpquery.IndexOf('/');
    if haePos > 0 then begin
    var queryq : System.String := HttpUtility.UrlEncodeUnicode(tmpquery.Substring(0,haePos));    
    //var queryq : System.String := tmpquery.Substring(0,haePos);
      QueryString := 'q='+ queryq + tmpquery.Substring(haePos,tmpquery.Length-(haePos));//21 11 2015  .ReplaceFirst('/','&pagenumber=') ; 
    end else 
      //QueryString := 'q='+  tmpquery;    
      QueryString := 'q='+ HttpUtility.UrlEncodeUnicode(tmpquery);    
    haePos:= QueryString.IndexOf('/');
    if haePos > 0 then begin
      var dep : String := QueryString.Substring(0,haePos);
      var fin : String := QueryString.Substring(haePos+1,QueryString.Length-(haePos+1));
      var words: array of String := fin.Split('/');
      var i : Int32 := 0;
      for each s in words do begin
        if (i mod 2) = 0 then
          dep := dep+'&'+words[i] 
        else
          dep := dep+'='+HttpUtility.UrlEncodeUnicode(words[i]);
        inc(i);
        end;


*)

  (*  repeat
     QueryString := QueryString.ReplaceFirst('/','&') ;
     QueryString := QueryString.ReplaceFirst('/','=') ;   
     haePos:= QueryString.IndexOf('/');
    until haePos = -1;
*)
 


(* QueryString := dep;
    end;
    app.Context.Items['norpaNetDidRewriteUrl'] := true;
    app.Context.RewritePath(pathToUse, System.String.Empty, QueryString, false);
    exit;

  end;


  var useFolderForSiteDetection: System.Boolean := WebConfigSettings.UseFoldersInsteadOfHostnamesForMultipleSites;

  var virtualFolderName: System.String;
  if useFolderForSiteDetection then begin
    virtualFolderName := VirtualFolderEvaluator.VirtualFolderName()
  end
  else begin
    virtualFolderName := System.String.Empty
  end;

  var setClientFilePath: System.Boolean := true;


  if ((useFolderForSiteDetection)) and ((virtualFolderName.Length > 0)) then begin
    setClientFilePath := false;

// requesting root of folderbased site like /folder1/
// don't re-write it
    if requestPath.EndsWith(virtualFolderName + '/') then begin
      exit
    end
  end;



// Remove extended information after path, such as for Web services 
// or bogus /default.aspx/default.aspx
  var pathInfo: System.String := app.Request.PathInfo;
  if pathInfo <> System.String.Empty then begin
    requestPath := requestPath.Substring(0, requestPath.Length - pathInfo.Length)
  end;

// 2006-01-25 : David Neal : Updated URL checking, Fixes for sites where mojoPortal 
// is running at the root and for bogus default document URLs
// Get the relative target URL without the application root
  var appRoot: System.String := WebUtils.GetApplicationRoot();

  if requestPath.Length = appRoot.Length then begin
    exit
  end;

  var targetUrl: System.String := requestPath.Substring(appRoot.Length + 1);
//if (targetUrl.Length == 0) return;
  if StringHelper.IsCaseInsensitiveMatch(targetUrl, 'default.aspx') then    exit;

  if useFolderForSiteDetection then begin
    if targetUrl.StartsWith(virtualFolderName + '/') then begin
// 2009-03-01 Kris reported a bug where folder site using /er for the folder
// was making an incorrect targetUrl 
// this url from an edit link in feed manager http://localhost/er/FeedManager/FeedEdit.aspx?mid=54&pageid=34
// was getting changed to http://localhost/er/FeedManagFeedEdit.aspx?mid=54&pageid=34 causig a 404
// caused by this commented line
//targetUrl = targetUrl.Replace(virtualFolderName + "/", string.Empty);
//fixed by changing to this
      targetUrl := targetUrl.Remove(0, virtualFolderName.Length + 1)
    end

  end;


  if not WebConfigSettings.Disable301Redirector then begin
    try
// check if the requested url is supposed to redirect
      var redirectUrl: System.String := System.String.Empty;

// false by default, but option to do this requested by Romaric Fabre
      if WebConfigSettings.IncludeParametersIn301RedirectLookup then begin
        redirectUrl := GetRedirectUrl(targetUrl + '?' + app.Request.QueryString.ToString())
      end;

      if redirectUrl.Length = 0 then begin
        redirectUrl := GetRedirectUrl(targetUrl)
      end;

      if redirectUrl.Length > 0 then begin
         targetUrl := redirectUrl;
         //  03 07 2014 plus de 301 :-)
        //Do301Redirect(app, redirectUrl);
        //exit
      end
    
    except      on ex: NullReferenceException do begin
      end;
    end
  end;


  var friendlyUrl: FriendlyUrl := nil;
  var siteSettings: SiteSettings := CacheHelper.GetCurrentSiteSettings();
//this will happen on a new installation
  if siteSettings = nil then begin
    exit
  end;

  if ((useFolderForSiteDetection)) and ((virtualFolderName.Length > 0)) then begin

//int siteID = SiteSettings.GetSiteIDFromFolderName(virtualFolderName);
    friendlyUrl := new friendlyUrl(siteSettings.SiteId, targetUrl)
  end
  else begin
    if siteSettings.DefaultFriendlyUrlPattern = siteSettings.FriendlyUrlPattern.PageName then begin
//when using extensionless urls we consistently store them without a trailing slash
      if targetUrl.EndsWith('/') then begin

        targetUrl := targetUrl.Substring(0, targetUrl.Length - 1);
        setClientFilePath := false
      end
    end;

    if WebConfigSettings.AlwaysUrlEncode then begin
      friendlyUrl := new friendlyUrl(WebUtils.GetHostName(), HttpUtility.UrlEncode(targetUrl));

//in case existing pages are not url encoded since this setting was added 2009-11-15, try again without encoding

      if not friendlyUrl.FoundFriendlyUrl then begin
        if WebConfigSettings.RetryUnencodedOnUrlNotFound then begin
          friendlyUrl := new friendlyUrl(WebUtils.GetHostName(), targetUrl)
        end
      end
    end

    else begin
      friendlyUrl := new friendlyUrl(WebUtils.GetHostName(), targetUrl)
    end
  end;

  if ((friendlyUrl = nil)) or ((not friendlyUrl.FoundFriendlyUrl)) then begin
    if (((useFolderForSiteDetection)) and ((virtualFolderName.Length > 0))) and ((requestPath.Contains(virtualFolderName + '/'))) then begin
      SiteUtils.TrackUrlRewrite();

//2009-03-01 same bug as above
//string pathToUse = requestPath.Replace(virtualFolderName + "/", string.Empty);
      var pathToUse: System.String := requestPath.Remove(0, virtualFolderName.Length + 1);

// this is a flag that can be used to detect if the url was already rewritten if you need to run a custom url rewriter after this one
// you should only rewrite urls that were not rewritten by mojoPortal url rewriter
      app.Context.Items['norpaNetDidRewriteUrl'] := true;

// added 2012-06-08
//http://stackoverflow.com/questions/353541/iis7-rewritepath-and-iis-log-files
//http://stackoverflow.com/questions/4061227/any-way-to-detect-classic-and-integrated-application-pool-in-code
//http://msdn.microsoft.com/en-us/library/system.web.httpruntime.usingintegratedpipeline%28v=vs.90%29.aspx
      if ((SiteUtils.UsingIntegratedPipeline())) and ((WebConfigSettings.UseTransferRequestForUrlReWriting)) then begin
        var q: System.String := app.Request.QueryString.ToString();
        if ((q.Length > 0)) and ((not q.StartsWith('?'))) then begin
          q := '?' + q
        end;

        app.Context.Server.TransferRequest(pathToUse + q, true)
      end

      else begin
//previous logic
        app.Context.RewritePath(pathToUse, System.String.Empty, app.Request.QueryString.ToString(), setClientFilePath)
      end
    end

    else begin
      if ((targetUrl.Length > 1)) and ((not targetUrl.Contains('.'))) then begin
// this is a flag that will be detected in our pagenotfoundhttpmodule
// so we can handle 404 for extensionless urls
        app.Context.Items['UrlNotFound'] := true
      end;
      exit
    end
  end

;

  var queryStringToUse: System.String := System.String.Empty;
  var realPageName: System.String := System.String.Empty;


  if friendlyUrl.RealUrl.IndexOf('?') > 0 then begin
    realPageName := friendlyUrl.RealUrl.Substring(0, friendlyUrl.RealUrl.IndexOf('?'));
    queryStringToUse := friendlyUrl.RealUrl.Substring(friendlyUrl.RealUrl.IndexOf('?') + 1)
  end
  // Added by Christian Fredh 10/30/2006
else begin
    realPageName := friendlyUrl.RealUrl
  end;

  if debugLog then begin
    log.Debug('Rewriting URL to ' + friendlyUrl.RealUrl)
  end;


  if ((realPageName <> nil)) and ((not String.IsNullOrEmpty(realPageName))) then begin
    if queryStringToUse = nil then begin
      queryStringToUse := String.Empty
    end;

    var originalQueryString: StringBuilder := new StringBuilder();

// get any additional params besides pageid
    var separator: System.String := System.String.Empty;
    for each key: System.String in app.Request.QueryString.AllKeys do begin
      if key <> 'pageid' then begin
//originalQueryString.Append( separator + key + "="
//    + app.Request.QueryString.Get(key));

//https://www.norpa.com/Forums/Thread.aspx?pageid=5&t=11718~1#post48771

        originalQueryString.Append(separator + key + '=' + HttpUtility.UrlEncode(app.Request.QueryString.Get(key), Encoding.UTF8));

        if separator.Length = 0 then          separator := '&'
      end

    end;

    if originalQueryString.Length > 0 then begin
      if queryStringToUse.Length = 0 then begin
        queryStringToUse := originalQueryString.ToString()
      end
      else begin
        queryStringToUse := queryStringToUse + '&' + originalQueryString.ToString()
      end
    end;

    SiteUtils.TrackUrlRewrite();
//log.Info("re-writing to " + realPageName);

// this is a flag that can be used to detect if the url was already rewritten if you need to run a custom url rewriter after this one
// you should only rewrite urls that were not rewritten by mojoPortal url rewriter
    app.Context.Items['norpaNetDidRewriteUrl'] := true;

// added 2012-06-08
//http://stackoverflow.com/questions/353541/iis7-rewritepath-and-iis-log-files
//http://stackoverflow.com/questions/4061227/any-way-to-detect-classic-and-integrated-application-pool-in-code
//http://msdn.microsoft.com/en-us/library/system.web.httpruntime.usingintegratedpipeline%28v=vs.90%29.aspx
    if ((SiteUtils.UsingIntegratedPipeline())) and ((WebConfigSettings.UseTransferRequestForUrlReWriting)) then begin
      if ((queryStringToUse.Length > 0)) and ((not queryStringToUse.StartsWith('?'))) then begin
        queryStringToUse := '?' + queryStringToUse
      end;
      app.Context.Server.TransferRequest(realPageName + queryStringToUse, true)
    end

    else begin
//previous logic
      app.Context.RewritePath(realPageName, System.String.Empty, queryStringToUse, setClientFilePath)
    end
  end

*)
end;



class method UrlRewriter.GetRedirectUrl(targetUrl: System.String): System.String;
begin
//lookup if this url is to be redirected, if found return the new url
  var newUrl: System.String := System.String.Empty;

(*
 var cachekey: System.String := 'RedirectURL_'+targetUrl.Trim;
  var expiration: DateTime := DateTime.Now.AddSeconds(WebConfigSettings.SiteSettingsCacheDurationInSeconds);

 newUrl := norpa.Web.caching.CacheManager.Cache.Get<String>(cachekey, expiration, () -> begin
        var fnewUrl: String := System.String.Empty;
        var siteSettings: SiteSettings := CacheHelper.GetCurrentSiteSettings();
        using reader: IDataReader := RedirectInfo.GetBySiteAndUrl(siteSettings.SiteId, targetUrl) do begin
          if reader.Read() then begin
            fnewUrl := reader['NewUrl'].ToString()
          end
        end;
       exit fnewUrl
       end,false);
*)
    exit newUrl;
end;

class method UrlRewriter.Do301Redirect(app: HttpApplication; newUrl: System.String);
begin
//add web.config options to allow setting a cache timeout?
//https://www.norpa.com/Forums/Thread.aspx?thread=9947&mid=34&pageid=5&ItemID=5&pagenumber=1#post41411
(*
  var siteRoot: System.String := SiteUtils.GetNavigationSiteRoot();

// false by default
  if WebConfigSettings.AllowExternal301Redirects then begin
    if not newUrl.StartsWith('http') then begin
      newUrl := siteRoot + '/' + newUrl
    end
  end

  else begin
    newUrl := siteRoot + '/' + newUrl
  end;

  app.Context.Response.Status := '301 Moved Permanently';
  if WebConfigSettings.PassQueryStringFor301Redirects then begin
    app.Context.Response.AddHeader('Location', newUrl + app.Request.Url.Query)
  end
  else begin
    app.Context.Response.AddHeader('Location', newUrl)
  end;

  if WebConfigSettings.DisableCacheFor301Redirects then begin
    app.Context.Response.Cache.SetNoStore();
    app.Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    app.Context.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches)
  end

  else if WebConfigSettings.SetExplicitCacheFor301Redirects then begin
    var daysToCache: System.Int32 := WebConfigSettings.CacheDurationInDaysFor301Redirects;
    if daysToCache > 365 then begin
      daysToCache := 365
    end;
    var cachDuration: TimeSpan := TimeSpan.FromDays(daysToCache);
    app.Context.Response.Cache.SetCacheability(HttpCacheability.Public);
    app.Context.Response.Cache.SetExpires(DateTime.Now.Add(cachDuration));
    app.Context.Response.Cache.SetMaxAge(cachDuration)
  end

*)
end;


end.

