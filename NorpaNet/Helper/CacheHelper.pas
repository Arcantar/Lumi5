namespace NorpaNet.Helper;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Text, 
  Microsoft.AspNet.Identity,
  Microsoft.AspNet.Identity.Owin,
  AspNet.Identity.Firebird3,
  NorpaNet, 
  NorpaNet.Helper.Cache;

type
  CacheHelper = public static class
  private    
   var _cache : ICache := new MemoryCacheAdapter;
  protected
  public
    class method RetrieveUser(userId : String; context: System.Web.HttpContext):ApplicationUser;
    class method RetrieveUserByEmail(email : String; context: System.Web.HttpContext):ApplicationUser;
    class method RetrieveManager(context: System.Web.HttpContext):ApplicationUserManager;
    class method GetProductList(categoryId:nullable Int64; categoryName:nullable String): list<NorpaNet.Data.Business.products>;
    class method GetProducts(productId: nullable Int64; productName: String): list<NorpaNet.Data.Business.products>;
    class method GetCategories:List<NorpaNet.Data.Business.categories>;
    class method GetProducts:list<NorpaNet.Data.Business.products>;
    class method InvalidateKey(fkey : String);
  end;

implementation

uses 
  System.Runtime.InteropServices;

class method CacheHelper.RetrieveUser(userId : String; context: System.Web.HttpContext):ApplicationUser;
begin
 if ((String.IsNullOrEmpty(userId)) or (context = nil)) then exit nil;
 var cachekey: System.String := userId;
 var expiration: DateTime := DateTime.Now.AddHours(1);
 exit CacheManager.Cache.Get<ApplicationUser>(cachekey, expiration, () -> begin
    var manager := context.GetOwinContext().GetUserManager<ApplicationUserManager>;
    var user:ApplicationUser := manager.FindById(userId);
    exit user;
    end,false);
end;
class method CacheHelper.RetrieveUserByEmail(email : String; context: System.Web.HttpContext):ApplicationUser;
begin
 if ((String.IsNullOrEmpty(email)) or (context = nil)) then exit nil;
 var cachekey: System.String := email;
 var expiration: DateTime := DateTime.Now.AddHours(1);
 exit CacheManager.Cache.Get<ApplicationUser>(cachekey, expiration, () -> begin
    var manager := context.GetOwinContext().GetUserManager<ApplicationUserManager>;
    var user:ApplicationUser := manager.FindByEmail(email);
    exit user;
    end,false);
end;

class method CacheHelper.RetrieveManager(context: System.Web.HttpContext): ApplicationUserManager;
begin
 //var cachekey: System.String := 'manager_ApplicationUserManager';
 //var expiration: DateTime := DateTime.Now.AddHours(10);
 //exit CacheManager.Cache.Get<ApplicationUserManager>(cachekey, expiration, () -> begin
    var manager := context.GetOwinContext().GetUserManager<ApplicationUserManager>;
    exit manager;
   // end,false);

end;

class method CacheHelper.GetProductList(categoryId: nullable Int64; categoryName: nullable String): list<NorpaNet.Data.Business.products>;
begin
 var cachekey: System.String := 'ProductList';
 if categoryId <> nil then
   cachekey := cachekey+'_'+categoryId.ToString
else
  if categoryName <> nil then
    cachekey := cachekey+'_'+categoryName;
 var expiration: DateTime := DateTime.Now.AddHours(1);
 exit CacheManager.Cache.Get<list<NorpaNet.Data.Business.products>>(cachekey, expiration, () -> begin
      var _db := new NorpaNet.Models.ProductContext();
      var query: list<NorpaNet.Data.Business.products> ;
      if ((categoryId <> nil) and (categoryId > 0)) then begin
        query :=  _db.Products.select_products_Categoryid_to_list(categoryId);;
      end
      else
        if not String.IsNullOrEmpty(categoryName) then begin
          query := _db.Products.select_products_with_spec_clause_where_to_list('categoryid = (select categoryid from categories where categoryname collate fr_ca_ci_ai ='''+categoryName+''' rows 1 );' );
        end
        else begin
          query := _db.Products.select_products_with_spec_clause_where_to_list(' 1 = 1 ;' );
        end;
      exit query;
    end,false);
end;

class method CacheHelper.GetProducts(productId: nullable Int64; productName: String): list<NorpaNet.Data.Business.products>;
begin
 var cachekey: System.String := 'Products';
 if productId > 0  then
   cachekey := cachekey+'_'+productId.ToString
else
  if productName <> nil then
    cachekey := cachekey+'_'+productName;
 var expiration: DateTime := DateTime.Now.AddHours(1);
 exit CacheManager.Cache.Get<list<NorpaNet.Data.Business.products>>(cachekey, expiration, () -> begin
    var _db := new NorpaNet.Models.ProductContext();
    var query: list<NorpaNet.Data.Business.products> ;
    if (productId > 0) then begin
      query :=  _db.Products.select_products_Productid_to_list(productId);;
    end
    else
      if not String.IsNullOrEmpty(productName) then begin
        query := _db.Products.select_products_with_spec_clause_where_to_list(' ProductName collate fr_ca_ci_ai = '''+productName+''' ;');
      end
      else begin
        query := nil;
      end;
    exit query;
    end,false);
end;

class method CacheHelper.GetCategories:List<NorpaNet.Data.Business.categories>;
begin
 var cachekey: System.String := 'CategoriesList';
 var expiration: DateTime := DateTime.Now.AddHours(1);
 exit CacheManager.Cache.Get<List<NorpaNet.Data.Business.categories>>(cachekey, expiration, () -> begin
    exit NorpaNet.Data.Business.categories.select_categories_with_spec_clause_where_to_list(' 1 = 1 ');;
    end,false);
end;

class method CacheHelper.GetProducts: list<NorpaNet.Data.Business.products>;
begin
 var cachekey: System.String := 'ProductList';
 var expiration: DateTime := DateTime.Now.AddHours(1);
 exit CacheManager.Cache.Get<List<NorpaNet.Data.Business.products>>(cachekey, expiration, () -> begin
    exit NorpaNet.Data.Business.products.select_products_with_spec_clause_where_to_list(' 1 = 1');
    end,false);
end;

class method CacheHelper.InvalidateKey(fkey: String);
begin
  CacheManager.Cache.InvalidateCacheItem(fkey);    
end;
end.
