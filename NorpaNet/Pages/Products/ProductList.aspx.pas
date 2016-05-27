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
  System.Web.ModelBinding,
  System.Web.Routing;

type
  ProductList = public partial class(System.Web.UI.Page)
  private
    var flistproduct : list<NorpaNet.Data.Business.products>;
    method formatListe;
  protected
    method Page_Load(sender: Object; e: EventArgs);
  public
    method GetProducts([QueryString("id")] categoryId  :nullable Int64; [RouteData]categoryName:nullable String): list<NorpaNet.Data.Business.products>;
  end;

implementation

uses 
  System.Text,
  NorpaNet.Helper;

method ProductList.Page_Load(sender: Object; e: EventArgs);
begin
  if Page.RouteData.Values.Count = 0 then
  flistproduct := CacheHelper.GetProductList(nil,nil)
else begin
  flistproduct := CacheHelper.GetProductList(nil,Page.RouteData.Values['categoryName'].ToString);
  CategoryMenu.Selected := Page.RouteData.Values['categoryName'].ToString;
end;
  formatListe;
end;

method ProductList.GetProducts(categoryId:nullable Int64; categoryName:nullable String): list<NorpaNet.Data.Business.products>;
begin
exit CacheHelper.GetProductList(categoryId,categoryName);
end;

method ProductList.formatListe;
begin
  var controlTXT: StringBuilder := new StringBuilder;
  controlTXT.Append('<div class="blockproductlist">');
  controlTXT.Append('<ul id="productlist">');
  for each fprod in flistproduct do begin
    controlTXT.Append('<li><table><tr><td>');
    controlTXT.Append('<a href="/Product/'+fprod.Productname+'">');
    controlTXT.Append('<img src="/Images/Catalog/Images/Thumbs/'+fprod.Imagepath+'" height="auto" border="1" alt="'+fprod.Productname+'" />');
    controlTXT.Append('</a></td></tr><tr><td>'); 
    controlTXT.Append('<a href="/Product/'+fprod.Productname+'">'+fprod.ProductnameMini+'</a>');
    controlTXT.Append('<br />');
 //   if fprod.Unitprice > 0 then
 //   controlTXT.Append('<span>Price: '+String.Format("{0:c}", fprod.Unitprice)+'</span>');
 //   controlTXT.Append('<br />');
    controlTXT.Append('</td></tr><tr><td>&nbsp;</td></tr></table></li>');
  end;
  controlTXT.Append('</ul> ');
  controlTXT.Append('</div>');
  LitProduct.Text := controlTXT.ToString;


end;

end.
