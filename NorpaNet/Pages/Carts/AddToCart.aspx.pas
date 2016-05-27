namespace NorpaNet;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Diagnostics,
  NorpaNet.Logic;

type
  AddToCart = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

method AddToCart.Page_Load(sender: Object; e: EventArgs);
begin
  var rawId: String := Request.QueryString['ProductID'];
  var productId: Integer;
  if not String.IsNullOrEmpty(rawId) and Integer.TryParse(rawId, out productId) then begin
    using  usersShoppingCart: ShoppingCartActions := new ShoppingCartActions() do
    begin
      usersShoppingCart.AddToCart(Convert.ToInt32(rawId));
    end;
  end
  else begin
    Debug.Fail('ERROR : We should never get to AddToCart.aspx without a ProductId.');
    raise new Exception('ERROR : It is illegal to load AddToCart.aspx without setting a ProductId.');
  end;
  Response.Redirect('/ShoppingCart');
end;

end.
