namespace NorpaNet.Components.Controls;

interface

uses
  System,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Text,
  System.Linq,
  System.Collections.Generic,
  NorpaNet.Helper,
  NorpaNet.Helper.Cache,
  NorpaNet.Data.Business;

type
  
  [ToolboxData('<{0}:MenuCategory runat="server"></{0}:MenuCategory>')]
  MenuCategory = public class(WebControl)  
  private    
    var _cache : ICache := new MemoryCacheAdapter;
    method DoRender(writer: HtmlTextWriter);
    method paramtosring:String;
  protected
    method Render(writer: HtmlTextWriter); override;
  public
    property UseSep     : Boolean := true;
    property Sep        : String  := '|';
    property showimage  : Boolean := false;
    property classitem  : String  := System.String.Empty;
    property classimg   : String  := system.String.Empty;
    property Selected   : String  := System.String.Empty;
    property SelectedID : Int32   := 0;
  end;

implementation


method MenuCategory.Render(writer: HtmlTextWriter);
begin
  if HttpContext.Current = nil then begin
    writer.Write('[' + self.ID + ']');
    exit
  end;
  var yu2 : String := String.Empty;
  var fkey : String := 'MenuCategory'+paramtosring;
  if _cache.exists(fkey) then    
     yu2 := _cache.Get<String>(fkey);
  if not String.IsNullOrEmpty(yu2) then begin
    writer.Write(yu2);
    inherited Render(writer);
    exit;
  end else
    DoRender(writer);
end;

method MenuCategory.DoRender(writer: HtmlTextWriter);
begin
 var df: List<NorpaNet.Data.Business.categories> := CacheHelper.GetCategories;
 if df = nil then begin
   inherited Render(writer);
   exit;
 end;
 var controlTXT: StringBuilder := new StringBuilder;
 controlTXT.Append('<ul id="CategoryMenu" style="text-align: center">');
 var i : Int32 := 1;
 var fsep : String := System.String.Empty;
 var fima : String := System.String.Empty;
 var fselected : String := System.String.Empty;
 if UseSep and not String.IsNullOrEmpty(Sep) then
   fsep := Sep+'</li><li>';
 if showimage then 
   if not String.IsNullOrEmpty(classimg) then
   fima := '<a href="/Category/{2}"><img class="'+classimg+'" src="{0}" alt="{1}" ></a>' else
     fima := '<a href="/Category/{2}"><img src="{0}" alt="{1}" ></a>'; 
 for each yelp in df do begin
   if ((Selected = yelp.Categoryname) or (SelectedID = yelp.Categoryid)) then 
     fselected := ' class="selected" ' else
       fselected := '';
   controlTXT.Append('<li>');
   if showimage then
     controlTXT.Append(String.Format(fima,yelp.ImagePath,yelp.Categoryname,yelp.Categoryname));
   if i = 1 then
     controlTXT.Append('<b '+fselected+' style="font-size: large; font-style: normal"><a href="/Category/'+yelp.Categoryname.Trim+'">'+yelp.Categoryname+'</a></b> ')
   else
     controlTXT.Append(fsep+'<b '+fselected+'style="font-size: large; font-style: normal"><a href="/Category/'+yelp.Categoryname.Trim+'">'+yelp.Categoryname+'</a></b>');
   controlTXT.Append('</li>');
   inc(i);
 end;            
 controlTXT.Append('</ul>');
 writer.Write(controlTXT.ToString);
 var expiration: DateTime := DateTime.Now.AddHours(5);
 _cache.Add('MenuCategory'+paramtosring,expiration,controlTXT.ToString);
inherited Render(writer);
end;

method MenuCategory.paramtosring: String;
begin
  var tmpstr : String := UseSep.ToString+'_'+Sep+'_'+showimage.ToString+'_'+classimg+'_'+classitem+'_'+Selected+'_'+SelectedID;
exit tmpstr;
end;

end.
