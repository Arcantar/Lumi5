namespace NorpaNet.Logic;

interface


uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin,
  Owin,
  NorpaNet.Helper,
  NorpaNet.Models;

type
  ShoppingCartUpdates = public record
  public
    var ProductId: Integer;
    var PurchaseQuantity: Integer;
    var RemoveItem: Boolean;
  end;

type
  ShoppingCartActions = public class(IDisposable)

  private
   var fuser    := CacheHelper.RetrieveUser(HttpContext.Current.User.Identity.GetUserId, HttpContext.Current);
   var _db: ProductContext := new ProductContext();
  protected
  public
   class const CartSessionKey: String = 'CartId';
   property ShoppingCartId: String;
   method AddToCart(id: Integer);
   method dispose;
   method GetCartId: String;
   method GetCartItems: List<NorpaNet.Data.Business.cartitem>;
   method GetTotal: Double;
   method GetCart(context: HttpContext): ShoppingCartActions; 
   method UpdateShoppingCartDatabase(cartId: String; CartItemUpdates: array of ShoppingCartUpdates);
   method RemoveItem(removeCartID: String; removeProductID: Integer);
   method UpdateItem(updateCartID: String; updateProductID: Integer; quantity: Integer);
   method EmptyCart;
   method GetCount: Integer;
   method MigrateCart(cartId: String; userName: String);
  end;

implementation

uses 
  NorpaNet;

method ShoppingCartActions.AddToCart(id: Integer);
begin
  //  Retrieve the product from the database.
  ShoppingCartId := GetCartId();
      try

        var fguid :=new Guid(ShoppingCartId);
        var myItem := _db.ShoppingCartItems.update_cartitem(fguid ,id , 1);
    except
      on exp: Exception do
      begin
        raise new Exception('ERROR: Unable to add to Cart Item - ' + exp.Message.ToString(), exp);
      end;
    end;
end;

method ShoppingCartActions.dispose;
begin

end;

method ShoppingCartActions.GetCartId: String;
begin
   if HttpContext.Current.Session[CartSessionKey] = nil then begin
    if not String.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name) then begin
      if fuser <> nil then
        HttpContext.Current.Session[CartSessionKey] := fuser.Id
      else begin
        HttpContext.Current.GetOwinContext.Authentication.SignOut;
        var tempCartId: Guid := Guid.NewGuid();
        HttpContext.Current.Session[CartSessionKey] := tempCartId.ToString();
      end;

    end
    else begin
      //  Generate a new random GUID using System.Guid class.
      var tempCartId: Guid := Guid.NewGuid();
      HttpContext.Current.Session[CartSessionKey] := tempCartId.ToString();
    end;
  end;
  exit HttpContext.Current.Session[CartSessionKey].ToString();
end;

method ShoppingCartActions.GetCartItems: List<NorpaNet.Data.Business.cartitem>;
begin
  ShoppingCartId := GetCartId();
  exit NorpaNet.Data.Business.cartitem.select_cartitems_Itemid_to_list(new Guid(ShoppingCartId))  ;
end;

method ShoppingCartActions.GetTotal: Double;
begin
  ShoppingCartId := GetCartId();
  // Multiply product price by quantity of that product to get   
  // the current price for each of those products in the cart.  
  // Sum all product price totals to get the cart total. 
  var total : Double := _db.ShoppingCartItems.SumCart(new Guid(ShoppingCartId));

  exit total ;
end;

method ShoppingCartActions.GetCart(context: HttpContext): ShoppingCartActions;
begin
  using cart := new ShoppingCartActions() do
  begin
    cart.ShoppingCartId := cart.GetCartId();
    exit cart;
  end;
end;

method ShoppingCartActions.UpdateShoppingCartDatabase(cartId: String; CartItemUpdates: array of ShoppingCartUpdates);
begin
  using db := new NorpaNet.Models.ProductContext() do
  begin
    try
      var CartItemCount: Integer := CartItemUpdates.Count-1;
      var myCart: List<NorpaNet.Data.Business.cartitem> := GetCartItems();
      for each cartItem in myCart do begin
        //  Iterate through all rows within shopping cart list
        for i: Integer := 0 to CartItemCount do begin
          if cartItem.Product.Productid = CartItemUpdates[i].ProductId then begin
            if (CartItemUpdates[i].PurchaseQuantity < 1) or (CartItemUpdates[i].RemoveItem = true) then begin
              RemoveItem(cartId, cartItem.Productid);
            end
            else begin
              UpdateItem(cartId, cartItem.Productid, CartItemUpdates[i].PurchaseQuantity);
            end;
          end;
        end;;
      end;
    except
      on exp: Exception do
      begin
        raise new Exception('ERROR: Unable to Update Cart Database - ' + exp.Message.ToString(), exp);
      end;
    end;
  end;
end;
method ShoppingCartActions.RemoveItem(removeCartID: String; removeProductID: Integer);
begin
    try
       var myItem := _db.ShoppingCartItems.delete_productID_from_cart(new Guid(removeCartID),removeProductID);
    except
      on exp: Exception do
      begin
        raise new Exception('ERROR: Unable to Remove Cart Item - ' + exp.Message.ToString(), exp);
      end;
    end;
end;

method ShoppingCartActions.UpdateItem(updateCartID: String; updateProductID: Integer; quantity: Integer);
begin
    try
        var myItem := _db.ShoppingCartItems.update_cartitem(new Guid(updateCartID) ,updateProductID , quantity);
    except
      on exp: Exception do
      begin
        raise new Exception('ERROR: Unable to Update Cart Item - ' + exp.Message.ToString(), exp);
      end;
    end;
end;

method ShoppingCartActions.EmptyCart;
begin
  ShoppingCartId := GetCartId();
  try
    var myItem := _db.ShoppingCartItems.delete_cart(new Guid(ShoppingCartId));
  except
    on exp: Exception do
    begin
      raise new Exception('ERROR: Unable to delete Cart  - ' + exp.Message.ToString(), exp);
    end;
  end;

end;
method ShoppingCartActions.GetCount: Integer;
begin
  ShoppingCartId := GetCartId();
  // Get the count of each item in the cart and sum them up  
  var count : Integer := 0;
  try
    count := _db.ShoppingCartItems.count_cart(new Guid(ShoppingCartId));
  except
    on exp: Exception do
    begin
      raise new Exception('ERROR: Unable to count Cart  - ' + exp.Message.ToString(), exp);
    end;
  end;
  // Return 0 if all entries are null         
  exit count ;
end;

method ShoppingCartActions.MigrateCart(cartId: String; userName: String);
begin
  try
  var item := _db.ShoppingCartItems.MigrateCart(new Guid(cartId), new Guid(userName));
  except
    on exp: Exception do
    begin
      raise new Exception('ERROR: Unable to migrate Cart  - ' + exp.Message.ToString(), exp);
    end;
  end;
  HttpContext.Current.Session[CartSessionKey] := userName;

end;


end.








