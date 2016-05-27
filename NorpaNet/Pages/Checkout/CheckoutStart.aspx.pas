namespace NorpaNet.Checkout;

interface


uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls, 
  NorpaNet.Logic;


type
  CheckoutStart = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

method CheckoutStart.Page_Load(sender: Object; e: EventArgs);
begin
  var payPalCaller: NVPAPICaller := new NVPAPICaller();
  var retMsg: String := '';
  var token: String := '';
  if Session['payment_amt'] <> nil then begin
    var amt: String := Session['payment_amt'].ToString();
    var ret: Boolean := payPalCaller.ShortcutExpressCheckout(amt, var token, var retMsg);
    if ret then begin
      Session['token'] := token;
      Response.Redirect(retMsg);
    end
    else begin
      Response.Redirect('CheckoutError.aspx?' + retMsg);
    end;
  end
  else begin
    Response.Redirect('CheckoutError.aspx?ErrorCode=AmtMissing');
  end;
end;

end.
