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
  CheckoutReview = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method CheckoutConfirm_Click(sender: Object; e: EventArgs);
  end;

implementation

method CheckoutReview.Page_Load(sender: Object; e: EventArgs);
begin
  if not IsPostBack then begin
    var payPalCaller: NVPAPICaller := new NVPAPICaller();
    var retMsg: String := '';
    var token: String := '';
    var PayerID: String := '';
    var decoder: NVPCodec := new NVPCodec();
    token := Session['token'].ToString();
    var ret: Boolean := payPalCaller.GetCheckoutDetails(token, var PayerID, var decoder, var retMsg);
    if ret then begin
      Session['payerId'] := PayerID;
      var myOrder := new NorpaNet.Data.Business.orders;
      myOrder.Orderdate := Convert.ToDateTime(decoder['TIMESTAMP'].ToString());
      myOrder.Username := User.Identity.Name;
      myOrder.Firstname := decoder['FIRSTNAME'].ToString();
      myOrder.Lastname := decoder['LASTNAME'].ToString();
      myOrder.Address := decoder['SHIPTOSTREET'].ToString();
      myOrder.City := decoder['SHIPTOCITY'].ToString();
      myOrder.State := decoder['SHIPTOSTATE'].ToString();
      myOrder.Postalcode := decoder['SHIPTOZIP'].ToString();
      myOrder.Country := decoder['SHIPTOCOUNTRYCODE'].ToString();
      myOrder.Email := decoder['EMAIL'].ToString();
      myOrder.Total := Convert.ToDecimal(decoder['AMT'].ToString.Replace('.',',')); //todo force paypal decimal!
      // Verify total payment amount as set on CheckoutStart.aspx.
      var tmpamt:= decoder["AMT"].ToString();
      try          
        var paymentAmountOnCheckout: Decimal:= Convert.ToDecimal(Session["payment_amt"].ToString());
        var paymentAmoutFromPayPal: Decimal := Convert.ToDecimal(decoder["AMT"].ToString.Replace('.',','));
        if (paymentAmountOnCheckout <> paymentAmoutFromPayPal) then
          Response.Redirect("CheckoutError.aspx?" + "Desc=Amount%20total%20mismatch.");          
      except 
        Response.Redirect("CheckoutError.aspx?" + "Desc=Amount%20total%20mismatch.");
      end;
      //  Add order to DB.
      myOrder.SaveChange;
      //  Get the shopping cart items and process them.
      using usersShoppingCart: ShoppingCartActions := new ShoppingCartActions() do begin
        var myOrderList: List<NorpaNet.Data.Business.cartitem> := usersShoppingCart.GetCartItems();
        //  Add OrderDetail information to the DB for each product purchased.
        for each orderdet in myOrderList do begin
          //  Create a new OrderDetail object.
          var myOrderDetail := new NorpaNet.Data.Business.orderdetails;
          myOrderDetail.Orderid := myOrder.Orderid;
          myOrderDetail.Username := User.Identity.Name;
          myOrderDetail.Productid := orderdet.Productid;
          myOrderDetail.Quantity := orderdet.Quantity;
          myOrderDetail.Unitprice := orderdet.Product.Unitprice;
          //  Add OrderDetail to DB.
          myOrderDetail.SaveChange;
        end;
        //  Set OrderId.
        Session['currentOrderId'] := myOrder.Orderid;
        //  Display Order information.
        var orderList: List<NorpaNet.Data.Business.orders> := new List<NorpaNet.Data.Business.orders>();
        orderList.Add(myOrder);
        ShipInfo.DataSource := orderList;
        ShipInfo.DataBind();
        //  Display OrderDetails.
        OrderItemList.DataSource := myOrderList;
        OrderItemList.DataBind();
      end; 
    end;
  end;
end;

method CheckoutReview.CheckoutConfirm_Click(sender: Object; e: EventArgs);
begin
  Session['userCheckoutCompleted'] := 'true';
  Response.Redirect('~/Checkout/CheckoutComplete.aspx');
end;

end.


