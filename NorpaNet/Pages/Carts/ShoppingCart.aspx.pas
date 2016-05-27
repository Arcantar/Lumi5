namespace NorpaNet;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  NorpaNet.Models,
  NorpaNet.Logic,
  System.Collections.Specialized,
  System.Collections,
  System.Web.ModelBinding;

type
  ShoppingCart = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  public
    method GetShoppingCartItems: List<NorpaNet.Data.Business.cartitem>;
    method UpdateCartItems: List<NorpaNet.Data.Business.cartitem>;
    class method GetValues(row: GridViewRow): IOrderedDictionary;
  protected
    method UpdateBtn_Click(sender: Object; e: EventArgs);
    method CheckoutBtn_Click(sender: Object; e: ImageClickEventArgs);
  end;

implementation

method ShoppingCart.Page_Load(sender: Object; e: EventArgs);
begin
  using usersShoppingCart: ShoppingCartActions := new ShoppingCartActions() do
  begin
    var cartTotal: Double := 0;
    cartTotal := usersShoppingCart.GetTotal();
    if cartTotal > 0 then begin
      //  Display Total.
      lblTotal.Text := String.Format('{0:c}', cartTotal);
    end
    else begin
      LabelTotalText.Text := '';
      lblTotal.Text := '';
      ShoppingCartTitle.InnerText := 'Shopping Cart is Empty';
      UpdateBtn.Visible := false;
      CheckoutImageBtn.Visible := false;
    end;
  end;
end;

method ShoppingCart.GetShoppingCartItems: List<NorpaNet.Data.Business.cartitem>;
begin
  var actions: ShoppingCartActions := new ShoppingCartActions();
  exit actions.GetCartItems();
end;

method ShoppingCart.UpdateCartItems: List<NorpaNet.Data.Business.cartitem>;
begin
  using usersShoppingCart: ShoppingCartActions := new ShoppingCartActions() do
  begin
    var cartId: String := usersShoppingCart.GetCartId();
    var cartUpdates: array of ShoppingCartUpdates := new ShoppingCartUpdates[CartList.Rows.Count];
    for i: Integer := 0 to CartList.Rows.Count-1 do begin
      var rowValues: IOrderedDictionary := new OrderedDictionary();
      rowValues := GetValues(CartList.Rows[i]);
      cartUpdates[i].ProductId := Convert.ToInt32(rowValues['ProductID']);
      var cbRemove: CheckBox := new CheckBox();
      cbRemove := CheckBox(CartList.Rows[i].FindControl('Remove'));
      cartUpdates[i].RemoveItem := cbRemove.Checked;
      var quantityTextBox: TextBox := new TextBox();
      quantityTextBox := TextBox(CartList.Rows[i].FindControl('PurchaseQuantity'));
      cartUpdates[i].PurchaseQuantity := Convert.ToInt16(quantityTextBox.Text.ToString());
    end;
    usersShoppingCart.UpdateShoppingCartDatabase(cartId, cartUpdates);
    CartList.DataBind();
    lblTotal.Text := String.Format('{0:c}', usersShoppingCart.GetTotal());
    exit usersShoppingCart.GetCartItems();
  end;
end;

class method ShoppingCart.GetValues(row: GridViewRow): IOrderedDictionary;
begin
  var values: IOrderedDictionary := new OrderedDictionary();
  for each cell: DataControlFieldCell in row.Cells do begin
    if cell.Visible then begin
      //  Extract values from the cell.
      cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
    end;
  end;
  exit values;
end;

method ShoppingCart.UpdateBtn_Click(sender: Object; e: EventArgs);
begin
  UpdateCartItems();
end;

method ShoppingCart.CheckoutBtn_Click(sender: Object; e: ImageClickEventArgs);
begin
  using usersShoppingCart: ShoppingCartActions := new ShoppingCartActions() do
  begin
    Session['payment_amt'] := usersShoppingCart.GetTotal();
  end;
  Response.Redirect('Checkout/CheckoutStart.aspx');
end;

end.
