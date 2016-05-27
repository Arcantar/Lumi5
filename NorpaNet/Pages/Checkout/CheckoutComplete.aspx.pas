namespace NorpaNet.Checkout;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  NorpaNet.Logic,
  NorpaNet.Models;

type
  CheckoutComplete = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method Continue_Click(sender: Object; e: EventArgs);
  end;

implementation

method CheckoutComplete.Page_Load(sender: Object; e: EventArgs);
begin
  if not IsPostBack then begin
    //  Verify user has completed the checkout process.
    if String(Session['userCheckoutCompleted']) <> 'true' then begin
      Session['userCheckoutCompleted'] := String.&Empty;
      Response.Redirect('CheckoutError.aspx?' + 'Desc=Unvalidated%20Checkout.');
    end;
    var payPalCaller: NVPAPICaller := new NVPAPICaller();
    var retMsg: String := '';
    var token: String := '';
    var finalPaymentAmount: String := '';
    var PayerID: String := '';
    var decoder: NVPCodec := new NVPCodec();
    token := Session['token'].ToString();
    PayerID := Session['payerId'].ToString();
    finalPaymentAmount := Session['payment_amt'].ToString();
    var ret: Boolean := payPalCaller.DoCheckoutPayment(finalPaymentAmount, token, PayerID, var decoder, var retMsg);
    if ret then begin
      //  Retrieve PayPal confirmation value.
      var PaymentConfirmation: String := decoder['PAYMENTINFO_0_TRANSACTIONID'].ToString();
      TransactionId.Text := PaymentConfirmation;
      var _db: ProductContext := new ProductContext();
      //  Get the current order id.
      var currentOrderId: Integer := -1;
      if Session['currentOrderId'] <> String.&Empty then begin
        currentOrderId := Convert.ToInt32(Session['currentOrderID']);
      end;
      var myCurrentOrder: NorpaNet.Data.Business.orders;
      if currentOrderId >= 0 then begin
        //  Get the order based on order id.
        myCurrentOrder := NorpaNet.Data.Business.orders.select_orders_Orderid_to_list(currentOrderId);
        //  Update the order to reflect payment has been completed.
        myCurrentOrder.Paymenttransactionid := PaymentConfirmation;
        //  Save to DB.
        myCurrentOrder.SaveChange;
      end;
      //  Clear shopping cart.
      using  usersShoppingCart: NorpaNet.Logic.ShoppingCartActions := new NorpaNet.Logic.ShoppingCartActions() do
      begin
        usersShoppingCart.EmptyCart();
      end;
      //  Clear order id.
      Session['currentOrderId'] := String.&Empty;
    end
    else begin
      Response.Redirect('CheckoutError.aspx?' + retMsg);
    end;
  end;
end;

method CheckoutComplete.Continue_Click(sender: Object; e: EventArgs);
begin
  Response.Redirect('~/Default.aspx');
end;

end.
