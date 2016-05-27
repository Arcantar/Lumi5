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
  [ToolboxData('<{0}:SimpleMenu runat="server"></{0}:SimpleMenu>')]
  SimpleMenu = public class(WebControl)
  private    
    method DoRender(writer: HtmlTextWriter);
  protected
    method Render(writer: HtmlTextWriter); override;
  public
  end;

implementation



method SimpleMenu.Render(writer: HtmlTextWriter);
begin
  if HttpContext.Current = nil then begin
    writer.Write('[' + self.ID + ']');
    exit
  end;
  DoRender(writer);
end;

method SimpleMenu.DoRender(writer: HtmlTextWriter);
begin
 
    
 var requestPath: System.String := HttpContext.Current.Request.Path;
 var tmpclass : String := String.Empty;
 var fclass   : String := 'class="selected"';
 var controlTXT: StringBuilder := new StringBuilder;
 controlTXT.Append('<div class="navbar-collapse collapse">');
 controlTXT.Append('    <ul class="nav navbar-nav">');
 
 if (requestPath.StartsWith('/Admin/')) then tmpclass := fclass else tmpclass := String.Empty;
 if HttpContext.Current.User.IsInRole('canEdit') then 
 controlTXT.Append('        <li><a runat="server" '+tmpclass+' href="/Admin/AdminPage">Admin</a></li>');
 if ((requestPath = '/Default.aspx') or (requestPath = '/Home')) then tmpclass := fclass else tmpclass := String.Empty;
 controlTXT.Append('        <li><a '+tmpclass+' href="/">Home</a></li>');
 if (requestPath.StartsWith('/About')) then tmpclass := fclass else tmpclass := String.Empty;
 controlTXT.Append('        <li><a '+tmpclass+' href="/About">About</a></li>');
 if (requestPath.StartsWith('/Exhibitions')) then tmpclass := fclass else tmpclass := String.Empty;
 controlTXT.Append('        <li><a '+tmpclass+' href="/Exhibitions">Exhibitions</a></li>');
 if ((requestPath.StartsWith('/ProductList')) or (requestPath.StartsWith('/Category'))) then tmpclass := fclass else tmpclass := String.Empty;
 controlTXT.Append('        <li><a '+tmpclass+' href="/ProductList">Gallery</a></li>');
 if (requestPath.StartsWith('/Contact')) then tmpclass := fclass else tmpclass := String.Empty;
 controlTXT.Append('        <li><a '+tmpclass+' href="/Contact">Contact</a></li>');
 controlTXT.Append('    </ul>');
 controlTXT.Append('</div>'); 
 writer.Write(controlTXT.ToString);
inherited Render(writer);
end;
end.
