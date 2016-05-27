namespace NorpaNet.Admin;

interface

uses
  System,
  System.Collections.Generic,
  System.Data,
  System.Configuration,
  System.Linq,
  System.Web,
  System.Web.Security,
  System.Web.SessionState,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.WebControls.WebParts,
  System.Web.UI.HtmlControls,
  System.Web.ModelBinding,
  NorpaNet.Data ;

type
  ProductEdit = public partial class(System.Web.UI.Page)
  private
    fproduct : NorpaNet.Data.Business.products;
    method formatArticle;
  protected
    method Page_Load(sender: Object; e: EventArgs);
    method UpdateProductButton_Click(sender: Object; e: EventArgs);
  public
    method GetProduct([QueryString("id")] productid  :nullable Int64; [RouteData]productName:nullable String): NorpaNet.Data.Business.products;
    method GetCategories: list<NorpaNet.Data.Business.categories>;
  
  end;

implementation

uses 
  System.Text,
  NorpaNet.Helper, 
  NorpaNet.Logic;

method ProductEdit.Page_Load(sender: Object; e: EventArgs);
begin
  if not IsPostBack then
    fproduct:=GetProduct(Convert.ToInt64( Request.QueryString['id']) , nil);
  if fproduct<> nil then begin
    TXTProductName.Text := fproduct.Productname;
    TXTProductNameMini.Text := fproduct.ProductnameMini;
    //TXTProductDescription.Text := fproduct.Description;
    CKEditor.Text := fproduct.Description;
    TXTProductPrice.Text := fproduct.Unitprice.ToString;
    TXTProductID.Text    := fproduct.Productid.ToString;
    ImageFileName.Value := fproduct.Imagepath;
    DropDownAddCategory.SelectedValue:= fproduct.Categoryid.ToString;
    formatArticle;
  end;
end;
method ProductEdit.GetProduct(productid: nullable Int64; productName: String): NorpaNet.Data.Business.products;
  begin
   if fproduct = nil then
      fproduct := CacheHelper.GetProducts(productid,productName).Select(x -> x ).FirstOrDefault;
   exit  fproduct;
  end;
method ProductEdit.GetCategories: list<NorpaNet.Data.Business.categories>;
begin
  exit CacheHelper.GetCategories;
end;
method ProductEdit.UpdateProductButton_Click(sender: Object; e: EventArgs);
begin
var fileOK: Boolean := false;
var path: String := Server.MapPath('~/Images/Catalog/Images/');


     
     if ProductImage.HasFile then begin
        var fileExtension: String := System.IO.Path.GetExtension(ProductImage.FileName).ToLower();
        var allowedExtensions: array of String:=['.gif', '.png', '.jpeg', '.jpg' ];
        for i: Integer := 0 to allowedExtensions.Length -1 do begin
          if fileExtension = allowedExtensions[i] then begin
            fileOK := true;
          end;
        end;

        if not fileOK then begin
          LabelStatus.Text := 'Unable to accept file type.';
        end;
     end;
     if fileOK then begin
       try
         //  Save to Images folder.
         ProductImage.PostedFile.SaveAs(path + ProductImage.FileName);
         //  Save to Images/Thumbs folder.
         ProductImage.PostedFile.SaveAs((path + 'Thumbs/') + ProductImage.FileName);
       except
         on ex: Exception do
         begin
           LabelStatus.Text := ex.Message;
         end;
       end;
     end; 
       //  Add product data to DB.
       var products: UpdProducts := new UpdProducts();
       var addSuccess: Boolean := products.UpdProduct(Convert.ToInt64(TXTProductID.Text), TXTProductName.Text, (*TXTProductDescription.Text*)CKEditor.Text , TXTProductPrice.Text, DropDownAddCategory.SelectedValue, if fileOK then ProductImage.FileName else ImageFileName.Value , TXTProductNameMini.Text );
       if addSuccess then begin
         //  Reload the page.
         var pageUrl: String := Request.RawUrl+'&ProductAction=Update';
         Response.Redirect(pageUrl);
       end
       else begin
         LabelStatus.Text := 'Unable to add new product to database.';
       end;
     
end;


method ProductEdit.formatArticle;
begin
  var fprod : NorpaNet.Data.Business.products := fproduct;
  var controlTXT: StringBuilder := new StringBuilder;
  
  controlTXT.Append('<div class="container product">');
  controlTXT.Append('    <div>');
  controlTXT.Append('        <h1 Class="center ProdTitle">'+fprod.Productname+'</h1>');
  controlTXT.Append('    </div>');
  controlTXT.Append('    <br />');
  controlTXT.Append('    <table Class="center prod_det">');
  controlTXT.Append('        <tr>');
  controlTXT.Append('            <td>');
  controlTXT.Append('                <img src="/Images/Catalog/Images/'+fprod.Imagepath+'" class="imgproduct" alt="'+fprod.Productname+'" />');
  controlTXT.Append('            </td>');
  controlTXT.Append('            <td>&nbsp;</td>');
  controlTXT.Append('        </tr>');
  controlTXT.Append('        <tr>');
  controlTXT.Append('            <td style="vertical-align: top; text-align:center;">');
  controlTXT.Append('                '+fprod.Description);
  controlTXT.Append('                <br />');  
  if fprod.Unitprice>0 then
  controlTXT.Append('                <span><b>, price:</b>&nbsp;'+ String.Format("{0:c}", fprod.Unitprice) +'</span>');
  controlTXT.Append('                <br />');
  controlTXT.Append('                <br />');
  controlTXT.Append('            </td>');
  controlTXT.Append('        </tr>');
  controlTXT.Append('    </table>');  
  controlTXT.Append('</div>');
  LitProduct.Text := controlTXT.ToString;
end;
end.
