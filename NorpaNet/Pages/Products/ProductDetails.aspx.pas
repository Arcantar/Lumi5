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
  System.Web.ModelBinding;

type
  ProductDetails = public class(System.Web.UI.Page)
  private
    
  var fresult :list<NorpaNet.Data.Business.products>;
  protected
    var productDetail: System.Web.UI.WebControls.FormView;
    var LitEdit : System.Web.UI.WebControls.Literal;
    var LitProduct : System.Web.UI.WebControls.Literal;
    var CategoryMenu : NorpaNet.Components.Controls.MenuCategory;
    method Page_Load(sender: Object; e: EventArgs);
    method formatArticle;
  public
    method GetProduct([QueryString("ProductID")] productId: nullable Int64; [RouteData] productName: String): list<NorpaNet.Data.Business.products>;
  end;

implementation

uses 
  System.Globalization,
  System.Text,
  NorpaNet.Helper;

method ProductDetails.Page_Load(sender: Object; e: EventArgs);
begin

fresult := CacheHelper.GetProducts(nil,Page.RouteData.Values['productName'].ToString);
if not IsPostBack then
  formatArticle;


end;

method ProductDetails.GetProduct(productId: nullable Int64; productName: String): list<NorpaNet.Data.Business.products>;
begin
  fresult := CacheHelper.GetProducts(productId,productName);  
  exit fresult;
end;

method ProductDetails.formatArticle;
begin
  var fprod : NorpaNet.Data.Business.products := fresult.Select(x ->x).FirstOrDefault;
  var controlTXT: StringBuilder := new StringBuilder;
  
  controlTXT.Append('<div class="container product">');
  controlTXT.Append('    <div>');
  controlTXT.Append('        <h1 Class="center ProdTitle">'+fprod.Productname+'</h1>');
  controlTXT.Append('    </div>');
  controlTXT.Append('    <br />');
  controlTXT.Append('    <table Class="center prod_det">');
  controlTXT.Append('        <tr>');
  controlTXT.Append('            <td>');
  controlTXT.Append('                <img src="/Images/Catalog/Images/'+fprod.Imagepath+'" class="imgproduct" alt="'+fprod.Productname+'" data-darkbox="/Images/Catalog/Images/'+fprod.Imagepath+'" data-darkbox-description="'+fprod.Description+'"  />');
  controlTXT.Append('            </td>');
  controlTXT.Append('            <td>&nbsp;</td>');
  controlTXT.Append('        </tr>');
  controlTXT.Append('        <tr>');
  controlTXT.Append('            <td style="vertical-align: top; text-align: center;">');
  controlTXT.Append('                '+fprod.Description);  
  if fprod.Unitprice>0 then
  controlTXT.Append('                <span>, price:&nbsp;'+ String.Format(CultureInfo.CreateSpecificCulture("fi-FI"),"{0:c}", fprod.Unitprice) +'</span>');
  controlTXT.Append('                <br />');
  controlTXT.Append('                <br />');
  controlTXT.Append('            </td>');
  controlTXT.Append('        </tr>');
  controlTXT.Append('    </table>');  
  controlTXT.Append('</div>');

  LitProduct.Text := controlTXT.ToString;
  CategoryMenu.SelectedID := fprod.Categoryid;
  if HttpContext.Current.User.IsInRole('canEdit') then begin
    LitEdit.Visible := true;
    var lid := fprod.Productid;
    LitEdit.Text:='<div><a runat="server" id="adminLink" visible="true" href="/Admin/ProductEdit.aspx?id='+lid.ToString+'">Admin</a></div>';
  end;
end;

end.
