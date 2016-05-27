namespace NorpaNet.Checkout;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls;

type
  CheckoutCancel = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

method CheckoutCancel.Page_Load(sender: Object; e: EventArgs);
begin
end;

end.
