<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0">
  <PropertyGroup>
    <ProductVersion>3.5</ProductVersion>
    <ProjectGuid>{97d121b5-f35c-44a6-b501-0a622553031a}</ProjectGuid>
    <ProjectTypeGuids>{349c5851-65df-11da-9384-00065b846f21};{656346D9-4656-40DA-A068-22D5425D4639}</ProjectTypeGuids>
    <OutputType>Library</OutputType>
    <RootNamespace>NorpaNet</RootNamespace>
    <AssemblyName>NorpaNet</AssemblyName>
    <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
    <TargetFrameworkVersion>v4.6</TargetFrameworkVersion>
    <IISExpressUseClassicPipelineMode>true</IISExpressUseClassicPipelineMode>
    <Name>NorpaNet</Name>
    <UseIISExpress>false</UseIISExpress>
    <DefaultUses />
    <StartupClass />
    <InternalAssemblyName />
    <ApplicationIcon />
    <AllowLegacyCreate>False</AllowLegacyCreate>
    <AllowLegacyWith>
    </AllowLegacyWith>
    <AllowLegacyOutParams>False</AllowLegacyOutParams>
    <AllowUnsafeCode>
    </AllowUnsafeCode>
    <DelphiCompatibility>
    </DelphiCompatibility>
    <AllowGlobals>False</AllowGlobals>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
    <DefineConstants>DEBUG;TRACE;</DefineConstants>
    <OutputPath>./bin\</OutputPath>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>True</GenerateMDB>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
    <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
    <CpuType>anycpu</CpuType>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
    <OutputPath>./bin</OutputPath>
    <EnableAsserts>False</EnableAsserts>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="Antlr3.Runtime">
      <HintPath>..\packages\Antlr.3.5.0.2\lib\Antlr3.Runtime.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="AspNet.ScriptManager.bootstrap">
      <HintPath>..\packages\AspNet.ScriptManager.bootstrap.3.3.6\lib\net45\AspNet.ScriptManager.bootstrap.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="AspNet.ScriptManager.jQuery">
      <HintPath>..\packages\AspNet.ScriptManager.jQuery.1.10.2\lib\net45\AspNet.ScriptManager.jQuery.dll</HintPath>
    </Reference>
    <Reference Include="Elmah">
      <HintPath>..\packages\elmah.corelibrary.1.2.2\lib\Elmah.dll</HintPath>
    </Reference>
    <Reference Include="Microsoft.AspNet.FriendlyUrls">
      <HintPath>..\packages\Microsoft.AspNet.FriendlyUrls.Core.1.0.2\lib\net45\Microsoft.AspNet.FriendlyUrls.dll</HintPath>
    </Reference>
    <Reference Include="Microsoft.AspNet.Identity.Core">
      <HintPath>..\packages\Microsoft.AspNet.Identity.Core.2.2.1\lib\net45\Microsoft.AspNet.Identity.Core.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.AspNet.Identity.EntityFramework">
      <HintPath>..\packages\Microsoft.AspNet.Identity.EntityFramework.2.2.1\lib\net45\Microsoft.AspNet.Identity.EntityFramework.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.AspNet.Identity.Owin">
      <HintPath>..\packages\Microsoft.AspNet.Identity.Owin.2.2.1\lib\net45\Microsoft.AspNet.Identity.Owin.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.AspNet.Web.Optimization.WebForms">
      <HintPath>..\packages\Microsoft.AspNet.Web.Optimization.WebForms.1.1.3\lib\net45\Microsoft.AspNet.Web.Optimization.WebForms.dll</HintPath>
    </Reference>
    <Reference Include="Microsoft.Owin">
      <HintPath>..\packages\Microsoft.Owin.3.0.1\lib\net45\Microsoft.Owin.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Host.SystemWeb">
      <HintPath>..\packages\Microsoft.Owin.Host.SystemWeb.3.0.1\lib\net45\Microsoft.Owin.Host.SystemWeb.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Security">
      <HintPath>..\packages\Microsoft.Owin.Security.3.0.1\lib\net45\Microsoft.Owin.Security.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Security.Cookies">
      <HintPath>..\packages\Microsoft.Owin.Security.Cookies.3.0.1\lib\net45\Microsoft.Owin.Security.Cookies.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Security.Facebook">
      <HintPath>..\packages\Microsoft.Owin.Security.Facebook.3.0.1\lib\net45\Microsoft.Owin.Security.Facebook.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Security.Google">
      <HintPath>..\packages\Microsoft.Owin.Security.Google.3.0.1\lib\net45\Microsoft.Owin.Security.Google.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Security.MicrosoftAccount">
      <HintPath>..\packages\Microsoft.Owin.Security.MicrosoftAccount.3.0.1\lib\net45\Microsoft.Owin.Security.MicrosoftAccount.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Security.OAuth">
      <HintPath>..\packages\Microsoft.Owin.Security.OAuth.3.0.1\lib\net45\Microsoft.Owin.Security.OAuth.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.Owin.Security.Twitter">
      <HintPath>..\packages\Microsoft.Owin.Security.Twitter.3.0.1\lib\net45\Microsoft.Owin.Security.Twitter.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="mscorlib">
      <HintPath>$(Framework)\mscorlib.dll</HintPath>
    </Reference>
    <Reference Include="Newtonsoft.Json">
      <HintPath>..\..\WebFormTest1\packages\Newtonsoft.Json.6.0.3\lib\netcore45\Newtonsoft.Json.dll</HintPath>
    </Reference>
    <Reference Include="Owin">
      <HintPath>..\packages\Owin.1.0\lib\net40\Owin.dll</HintPath>
    </Reference>
    <Reference Include="System" />
    <Reference Include="System.ComponentModel.DataAnnotations" />
    <Reference Include="System.Configuration" />
    <Reference Include="System.Data" />
    <Reference Include="System.Data.Entity" />
    <Reference Include="System.Drawing" />
    <Reference Include="System.EnterpriseServices" />
    <Reference Include="System.Net.Http" />
    <Reference Include="System.Net.Http.WebRequest" />
    <Reference Include="System.Runtime.Caching" />
    <Reference Include="System.Web" />
    <Reference Include="System.Web.ApplicationServices" />
    <Reference Include="System.Web.DynamicData" />
    <Reference Include="System.Web.Entity" />
    <Reference Include="System.Web.Extensions" />
    <Reference Include="System.Web.Mobile" />
    <Reference Include="System.Web.Optimization">
      <HintPath>..\packages\Microsoft.AspNet.Web.Optimization.1.1.3\lib\net40\System.Web.Optimization.dll</HintPath>
    </Reference>
    <Reference Include="System.Web.Services" />
    <Reference Include="System.Windows.Forms" />
    <Reference Include="System.Xml" />
    <Reference Include="System.Core">
      <RequiredTargetFramework>3.5</RequiredTargetFramework>
    </Reference>
    <Reference Include="System.Xml.Linq">
      <RequiredTargetFramework>3.5</RequiredTargetFramework>
    </Reference>
    <Reference Include="System.Data.DataSetExtensions">
      <RequiredTargetFramework>3.5</RequiredTargetFramework>
    </Reference>
    <Reference Include="WebGrease">
      <HintPath>..\packages\WebGrease.1.6.0\lib\WebGrease.dll</HintPath>
      <Private>True</Private>
    </Reference>
  </ItemGroup>
  <ItemGroup>
    <Compile Include="Business\Email.pas" />
    <Compile Include="Business\SmtpSettings.pas" />
    <Compile Include="Components\Controls\Contact.ascx.Designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Components\Controls\Contact.ascx</DependentUpon>
      <DesignableClassName>NorpaNet.Components.Controls.Contact</DesignableClassName>
    </Compile>
    <Compile Include="Components\Controls\Contact.ascx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Components\Controls\Contact.ascx</DependentUpon>
      <DesignableClassName>NorpaNet.Components.Controls.Contact</DesignableClassName>
    </Compile>
    <Compile Include="Components\Controls\MenuCategory.pas">
      <SubType>Code</SubType>
      <DesignableClassName>NorpaNet.Components.Controls.MenuCategory</DesignableClassName>
    </Compile>
    <Compile Include="Components\Controls\SimpleMenu.pas">
      <SubType>Code</SubType>
      <DesignableClassName>NorpaNet.Components.Controls.SimpleMenu</DesignableClassName>
    </Compile>
    <Compile Include="Components\DefaultBasePage.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Components.DefaultBasePage</DesignableClassName>
    </Compile>
    <Compile Include="Components\IPLocation.pas" />
    <Compile Include="Components\URLRewrite.pas" />
    <Compile Include="Components\WebConfigSettings.pas" />
    <Compile Include="Contact.aspx.designer.pas">
      <DependentUpon>Contact.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Contact</DesignableClassName>
    </Compile>
    <Compile Include="Contact.aspx.pas">
      <DependentUpon>Contact.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Contact</DesignableClassName>
    </Compile>
    <Compile Include="ErrorPage.aspx.designer.pas">
      <DependentUpon>ErrorPage.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.ErrorPage</DesignableClassName>
    </Compile>
    <Compile Include="ErrorPage.aspx.pas">
      <DependentUpon>ErrorPage.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.ErrorPage</DesignableClassName>
    </Compile>
    <Compile Include="Helper\CacheHelper.pas" />
    <Compile Include="Helper\Cache\CacheManage.pas" />
    <Compile Include="Helper\Cache\CacheProvider.pas" />
    <Compile Include="Helper\Cache\MemoryCacheAdapter.pas" />
    <Compile Include="Helper\ConfigHelper.pas" />
    <Compile Include="Helper\CultureHelper.pas" />
    <Compile Include="Helper\CultureHelperHttpModule.pas" />
    <Compile Include="Helper\PersianDateHelper.pas" />
    <Compile Include="Helper\StringHelper.pas" />
    <Compile Include="Helper\WebUtilsHelper.pas" />
    <Compile Include="Pages\About\About.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\About\About.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.About</DesignableClassName>
    </Compile>
    <Compile Include="Pages\About\About.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\About\About.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.About</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\AddPhoneNumber.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\AddPhoneNumber.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.AddPhoneNumber</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\AddPhoneNumber.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\AddPhoneNumber.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.AddPhoneNumber</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Confirm.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Confirm.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Confirm</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Confirm.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Confirm.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Confirm</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Forgot.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Forgot.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ForgotPassword</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Forgot.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Forgot.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ForgotPassword</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Lockout.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Lockout.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Lockout</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Lockout.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Lockout.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Lockout</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Login.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Login.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Login</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Login.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Login.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Login</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Manage.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Manage.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Manage</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Manage.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Manage.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Manage</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\ManageLogins.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\ManageLogins.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ManageLogins</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\ManageLogins.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\ManageLogins.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ManageLogins</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\ManagePassword.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\ManagePassword.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ManagePassword</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\ManagePassword.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\ManagePassword.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ManagePassword</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\OpenAuthProviders.ascx.Designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\OpenAuthProviders.ascx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.OpenAuthProviders</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\OpenAuthProviders.ascx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\OpenAuthProviders.ascx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.OpenAuthProviders</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Register.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Register.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Register</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\Register.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\Register.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.Register</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\RegisterExternalLogin.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\RegisterExternalLogin.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.RegisterExternalLogin</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\ResetPassword.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\ResetPassword.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ResetPassword</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\ResetPasswordConfirmation.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\ResetPasswordConfirmation.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.ResetPasswordConfirmation</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\TwoFactorAuthenticationSignIn.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\TwoFactorAuthenticationSignIn.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.TwoFactorAuthenticationSignIn</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Account\VerifyPhoneNumber.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Account\VerifyPhoneNumber.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Account.VerifyPhoneNumber</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Admin\AdminPage.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Admin\AdminPage.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Admin.AdminPage</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Admin\AdminPage.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Admin\AdminPage.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Admin.AdminPage</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Admin\ProductEdit.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Admin\ProductEdit.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Admin.ProductEdit</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Admin\ProductEdit.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Admin\ProductEdit.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Admin.ProductEdit</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Carts\AddToCart.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Carts\AddToCart.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.AddToCart</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Carts\AddToCart.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Carts\AddToCart.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.AddToCart</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Carts\ShoppingCart.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Carts\ShoppingCart.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.ShoppingCart</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Carts\ShoppingCart.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Carts\ShoppingCart.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.ShoppingCart</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutCancel.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutCancel.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutCancel</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutCancel.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutCancel.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutCancel</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutComplete.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutComplete.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutComplete</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutComplete.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutComplete.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutComplete</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutError.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutError.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutError</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutError.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutError.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutError</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutReview.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutReview.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutReview</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutReview.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutReview.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutReview</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutStart.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutStart.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutStart</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Checkout\CheckoutStart.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Checkout\CheckoutStart.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Checkout.CheckoutStart</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Exhibitions\Exhibitions.aspx.designer.pas">
      <DependentUpon>Pages\Exhibitions\Exhibitions.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Exhibitions</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Exhibitions\Exhibitions.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Exhibitions\Exhibitions.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.Exhibitions</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Products\ProductDetails.aspx.pas">
      <DependentUpon>Pages\Products\ProductDetails.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.ProductDetails</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Products\ProductList.aspx.designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Products\ProductList.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.ProductList</DesignableClassName>
    </Compile>
    <Compile Include="Pages\Products\ProductList.aspx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DependentUpon>Pages\Products\ProductList.aspx</DependentUpon>
      <DesignableClassName>NorpaNet.ProductList</DesignableClassName>
    </Compile>
    <Compile Include="Site.Master.designer.pas">
      <DependentUpon>Site.Master</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Site</DesignableClassName>
    </Compile>
    <Compile Include="Site.Master.pas">
      <DependentUpon>Site.Master</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Site</DesignableClassName>
    </Compile>
    <Compile Include="Site.Mobile.Master.designer.pas">
      <DependentUpon>Site.Mobile.Master</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Site_Mobile</DesignableClassName>
    </Compile>
    <Compile Include="Site.Mobile.Master.pas">
      <DependentUpon>Site.Mobile.Master</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.Site_Mobile</DesignableClassName>
    </Compile>
    <Compile Include="Startup.pas" />
    <Compile Include="ViewSwitcher.ascx.Designer.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.ViewSwitcher</DesignableClassName>
    </Compile>
    <Compile Include="ViewSwitcher.ascx.pas">
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet.ViewSwitcher</DesignableClassName>
    </Compile>
    <Content Include="Bundle.config">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Components\Controls\Contact.ascx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Contact.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Content\bootstrap-original.css">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Content\bootstrap-original.min.css">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Content\bootstrap.css">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Content\bootstrap.min.css">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Content\Site.css">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Default.aspx" />
    <Compile Include="App_Start\BundleConfig.pas" />
    <Compile Include="App_Start\IdentityConfig.pas" />
    <Compile Include="App_Start\RouteConfig.pas" />
    <Compile Include="App_Start\Startup.Auth.pas" />
    <Compile Include="Default.aspx.pas">
      <DependentUpon>Default.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet._Default</DesignableClassName>
    </Compile>
    <Compile Include="Default.aspx.designer.pas">
      <DependentUpon>Default.aspx</DependentUpon>
      <SubType>ASPXCodeBehind</SubType>
      <DesignableClassName>NorpaNet._Default</DesignableClassName>
    </Compile>
    <Content Include="ErrorPage.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="favicon.ico">
      <SubType>Content</SubType>
    </Content>
    <Content Include="fonts\glyphicons-halflings-regular.eot">
      <SubType>Content</SubType>
    </Content>
    <Content Include="fonts\glyphicons-halflings-regular.svg">
      <SubType>Content</SubType>
    </Content>
    <Content Include="fonts\glyphicons-halflings-regular.ttf">
      <SubType>Content</SubType>
    </Content>
    <Content Include="fonts\glyphicons-halflings-regular.woff">
      <SubType>Content</SubType>
    </Content>
    <Content Include="fonts\glyphicons-halflings-regular.woff2">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Global.asax" />
    <Compile Include="Global.asax.pas">
      <DependentUpon>Global.asax</DependentUpon>
    </Compile>
    <Content Include="Images\Catalog\Images\Thumbs\boatbig.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\boatpaper.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\boatsail.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\busdouble.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\busgreen.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\busred.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\carconvert.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\carearly.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\carfast.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\carfaster.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\carracer.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\planeace.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\planeglider.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\planepaper.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\planeprop.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\rocket.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\truckbig.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\truckearly.png">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Images\Catalog\Images\Thumbs\truckfire.png">
      <SubType>Content</SubType>
    </Content>
    <None Include="Lumi5.pubxml">
      <SubType>Content</SubType>
    </None>
    <Content Include="packages.config">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\About\About.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\AddPhoneNumber.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\Confirm.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\Forgot.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\Lockout.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\Login.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\Manage.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\ManageLogins.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\ManagePassword.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\OpenAuthProviders.ascx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\Register.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\RegisterExternalLogin.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\ResetPassword.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\ResetPasswordConfirmation.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\TwoFactorAuthenticationSignIn.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\VerifyPhoneNumber.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Account\Web.config">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Admin\AdminPage.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Admin\ProductEdit.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Admin\Web.config">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Carts\AddToCart.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Carts\ShoppingCart.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Checkout\CheckoutCancel.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Checkout\CheckoutComplete.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Checkout\CheckoutError.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Checkout\CheckoutReview.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Checkout\CheckoutStart.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Checkout\Web.config">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Exhibitions\Exhibitions.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Products\ProductDetails.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Pages\Products\ProductList.aspx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\bootstrap.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\bootstrap.min.js">
      <SubType>Content</SubType>
    </Content>
    <None Include="Scripts\jquery-2.2.3.intellisense.js">
      <SubType>Content</SubType>
    </None>
    <Content Include="Scripts\darkbox.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\jquery-2.2.3.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\jquery-2.2.3.min.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\jquery-2.2.3.min.map">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\modernizr-2.8.3.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\respond.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\respond.matchmedia.addListener.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\respond.matchmedia.addListener.min.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\respond.min.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\DetailsView.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\Focus.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\GridView.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\Menu.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MenuStandards.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjax.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxApplicationServices.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxComponentModel.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxCore.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxGlobalization.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxHistory.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxNetwork.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxSerialization.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxTimer.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxWebForms.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\MSAjax\MicrosoftAjaxWebServices.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\SmartNav.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\TreeView.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\WebForms.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\WebParts.js">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Scripts\WebForms\WebUIValidation.js">
      <SubType>Content</SubType>
    </Content>
    <None Include="Scripts\_references.js">
      <SubType>Content</SubType>
    </None>
    <Content Include="Site.Master">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Site.Mobile.Master">
      <SubType>Content</SubType>
    </Content>
    <Content Include="ViewSwitcher.ascx">
      <SubType>Content</SubType>
    </Content>
    <Content Include="Web.config" />
    <Compile Include="Logic\AddProducts.pas" />
    <Compile Include="Logic\ExceptionUtility.pas" />
    <Compile Include="Logic\PayPalFunctions.pas" />
    <Compile Include="Logic\RoleActions.pas" />
    <Compile Include="Logic\ShoppingCartActions.pas" />
    <Compile Include="Models\CartItem.pas" />
    <Compile Include="Models\Category.pas" />
    <Compile Include="Models\IdentityModels.pas" />
    <Compile Include="Models\Order.pas" />
    <Compile Include="Models\OrderDetail.pas" />
    <Compile Include="Models\Product.pas" />
    <Compile Include="Models\ProductContext.pas" />
    <Compile Include="Properties\AssemblyInfo.pas" />
    <None Include="Web.Release.config">
      <SubType>Content</SubType>
      <DependentUpon>Web.config</DependentUpon>
    </None>
    <None Include="Web.Debug.config">
      <SubType>Content</SubType>
      <DependentUpon>Web.config</DependentUpon>
    </None>
  </ItemGroup>
  <ItemGroup>
    <Folder Include="App_Data\" />
    <Folder Include="App_Readme" />
    <Folder Include="App_Start" />
    <Folder Include="Components\Controls" />
    <Folder Include="Content" />
    <Folder Include="fonts\" />
    <Folder Include="Helper\Cache" />
    <Folder Include="Images" />
    <Folder Include="Images\Catalog\" />
    <Folder Include="Images\Catalog\Images\" />
    <Folder Include="Images\Catalog\Images\Thumbs\" />
    <Folder Include="Logic" />
    <Folder Include="Models" />
    <Folder Include="Helper" />
    <Folder Include="Components" />
    <Folder Include="Business" />
    <Folder Include="Pages" />
    <Folder Include="Pages\About" />
    <Folder Include="Pages\Account\" />
    <Folder Include="Pages\Admin\" />
    <Folder Include="Pages\Carts" />
    <Folder Include="Pages\Checkout\" />
    <Folder Include="Pages\Exhibitions" />
    <Folder Include="Pages\Products" />
    <Folder Include="Scripts" />
    <Folder Include="Properties\" />
    <Folder Include="Scripts\WebForms" />
    <Folder Include="Scripts\WebForms\MSAjax" />
  </ItemGroup>
  <ItemGroup>
    <ProjectReference Include="..\AspNet.Identity.Firebird3\AspNet.Identity.Firebird3.oxygene">
      <Name>AspNet.Identity.Firebird3</Name>
      <Project>{b8d97c31-5470-43d6-87d8-1ffc9a7fc578}</Project>
      <Private>True</Private>
      <HintPath>..\AspNet.Identity.Firebird3\bin\Debug\AspNet.Identity.Firebird3.dll</HintPath>
    </ProjectReference>
    <ProjectReference Include="..\CKEditor.NET\CKEditor.NET.csproj">
      <Name>CKEditor.NET</Name>
      <Project>{fc4500a9-8e83-46b0-87fa-86d44ab79aa7}</Project>
      <Private>True</Private>
      <HintPath>..\CKEditor.NET\bin\Debug\CKEditor.NET.dll</HintPath>
    </ProjectReference>
    <ProjectReference Include="..\NorpaNet.Data\NorpaNet.Data.oxygene">
      <Name>NorpaNet.Data</Name>
      <Project>{fd3b582c-a682-40af-99e1-447c9a2b9452}</Project>
      <Private>True</Private>
      <HintPath>..\NorpaNet.Data\bin\Release\NorpaNet.Data.dll</HintPath>
    </ProjectReference>
  </ItemGroup>
  <ProjectExtensions>
    <VisualStudio>
      <FlavorProperties Guid="{349c5851-65df-11da-9384-00065b846f21}">
        <WebProjectProperties>
          <UseIIS>False</UseIIS>
          <AutoAssignPort>True</AutoAssignPort>
          <DevelopmentServerPort>17523</DevelopmentServerPort>
          <DevelopmentServerVPath>/</DevelopmentServerVPath>
          <IISUrl>http://11.5.0.118/lumi5</IISUrl>
          <NTLMAuthentication>False</NTLMAuthentication>
          <UseCustomServer>True</UseCustomServer>
          <CustomServerUrl>http://Lumi5</CustomServerUrl>
          <SaveServerSettingsInUserFile>False</SaveServerSettingsInUserFile>
        </WebProjectProperties>
      </FlavorProperties>
      <FlavorProperties Guid="{349c5851-65df-11da-9384-00065b846f21}" User="">
        <WebProjectProperties>
          <StartPageUrl>
          </StartPageUrl>
          <StartAction>CurrentPage</StartAction>
          <AspNetDebugging>True</AspNetDebugging>
          <SilverlightDebugging>False</SilverlightDebugging>
          <NativeDebugging>False</NativeDebugging>
          <SQLDebugging>False</SQLDebugging>
          <ExternalProgram>
          </ExternalProgram>
          <StartExternalURL>
          </StartExternalURL>
          <StartCmdLineArguments>
          </StartCmdLineArguments>
          <StartWorkingDirectory>
          </StartWorkingDirectory>
          <EnableENC>True</EnableENC>
          <AlwaysStartWebServerOnDebug>True</AlwaysStartWebServerOnDebug>
        </WebProjectProperties>
      </FlavorProperties>
    </VisualStudio>
  </ProjectExtensions>
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Oxygene\RemObjects.Oxygene.Echoes.targets" />
  <Import Project="$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v12.0\WebApplications\Microsoft.WebApplication.targets" />
</Project>