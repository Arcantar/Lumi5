namespace NorpaNet;

interface

uses
  System,
  System.Security.Claims,
  System.Threading.Tasks,
  Microsoft.AspNet.Identity,
  AspNet.Identity.Firebird3,
  Microsoft.AspNet.Identity.Owin,
  Microsoft.Owin,
  Microsoft.Owin.Security,
  NorpaNet.Models;

type
  EmailService = public class(IIdentityMessageService)
  public
    method SendAsync(message: IdentityMessage): Task;
  end;

  SmsService = public class(IIdentityMessageService)
  public
    method SendAsync(message: IdentityMessage): Task;
  end;

  ApplicationUserManager = public class( UserManager<ApplicationUser>)
  public
    constructor(store :UserStore<ApplicationUser>);
    //constructor(fdatabase: FBDatabase);
    class method &&Create(options: IdentityFactoryOptions<ApplicationUserManager>; context: IOwinContext): ApplicationUserManager;
  end;

  ApplicationSignInManager = public class(SignInManager<ApplicationUser, String>)
  public
    constructor(userManager: ApplicationUserManager; authenticationManager: IAuthenticationManager);
    method CreateUserIdentityAsync(user: ApplicationUser): Task<ClaimsIdentity>;//  override; //virtual;
    class method &Create(options: IdentityFactoryOptions<ApplicationSignInManager>; context: IOwinContext): ApplicationSignInManager; 
  end;

implementation

uses 
  NorpaNet.Business;

method EmailService.SendAsync(message: IdentityMessage): Task;
begin
  //  Plug in your email service here to send an email.
  var fSmtpSetting := new SmtpSettings;
  Email.SendEmail(fSmtpSetting,'taru@lumi5.com', message.Destination ,'','taru@lumi5.com',message.Subject ,message.Body,true,Email.PriorityNormal);
  exit Task.FromResult(0);
end;

method SmsService.SendAsync(message: IdentityMessage): Task;
begin
  //  Plug in your SMS service here to send a text message.
  exit Task.FromResult(0);
end;

constructor ApplicationUserManager(store :UserStore<ApplicationUser>);
begin

end;

class method ApplicationUserManager.&&Create(options: IdentityFactoryOptions<ApplicationUserManager>; context: IOwinContext): ApplicationUserManager;
begin
 // var fmanager:ApplicationUserManager := ()-> begin 
                                                                      var manager := new ApplicationUserManager(new UserStore<ApplicationUser>(context.Get<ApplicationDbContext> as FBDatabase));
          
                                                                      //  Configure validation logic for usernames
                                                                      var uValidator :=new UserValidator<ApplicationUser>(manager);
                                                                      uValidator.AllowOnlyAlphanumericUserNames := false;
                                                                      uValidator.RequireUniqueEmail := true;
                                                                      manager.UserValidator :=uValidator;
  
                                                                      //  Configure validation logic for passwords
                                                                      var PasswordValidator := new PasswordValidator;
                                                                      PasswordValidator.RequiredLength := WebConfigSettings.PasswordValidatorRequiredLength;
                                                                      PasswordValidator.RequireNonLetterOrDigit := WebConfigSettings.PasswordValidatorRequireNonLetterOrDigit;
                                                                      PasswordValidator.RequireDigit := WebConfigSettings.PasswordValidatorRequireDigit;
                                                                      PasswordValidator.RequireLowercase := WebConfigSettings.PasswordValidatorRequireLowercase;
                                                                      PasswordValidator.RequireUppercase := WebConfigSettings.PasswordValidatorRequireUppercase;
                                                                      manager.PasswordValidator :=  PasswordValidator;
  
                                                                      //  Register two factor authentication providers. This application uses Phone and Emails as a step of receiving a code for verifying the user
                                                                      //  You can write your own provider and plug it in here.
                                                                      var uPhoneProvider := new PhoneNumberTokenProvider<ApplicationUser>;
                                                                      uPhoneProvider.MessageFormat := 'Your security code is {0}';
                                                                      manager.RegisterTwoFactorProvider('Phone Code', uPhoneProvider);

                                                                      var uEmailProvider := new EmailTokenProvider<ApplicationUser>;
                                                                      uEmailProvider.Subject := 'Security Code';
                                                                      uEmailProvider.BodyFormat := 'Your security code is {0}';
                                                                      manager.RegisterTwoFactorProvider('Email Code', uEmailProvider);
  
                                                                      //  Configure user lockout defaults
                                                                      manager.UserLockoutEnabledByDefault := true;
                                                                      manager.DefaultAccountLockoutTimeSpan := TimeSpan.FromMinutes(5);
                                                                      manager.MaxFailedAccessAttemptsBeforeLockout := 5;
                                                                      manager.EmailService := new EmailService();
  manager.SmsService := new SmsService();
  
  var dataProtectionProvider := options.DataProtectionProvider;
  if dataProtectionProvider <> nil then begin
    manager.UserTokenProvider := new DataProtectorTokenProvider<ApplicationUser>(dataProtectionProvider.&Create('ASP.NET Identity'));
  end;
  exit manager;
//end;
//exit fmanager;
(*
UserManagerFactory := () ->
  begin
    var userManager: &var := new ApplicationUserManager(new UserStore<IdentityUser>(new SecurityDbContext()));
    var validator: &var := new UserValidator<IdentityUser>(userManager, false);
    userManager.UserValidator := validator;
    exit userManager;
  end;
*)

end;

constructor ApplicationSignInManager(userManager: ApplicationUserManager; authenticationManager: IAuthenticationManager);
begin
end;

method ApplicationSignInManager.CreateUserIdentityAsync(user: ApplicationUser): Task<ClaimsIdentity>;
begin
  exit user.GenerateUserIdentityAsync(ApplicationUserManager(UserManager));
end;

class method ApplicationSignInManager.&Create(options: IdentityFactoryOptions<ApplicationSignInManager>; context: IOwinContext): ApplicationSignInManager;
begin
  exit new ApplicationSignInManager(context.GetUserManager<ApplicationUserManager>(), context.Authentication);
end;

end.
