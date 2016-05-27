namespace NorpaNet.Business;

interface

uses
  System,
  System.Configuration,
  System.Collections.Generic,
  System.IO,
  System.Net,
  System.Net.Sockets,
  System.Net.Mail,
  System.Text,
  System.Threading,
  System.Text.RegularExpressions;


/// <summary>
/// A class for sending email.
/// </summary>
type
  Email = public static class

  public
    const     PriorityLow: System.String = 'Low';
    const     PriorityNormal: System.String = 'Normal';
    const     PriorityHigh: System.String = 'High';

  private
    const     SmtpAuthenticated: System.Int32 = 1;




  public
    class method SendEmail(smtpSettings: SmtpSettings; &from: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);


    class method SendEmail(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);

/// <summary>
/// This method uses the built in .NET classes to send mail.
/// </summary>
/// <param name="smtpSettings"></param>
/// <param name="from"></param>
/// <param name="to"></param>
/// <param name="cc"></param>
/// <param name="bcc"></param>
/// <param name="subject"></param>
/// <param name="messageBody"></param>
/// <param name="html"></param>
/// <param name="priority"></param>
    class method SendEmailNormal(smtpSettings: SmtpSettings; &from: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);

/// <summary>
/// This method uses the built in .NET classes to send mail.
/// </summary>
/// <param name="smtpSettings"></param>
/// <param name="from"></param>
/// <param name="replyTo"></param>
/// <param name="to"></param>
/// <param name="cc"></param>
/// <param name="bcc"></param>
/// <param name="subject"></param>
/// <param name="messageBody"></param>
/// <param name="html"></param>
/// <param name="priority"></param>
    class method SendEmailNormal(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);

/// <summary>
/// This method uses the built in .NET classes to send mail.
/// </summary>
/// <param name="smtpSettings"></param>
/// <param name="from"></param>
/// <param name="replyTo"></param>
/// <param name="to"></param>
/// <param name="cc"></param>
/// <param name="bcc"></param>
/// <param name="subject"></param>
/// <param name="messageBody"></param>
/// <param name="html"></param>
/// <param name="priority"></param>
/// <param name="attachmentPaths"></param>
/// <param name="attachmentNames"></param>
    class method SendEmailNormal(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachmentPaths: array of System.String; attachmentNames: array of System.String);

    class method SetMessageEncoding(smtpSettings: SmtpSettings; mail: MailMessage);

/// <summary>
/// This method uses the built in .NET classes to send mail.
/// </summary>
/// <param name="smtpSettings"></param>
/// <param name="from"></param>
/// <param name="replyTo"></param>
/// <param name="to"></param>
/// <param name="cc"></param>
/// <param name="bcc"></param>
/// <param name="subject"></param>
/// <param name="messageBody"></param>
/// <param name="html"></param>
/// <param name="priority"></param>
/// <param name="attachmentPaths"></param>
/// <param name="attachmentNames"></param>
    class method Send(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachmentPaths: array of System.String; attachmentNames: array of System.String): System.Boolean;

    class method Send(smtpSettings: SmtpSettings; &from: System.String; fromAlias: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String): System.Boolean;

/// <summary>
/// This method uses the built in .NET classes to send mail.
/// </summary>
/// <param name="smtpSettings"></param>
/// <param name="from"></param>
/// <param name="replyTo"></param>
/// <param name="to"></param>
/// <param name="cc"></param>
/// <param name="bcc"></param>
/// <param name="subject"></param>
/// <param name="messageBody"></param>
/// <param name="html"></param>
/// <param name="priority"></param>
/// <param name="attachmentPaths"></param>
/// <param name="attachmentNames"></param>
    class method Send(smtpSettings: SmtpSettings; &from: System.String; fromAlias: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachmentPaths: array of System.String; attachmentNames: array of System.String): System.Boolean;

    class method Send(smtpSettings: SmtpSettings; &from: System.String; fromAlias: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachments: List<Attachment>): System.Boolean;

  private
    class method GetGlobalBccAddress: System.String;

  public
    class method Send(smtpSettings: SmtpSettings; message: MailMessage): System.Boolean;



  private
    class method RetrySend(message: MailMessage; smtp: SmtpClient; ex: Exception): System.Boolean;

    class method RetrySend(message: MailMessage; smtp: SmtpClient; tryNumber: System.Int32): System.Boolean;

  public
    class method IsValidEmailAddressSyntax(emailAddress: System.String): System.Boolean;

  end;


implementation

uses 
  NorpaNet.Helper;


class method Email.SendEmail(smtpSettings: SmtpSettings; &from: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);
begin
  if &to = 'admin@admin.com' then begin
    exit
  end;
//demo site
  if ((ConfigurationManager.AppSettings['DisableSmtp'] <> nil)) and ((ConfigurationManager.AppSettings['DisableSmtp'] = 'true')) then begin
    exit
  end;

  if ((smtpSettings = nil)) or ((not smtpSettings.IsValid)) then begin
    exit
  end;

  SendEmailNormal(smtpSettings, &from, &to, cc, bcc, subject, messageBody, html, priority);
  exit
end;



class method Email.SendEmail(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);
begin
  if &to = 'admin@admin.com' then begin
    exit
  end;
//demo site
  if ((ConfigurationManager.AppSettings['DisableSmtp'] <> nil)) and ((ConfigurationManager.AppSettings['DisableSmtp'] = 'true')) then begin
    exit
  end;

  if ((smtpSettings = nil)) or ((not smtpSettings.IsValid)) then begin
    exit
  end;


  if replyTo.Length > 0 then begin
    SendEmailNormal(smtpSettings, &from, replyTo, &to, cc, bcc, subject, messageBody, html, priority);

    exit
  end;

  SendEmail(smtpSettings, &from, &to, cc, bcc, subject, messageBody, html, priority)
end;


class method Email.SendEmailNormal(smtpSettings: SmtpSettings; &from: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);
begin
  if &to = 'admin@admin.com' then begin
    exit
  end;
//demo site
  if ((ConfigurationManager.AppSettings['DisableSmtp'] <> nil)) and ((ConfigurationManager.AppSettings['DisableSmtp'] = 'true')) then begin
    exit
  end;

  var replyTo: System.String := System.String.Empty;
  SendEmailNormal(smtpSettings, &from, replyTo, &to, cc, bcc, subject, messageBody, html, priority)
end;


class method Email.SendEmailNormal(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String);
begin
  if &to = 'admin@admin.com' then begin
    exit
  end;
//demo site
  if ((ConfigurationManager.AppSettings['DisableSmtp'] <> nil)) and ((ConfigurationManager.AppSettings['DisableSmtp'] = 'true')) then begin
    exit
  end;

  var attachmentPaths: array of System.String := new System.String[0];
  var attachmentNames: array of System.String := new System.String[0];

  SendEmailNormal(smtpSettings, &from, replyTo, &to, cc, bcc, subject, messageBody, html, priority, attachmentPaths, attachmentNames)
end;




class method Email.SendEmailNormal(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachmentPaths: array of System.String; attachmentNames: array of System.String);
begin
  if &to = 'admin@admin.com' then begin
    exit
  end;
//demo site
  Send(smtpSettings, &from, replyTo, &to, cc, bcc, subject, messageBody, html, priority, attachmentPaths, attachmentNames)
end;


class method Email.SetMessageEncoding(smtpSettings: SmtpSettings; mail: MailMessage);
begin
//http://msdn.microsoft.com/en-us/library/system.text.encoding.aspx

  if smtpSettings.PreferredEncoding.Length > 0 then begin
    case smtpSettings.PreferredEncoding of 
      'ascii', 'us-ascii': begin
                           end;

       'utf32', 'utf-32': begin

                            mail.BodyEncoding := Encoding.UTF32;
                            mail.SubjectEncoding := Encoding.UTF32;
                          end;
      

               'unicode': begin

                            mail.BodyEncoding := Encoding.Unicode;
                            mail.SubjectEncoding := Encoding.Unicode;
                          end;

      

         'utf8', 'utf-8': begin

                            mail.BodyEncoding := Encoding.UTF8;
                            mail.SubjectEncoding := Encoding.UTF8;
                          end
            else



        try
          mail.BodyEncoding := Encoding.GetEncoding(smtpSettings.PreferredEncoding);
          mail.SubjectEncoding := Encoding.GetEncoding(smtpSettings.PreferredEncoding)
        
        except          on ex: ArgumentException do begin
          end;
        end;
    end

  end

end;


class method Email.Send(smtpSettings: SmtpSettings; &from: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachmentPaths: array of System.String; attachmentNames: array of System.String): System.Boolean;
begin
  if &to = 'admin@admin.com' then begin
    exit false
  end;
//demo site
  var fromAlias: System.String := System.String.Empty;
  exit Send(smtpSettings, &from, fromAlias, replyTo, &to, cc, bcc, subject, messageBody, html, priority, attachmentPaths, attachmentNames)
end;


class method Email.Send(smtpSettings: SmtpSettings; &from: System.String; fromAlias: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String): System.Boolean;
begin
  if &to = 'admin@admin.com' then begin
    exit false
  end;
//demo site 
  var attachmentPaths: array of System.String := new System.String[0];
  var attachmentNames: array of System.String := new System.String[0];

  exit Send(smtpSettings, &from, fromAlias, replyTo, &to, cc, bcc, subject, messageBody, html, priority, attachmentPaths, attachmentNames)
end;

class method Email.Send(smtpSettings: SmtpSettings; &from: System.String; fromAlias: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachmentPaths: array of System.String; attachmentNames: array of System.String): System.Boolean;
begin

// add attachments if there are any
  var attachments: List<Attachment> := new List<Attachment>();
  if ((attachmentPaths.Length > 0)) and ((attachmentNames.Length = attachmentPaths.Length)) then begin
    begin
      var i: System.Int32 := 0;
      while i < attachmentPaths.Length do begin begin
          if not File.Exists(attachmentPaths[i]) then begin
            continue
          end;

          var a: Attachment := new Attachment(attachmentPaths[i]);
          a.Name := attachmentNames[i];

          attachments.Add(a)
        end;
        inc(i);
      end;
    end
  end;

  exit Send(smtpSettings, &from, fromAlias, replyTo, &to, cc, bcc, subject, messageBody, html, priority, attachments)
end;



class method Email.Send(smtpSettings: SmtpSettings; &from: System.String; fromAlias: System.String; replyTo: System.String; &to: System.String; cc: System.String; bcc: System.String; subject: System.String; messageBody: System.String; html: System.Boolean; priority: System.String; attachments: List<Attachment>): System.Boolean;
begin
  if &to = 'admin@admin.com' then begin
    exit false
  end;
//demo site
  if ((ConfigurationManager.AppSettings['DisableSmtp'] <> nil)) and ((ConfigurationManager.AppSettings['DisableSmtp'] = 'true')) then begin
    exit false
  end;

  if ((smtpSettings = nil)) or ((not smtpSettings.IsValid)) then begin
    exit false
  end;

  using mail: MailMessage := new MailMessage() do begin
    SetMessageEncoding(smtpSettings, mail);


    var fromAddress: MailAddress;
    try
      if fromAlias.Length > 0 then begin
        fromAddress := new MailAddress(&from, fromAlias)
      end
      else begin
        fromAddress := new MailAddress(&from)
      end
    
    except      on ArgumentException do begin
        exit false
      end;
      on FormatException do begin
        exit false
      end;
    end;

    mail.From := fromAddress;

    var toAddresses: List<System.String> := StringHelper.SplitOnChar(&to.Replace(';', ','),',');
    for each toAddress: System.String in toAddresses do begin
      try
        var a: MailAddress := new MailAddress(toAddress);
        mail.To.Add(a)
      
      except        on ArgumentException do begin
        end;
        on FormatException do begin
        end;
      end
    end;

    if mail.To.Count = 0 then begin
      exit false
    end;

    if replyTo.Length > 0 then begin
      try
        var replyAddress: MailAddress := new MailAddress(replyTo);
        mail.ReplyTo := replyAddress
      
      except        on ArgumentException do begin
        end;
        on FormatException do begin
        end;
      end
    end;

    if cc.Length > 0 then begin
      var ccAddresses: List<System.String> := StringHelper.SplitOnChar(cc.Replace(';', ','),',');

      for each ccAddress: System.String in ccAddresses do begin
        try
          var a: MailAddress := new MailAddress(ccAddress);
          mail.CC.Add(a)
        
        except          on ArgumentException do begin
          end;
          on FormatException do begin
          end;
        end
      end
    end;

    if bcc.Length > 0 then begin
      var bccAddresses: List<System.String> := StringHelper.SplitOnChar(bcc.Replace(';', ','),',');

      for each bccAddress: System.String in bccAddresses do begin
        try
          var a: MailAddress := new MailAddress(bccAddress);
          mail.Bcc.Add(a)
        
        except          on ArgumentException do begin
          end;
          on FormatException do begin
          end;
        end
      end
    end;

    mail.Subject := StringHelper.RemoveLineBreaks(subject);

    case priority of 
      PriorityHigh: begin
                      mail.Priority := MailPriority.High;
                    end;
      
      PriorityLow: begin
                     mail.Priority := MailPriority.Low;
                   end
                   else
                      // [CaseLabel Label=[IdentifierExpression Identifier=PriorityNormal TypeArguments={}] BinaryOperatorType=None ToExpression=[NullExpression]]

                     mail.Priority := MailPriority.Normal;
    end;



    if html then begin
      mail.IsBodyHtml := true;
// this char can reportedly cause problems in some email clients so replace it if it exists
      mail.Body := messageBody.Replace(#160, '&nbsp;')
    end
    else begin
      mail.Body := messageBody
    end;

// add attachments if there are any
    if attachments <> nil then begin
      for each a: Attachment in attachments do begin
        mail.Attachments.Add(a)
      end
    end;

    if smtpSettings.AddBulkMailHeader then begin
      mail.Headers.Add('Precedence', 'bulk')
    end;


    exit Send(smtpSettings, mail)
  end



end;// end using MailMessage


class method Email.GetGlobalBccAddress: System.String;
begin
// I use this for the demo site so I get copied on every message
// so that I will know if anyone is managing to send spam from the demo site

  if ((ConfigurationManager.AppSettings['GlobalBCC'] <> nil)) and ((ConfigurationManager.AppSettings['GlobalBCC'].Length > 0)) then begin
    exit ConfigurationManager.AppSettings['GlobalBCC']
  end;

  exit System.String.Empty
end;


class method Email.Send(smtpSettings: SmtpSettings; message: MailMessage): System.Boolean;
begin
  if message.To.ToString() = 'admin@admin.com' then begin
    exit false
  end;
//demo site
  var globalBcc: System.String := GetGlobalBccAddress();
  if globalBcc.Length > 0 then begin
    var bcc: MailAddress := new MailAddress(globalBcc);
    message.Bcc.Add(bcc)
  end;

  var timeoutMilliseconds: System.Int32 := ConfigHelper.GetIntProperty('SMTPTimeoutInMilliseconds', 15000);
  var smtpClient: SmtpClient := new SmtpClient(smtpSettings.Server, smtpSettings.Port);
  smtpClient.DeliveryMethod := SmtpDeliveryMethod.Network;
  smtpClient.EnableSsl := smtpSettings.UseSsl;
  smtpClient.Timeout := timeoutMilliseconds;

  if smtpSettings.RequiresAuthentication then begin

    var smtpCredential: NetworkCredential := new NetworkCredential(smtpSettings.User, smtpSettings.Password);

    var myCache: CredentialCache := new CredentialCache();
    myCache.Add(smtpSettings.Server, smtpSettings.Port, 'LOGIN', smtpCredential);

    smtpClient.UseDefaultCredentials := false;
    smtpClient.Credentials := myCache
  end
  else begin
//aded 2010-01-22 JA
    smtpClient.UseDefaultCredentials := true
  end;


  try
    smtpClient.Send(message);

    var logEmail: System.Boolean := ConfigHelper.GetBoolProperty('LogAllEmailsWithSubject', false);

    if logEmail then begin
    end;

    exit true
  
  except    on ex: System.Net.Mail.SmtpException do begin
      exit RetrySend(message, smtpClient, ex)
    end;
    on ex: WebException do begin
      exit false
    end;
    on ex: SocketException do begin
      exit false
    end;
    on ex: InvalidOperationException do begin
      exit false
    end;
    on ex: FormatException do begin
      exit false
    end;
  end
end;


class method Email.RetrySend(message: MailMessage; smtp: SmtpClient; ex: Exception): System.Boolean;
begin
//retry
  var timesToRetry: System.Int32 := ConfigHelper.GetIntProperty('TimesToRetryOnSmtpError', 3);
  begin
    var i: System.Int32 := 1;
    while i <= timesToRetry do begin begin
      if RetrySend(message, smtp, i) then begin
        exit true
      end;
      i := i + 1;
      Thread.Sleep(1000)
    end;// 1 second sleep in case it is a temporary network issue 
    end;
  end;

// allows use of localhost as  backup 
  if ConfigurationManager.AppSettings['BackupSmtpServer'] <> nil then begin
    var backupServer: System.String := ConfigurationManager.AppSettings['BackupSmtpServer'];
    var timeoutMilliseconds: System.Int32 := ConfigHelper.GetIntProperty('SMTPTimeoutInMilliseconds', 15000);
    var backupSmtpPort: System.Int32 := ConfigHelper.GetIntProperty('BackupSmtpPort', 25);
    var smtpClient: SmtpClient := new SmtpClient(backupServer, backupSmtpPort);
    smtpClient.UseDefaultCredentials := true;

    try
      smtpClient.Send(message);
      exit true
    
    except      on System.Net.Mail.SmtpException do begin
      end;
      on WebException do begin
      end;
      on SocketException do begin
      end;
      on InvalidOperationException do begin
      end;
      on FormatException do begin
      end;
    end
  end;


  exit false
end;


class method Email.RetrySend(message: MailMessage; smtp: SmtpClient; tryNumber: System.Int32): System.Boolean;
begin
  try
    smtp.Send(message);
    exit true
  
  except    on System.Net.Mail.SmtpException do begin
    end;
    on WebException do begin
    end;
    on SocketException do begin
    end;
    on InvalidOperationException do begin
    end;
    on FormatException do begin
    end;
  end;

  exit false
end;

class method Email.IsValidEmailAddressSyntax(emailAddress: System.String): System.Boolean;
begin
  var emailPattern: Regex;
  emailPattern := new Regex("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");
 // emailPattern := new Regex(SecurityHelper.RegexEmailValidationPattern);

  var emailAddressToValidate: Match := emailPattern.Match(emailAddress);

  if emailAddressToValidate.Success then begin
    exit true
  end
  else begin
    exit false
  end
end;


end.
