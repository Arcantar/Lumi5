namespace NorpaNet;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.Optimization,
  System.Web.UI;

type
  BundleConfig = public class
  public
    //  For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkID=303951
    class method RegisterBundles(bundles: BundleCollection);
  end;

implementation

class method BundleConfig.RegisterBundles(bundles: BundleCollection);
begin
  bundles.Add(new ScriptBundle('~/bundles/WebFormsJs').Include('~/Scripts/WebForms/WebForms.js', '~/Scripts/WebForms/WebUIValidation.js', '~/Scripts/WebForms/MenuStandards.js', '~/Scripts/WebForms/Focus.js', '~/Scripts/WebForms/GridView.js', '~/Scripts/WebForms/DetailsView.js', '~/Scripts/WebForms/TreeView.js', '~/Scripts/WebForms/WebParts.js', '~/Scripts/darkbox.js'));
  //  Order is very important for these files to work, they have explicit dependencies
  bundles.Add(new ScriptBundle('~/bundles/MsAjaxJs').Include('~/Scripts/WebForms/MsAjax/MicrosoftAjax.js', '~/Scripts/WebForms/MsAjax/MicrosoftAjaxApplicationServices.js', '~/Scripts/WebForms/MsAjax/MicrosoftAjaxTimer.js', '~/Scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js'));
  //  Use the Development version of Modernizr to develop with and learn from. Then, when you’re
  //  ready for production, use the build tool at http://modernizr.com to pick only the tests you need
  bundles.Add(new ScriptBundle('~/bundles/modernizr').Include('~/Scripts/modernizr-*' ));

  var ScriptResourceDefinitionWebFormsJs := new ScriptResourceDefinition;
  ScriptResourceDefinitionWebFormsJs.Path := '~/bundles/WebFormsJs';
  ScriptResourceDefinitionWebFormsJs.CdnPath := 'http://ajax.aspnetcdn.com/ajax/4.5/6/WebFormsBundle.js';
  ScriptResourceDefinitionWebFormsJs.LoadSuccessExpression  := 'window.WebForm_PostBackOptions';
  ScriptResourceDefinitionWebFormsJs.CdnSupportsSecureConnection := true;

ScriptManager.ScriptResourceMapping.AddDefinition('WebFormsBundle', ScriptResourceDefinitionWebFormsJs);

  var ScriptResourceDefinitionMsAjaxBundle := new ScriptResourceDefinition;
  ScriptResourceDefinitionMsAjaxBundle.Path := '~/bundles/MsAjaxJs';
  ScriptResourceDefinitionMsAjaxBundle.CdnPath := 'http://ajax.aspnetcdn.com/ajax/4.5/6/MsAjaxBundle.js';
  ScriptResourceDefinitionMsAjaxBundle.LoadSuccessExpression  := 'window.Sys';
  ScriptResourceDefinitionMsAjaxBundle.CdnSupportsSecureConnection := true;

ScriptManager.ScriptResourceMapping.AddDefinition('MsAjaxBundle', ScriptResourceDefinitionMsAjaxBundle);

  var str: String := '2.2.3';
  var ScriptResourceDefinitionjquery := new ScriptResourceDefinition;
  ScriptResourceDefinitionjquery.Path := '~/Scripts/jquery-' + str + '.min.js';
  ScriptResourceDefinitionjquery.DebugPath := '~/Scripts/jquery-' + str + '.js';
  ScriptResourceDefinitionjquery.CdnPath := 'http://ajax.aspnetcdn.com/ajax/jQuery/jquery-' + str + '.min.js';
  ScriptResourceDefinitionjquery.CdnDebugPath := 'http://ajax.aspnetcdn.com/ajax/jQuery/jquery-' + str + '.js';
  ScriptResourceDefinitionjquery.LoadSuccessExpression  := 'window.jQuery';
  ScriptResourceDefinitionjquery.CdnSupportsSecureConnection := true;

ScriptManager.ScriptResourceMapping.AddDefinition('jquery', ScriptResourceDefinitionjquery);

//  str := "1.8.20";
//  var ScriptResourceDefinitionjqueryUI := new ScriptResourceDefinition;
//  ScriptResourceDefinitionjqueryUI.Path := '~/Scripts/jquery-ui-' + str + '.min.js';
//  ScriptResourceDefinitionjqueryUI.DebugPath := '~/Scripts/jquery-ui-' + str + '.js';
//  ScriptResourceDefinitionjqueryUI.CdnPath := 'http://ajax.aspnetcdn.com/ajax/jquery.ui/' + str + '/jquery-ui.min.js';
//  ScriptResourceDefinitionjqueryUI.CdnDebugPath := 'http://ajax.aspnetcdn.com/ajax/jquery.ui/' + str + '/jquery-ui.js';
//  ScriptResourceDefinitionjqueryUI.CdnSupportsSecureConnection := true;
//
//ScriptManager.ScriptResourceMapping.AddDefinition('jquery.ui.combined', ScriptResourceDefinitionjqueryUI);

bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                        "~/Scripts/bootstrap.min.js"));
  //  Set EnableOptimizations to false for debugging. For more information,
  //  visit http://go.microsoft.com/fwlink/?LinkId=301862
  BundleTable.EnableOptimizations := true;
  var fscript:ScriptResourceDefinition := new ScriptResourceDefinition;
  fscript.DebugPath := '~/Scripts/respond.js';
  fscript.Path      := '~/Scripts/respond.min.js';
  ScriptManager.ScriptResourceMapping.AddDefinition('respond', fscript);
end;

end.
