namespace NorpaNet;

interface

uses
  System,
  AspNet.Identity.Firebird3,
  Microsoft.AspNet.Identity,
  Owin,
  Microsoft.Owin,
  Microsoft.Owin.Security.Cookies,
  Microsoft.Owin.Security.DataProtection,
  Microsoft.Owin.Security.Google,
  Microsoft.AspNet.Identity.Owin,
  NorpaNet.Models;



type
  Startup = public partial class
  public
    //  For more information on configuring authentication, please visit http://go.microsoft.com/fwlink/?LinkId=301883
    method ConfigureAuth(app: IAppBuilder);
  end;

implementation

uses 
  Microsoft.Owin.Security.Twitter,
  RemObjects.Elements.Cirrus.Values;

method Startup.ConfigureAuth(app: IAppBuilder);
begin
 // //  Configure the db context, user manager and signin manager to use a single instance per request
  app.CreatePerOwinContext(()-> ApplicationDbContext.&Create());
  //var fuserstrore : UserStore<ApplicationUser> ;//:= new UserStore<ApplicationUser>(context.Get<ApplicationDbContext> as FBDatabase);
    
  app.CreatePerOwinContext<ApplicationUserManager>((options, context) -> ApplicationUserManager.Create(options, context));
  app.CreatePerOwinContext<ApplicationSignInManager>((options, context)-> ApplicationSignInManager.&&Create(options, context));
 // //  Enable the application to use a cookie to store information for the signed in user
 // //  and to use a cookie to temporarily store information about a user logging in with a third party login provider
 // //  Configure the sign in cookie
  var AuthenticationType := DefaultAuthenticationTypes.ApplicationCookie;
  var CookieAuthenticationProvider := new CookieAuthenticationProvider;
  CookieAuthenticationProvider.OnValidateIdentity := SecurityStampValidator.OnValidateIdentity<ApplicationUserManager, ApplicationUser>( 
           TimeSpan.FromMinutes(300),  
           (manager, user) -> user.GenerateUserIdentityAsync(manager)
           );
 var CookieAuthenticationOptions := new CookieAuthenticationOptions(AuthenticationType := AuthenticationType, Provider := CookieAuthenticationProvider, LoginPath := new PathString('/Account/Login'));
  app.UseCookieAuthentication( CookieAuthenticationOptions);



  //  Use a cookie to temporarily store information about a user logging in with a third party login provider
  app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);
  //  Enables the application to temporarily store user information when they are verifying the second factor in the two-factor authentication process.
  app.UseTwoFactorSignInCookie(DefaultAuthenticationTypes.TwoFactorCookie, TimeSpan.FromMinutes(5));
  //  Enables the application to remember the second login verification factor such as phone or email.
  //  Once you check this option, your second step of verification during the login process will be remembered on the device where you logged in from.
  //  This is similar to the RememberMe option when you log in.
  app.UseTwoFactorRememberBrowserCookie(DefaultAuthenticationTypes.TwoFactorRememberBrowserCookie);
  if WebConfigSettings.ActiveMicrosoftLogin then begin
    var clientId : String := WebConfigSettings.MicrosoftclientId;
    var clientSecret : String := WebConfigSettings.MicrosoftclientSecret;
    app.UseMicrosoftAccountAuthentication( clientId, clientSecret );
 end;

  if WebConfigSettings.ActiveTwitterLogin then begin
    var farray : array of String:= ['A5EF0B11CEC04103A34A659048B21CE0572D7D47',
                                    '0D445C165344C1827E1D20AB25F40163D8BE79A5',
                                    '7FD365A7C2DDECBBF03009F34339FA02AF333133',
                                    '39A55D933676616E73A761DFA16A7E59CDE66FAD',
                                    'add53f6680fe66e383cbac3e60922e3b4c412bed',
                                    '4eb6d578499b1ccf5f581ead56be3d9b6744a5e5',
                                    '5168FF90AF0207753CCCD9656462A212B859723B',
                                    'B13EC36903F8BF4701D498261A0802EF63642BC3'];
    var BackchannelCertificateValidator := new Microsoft.Owin.Security.CertificateSubjectKeyIdentifierValidator(farray);
    var Options := new TwitterAuthenticationOptions;
    Options.ConsumerKey    := WebConfigSettings.TwitterConsumerKey;
    Options.ConsumerSecret := WebConfigSettings.TwitterConsumerSecret;
    Options.BackchannelCertificateValidator := BackchannelCertificateValidator;
    app.UseTwitterAuthentication( Options);  
  end;
  if WebConfigSettings.ActiveFacebookLogin then begin
    var appId : String := WebConfigSettings.FacebookLoginAppId;
    var appSecret : String := WebConfigSettings.FacebookLoginAppSecret;
    app.UseFacebookAuthentication(appId , appSecret);
  end;
  if WebConfigSettings.ActiveGoogleLogin then begin
    app.UseGoogleAuthentication(new GoogleOAuth2AuthenticationOptions(ClientId := WebConfigSettings.GoogleclientId, ClientSecret  := WebConfigSettings.GoogleclientSecret));
  end;
end;

end.
