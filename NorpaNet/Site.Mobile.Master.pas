namespace NorpaNet;

interface

uses 
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls;

type
  Site_Mobile = public partial class(System.Web.UI.MasterPage)
  protected 
    method Page_Load(sender : Object; e : EventArgs);
  end;

implementation

method Site_Mobile.Page_Load(sender : Object; e : EventArgs);
begin
  
end;

end.
