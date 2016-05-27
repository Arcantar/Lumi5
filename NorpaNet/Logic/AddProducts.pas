namespace NorpaNet.Logic;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  NorpaNet.Helper.Cache,
  NorpaNet.Models;

type
  AddProducts = public class
  public
    method AddProduct(ProductName: String; ProductDesc: String; ProductPrice: String; ProductCategory: String; ProductImagePath: String; ProductNameMini : String): Boolean;
  end;

  UpdProducts = public class
  public
    method UpdProduct(ProductID:Int64; ProductName: String; ProductDesc: String; ProductPrice: String; ProductCategory: String; ProductImagePath: String; ProductNameMini : String): Boolean;
  end;

implementation

uses 
  NorpaNet.Business,
  NorpaNet.Helper,
  WebGrease;

method AddProducts.AddProduct(ProductName: String; ProductDesc: String; ProductPrice: String; ProductCategory: String; ProductImagePath: String; ProductNameMini : String): Boolean;
begin
 var itemresult : Int32 := 0;
 try
  itemresult := NorpaNet.Data.Business.products.insert_products( ProductName, ProductDesc, ProductImagePath, Convert.ToDouble(ProductPrice), Convert.ToInt32(ProductCategory), ProductNameMini);
  CacheHelper.InvalidateKey('ProductList_'+ProductCategory.Trim);
  CacheHelper.InvalidateKey('Products');
  CacheHelper.InvalidateKey('Products_'+ProductName);
  CacheHelper.InvalidateKey('ProductList');
  var fSmtpSetting := new SmtpSettings;  
  Email.SendEmail(fSmtpSetting,'Taru@lumi5.com', 'Taru@lumi5.com' ,'nsg@tetrasys.fi','','Insertion d''un article' ,'l''article '+ProductName+' a été correctement inséré',false,Email.PriorityNormal);
 
 except
  exit false;
 end;
  exit itemresult <> 0;
end;

method UpdProducts.UpdProduct(ProductID: Int64; ProductName: String; ProductDesc: String; ProductPrice: String; ProductCategory: String; ProductImagePath: String; ProductNameMini : String): Boolean;
begin
 var itemresult : Int32 := 0;
 try
  itemresult := NorpaNet.Data.Business.products.insert_or_update_products( ProductID, ProductName, ProductDesc, ProductImagePath, Convert.ToDouble(ProductPrice), Convert.ToInt32(ProductCategory), ProductNameMini);
  CacheHelper.InvalidateKey('ProductList_'+ProductCategory.Trim);
  CacheHelper.InvalidateKey('Products');
  CacheHelper.InvalidateKey('Products_'+ProductID.ToString);
  CacheHelper.InvalidateKey('ProductList');
  var fSmtpSetting := new SmtpSettings;
  Email.SendEmail(fSmtpSetting,'Taru@lumi5.com', 'Taru@lumi5.com' ,'nsg@tetrasys.fi','','Mise à jour d''un article' ,'l''article '+ProductName+' a été correctement mis à jour',false,Email.PriorityNormal);
 except
  exit false;
 end;
  exit itemresult <> 0;

end;

end.
