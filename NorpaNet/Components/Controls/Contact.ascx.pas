namespace NorpaNet.Components.Controls;

interface

uses
  System,
  System.Data,
  System.Configuration,
  System.Linq,
  System.Web,
  System.Web.Security,
  System.Web.SessionState,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.WebControls.WebParts,
  System.Web.UI.HtmlControls;

type
  Contact = public partial class(System.Web.UI.UserControl)
  protected
    method Send(sender: Object; e: EventArgs);
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

uses 
  NorpaNet.Business;

method Contact.Page_Load(sender: Object; e: EventArgs);
begin

end;

method Contact.Send(sender: Object; e: EventArgs);
begin
  if self.Page.IsValid then begin
    var fSmtpSetting := new SmtpSettings;  
    NorpaNet.Business.Email.SendEmail(fSmtpSetting,Email.Text, 'taru@lumi5.com' ,'','taru@tetrasys.eu',Subject.Text ,CKEditor.Text,true,NorpaNet.Business.Email.PriorityNormal);
    Subject.Text := '';
    CKEditor.Text := '';
    Email.Text := '';
  end;
end;

end.
