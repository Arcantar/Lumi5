namespace NorpaNet;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls, 
  NorpaNet.Components;

type
  Contact = public partial class(DefaultBasePage)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

uses 
  System.Globalization;

method Contact.Page_Load(sender: Object; e: EventArgs);
begin
   if (self is DefaultBasePage) then begin 
  var p: DefaultBasePage := DefaultBasePage(self);
  p.PageLang := CultureInfo.CurrentCulture.TwoLetterISOLanguageName;
 end;

end;

end.
