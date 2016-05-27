namespace NorpaNet.Business;

interface

uses
  System,
  System.Collections.Generic,
  System.Text;


type
  SmtpSettings = public class
  public
    constructor ;

  private
    var     _user                  : System.String  := System.String.Empty;
    var     _password              : System.String  := System.String.Empty;
    var     _server                : System.String  := System.String.Empty;
    var     _port                  : System.Int32   := 25;
    var     _requiresAuthentication: System.Boolean := false;
    var     _useSsl                : System.Boolean := false;
    var     _preferredEncoding     : System.String  := System.String.Empty;
    var     _addBulkMailHeader     : System.Boolean := false;

  public
    property User: System.String read _user write _user;

    property Password: System.String read _password write _password;

    property Server: System.String read _server write _server;

    property Port: System.Int32 read _port write _port;

    property RequiresAuthentication: System.Boolean read _requiresAuthentication write _requiresAuthentication;

    property UseSsl: System.Boolean read _useSsl write _useSsl;

    property PreferredEncoding: System.String read _preferredEncoding write _preferredEncoding;

    property AddBulkMailHeader: System.Boolean read _addBulkMailHeader write _addBulkMailHeader;

    property IsValid: System.Boolean read get_IsValid;
    method get_IsValid: System.Boolean;


  end;


implementation

uses 
  NorpaNet;


constructor SmtpSettings;
begin
_user                   :=  WebConfigSettings.SMTPuser;                
_password               := WebConfigSettings.SMTPpassword;
_server                 := WebConfigSettings.SMTPserver;
_port                   := WebConfigSettings.SMTPport; 
_requiresAuthentication := WebConfigSettings.SMTPrequiresAuthentication;
_useSsl                 := WebConfigSettings.SMTPuseSsl;
_preferredEncoding      := WebConfigSettings.SMTPpreferredEncoding;

end;

method SmtpSettings.get_IsValid: System.Boolean; begin
  if _server.Length = 0 then begin
    exit false
  end;

  if _requiresAuthentication then begin
    if User.Length = 0 then begin
      exit false
    end;
    if _password.Length = 0 then begin
      exit false
    end
  end;

  exit true
end;

end.

