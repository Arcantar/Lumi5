namespace NorpaNet.Components;

interface

uses
  System,
  System.Configuration,
  System.Globalization,
  System.IO,
  System.Text.RegularExpressions,
  System.Web,
  System.Web.UI,
  System.Web.UI.HtmlControls,
  System.Web.UI.WebControls,
  System.Web.Security,
  NorpaNet;

type
  DefaultBasePage = public class(Page)
  private
    class var REGEX_BETWEEN_TAGS: Regex         := new Regex('>\s+<', RegexOptions.Compiled);
    class var REGEX_LINE_BREAKS : Regex         := new Regex('\n\s+', RegexOptions.Compiled);
    var       _lang             : System.String := WebConfigSettings.GetDefaultCulture;
    method set_PageLang(lang: System.String);
  protected
  public
    property PageLang : System.String read _lang write set_PageLang;
  end;

implementation

method DefaultBasePage.set_PageLang(lang: System.String);
begin
  _lang := lang;
  var html : HtmlElement := HtmlElement(MasterPage(self.Master).FindControl('htmlControl'));
  if html <> nil then begin
    html.Attributes['lang'] := if _lang = 'SE' then 'SV' else _lang; 
  end;
end;
end.
