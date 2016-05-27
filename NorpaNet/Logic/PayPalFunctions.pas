namespace NorpaNet.Logic;

interface

uses
  System,
  System.Collections,
  System.Collections.Generic,
  System.Collections.Specialized,
  System.IO,
  System.Net,
  System.Text,
  System.Data,
  System.Configuration,
  System.Web,
  System.Web.Services.Description,
  RemObjects.Elements.Cirrus.Values,
  NorpaNet,
  NorpaNet.Models,
  System.Collections.Generic,
  System.Linq;


type
  PayPalFunctions = public class
  private
  protected
  public
  end;

type
  NVPAPICaller = public class
  private
    var pEndPointURL: String := WebConfigSettings.PayPalpEndPointURL;
    var host: String := WebConfigSettings.PayPalhost;
    var pEndPointURL_SB: String := WebConfigSettings.PayPalpEndPointURL_SB;
    var host_SB: String := WebConfigSettings.PayPalhost_SB;
  public
    var APIUsername: String := iif(WebConfigSettings.PayPalbSandbox,WebConfigSettings.PayPalAPIUsername_SB,WebConfigSettings.PayPalAPIUsername);
  private
    var APIPassword: String := iif(WebConfigSettings.PayPalbSandbox,WebConfigSettings.PayPalAPIPassword_SB,WebConfigSettings.PayPalAPIPassword);
    var APISignature: String := iif(WebConfigSettings.PayPalbSandbox,WebConfigSettings.PayPalAPISignature_SB,WebConfigSettings.PayPalAPISignature);
    var Subject: String := '';
    var BNCode: String := 'PP-ECWizard';
    
    class var bSandbox : Boolean  := WebConfigSettings.PayPalbSandbox;readonly;
    //  Live strings.
    class const CVV2: String = 'CVV2';
    class const SIGNATURE: String = 'SIGNATURE';
    class const PWD: String = 'PWD';
    //  Replace <Your API Username> with your API Username
    //  Replace <Your API Password> with your API Password
    //  Replace <Your Signature> with your Signature
    class const ACCT: String = 'ACCT';
    class var SECURED_NVPS : array of String := ['ACCT', 'CVV2', 'SIGNATURE', 'PWD'] ; readonly;
    class const Timeout: Integer = 15000;
  public
    method SetCredentials(Userid: String; Pwd: String; Signature: String);
    method ShortcutExpressCheckout(amt: String; var token: String; var retMsg: String): Boolean;
    method GetCheckoutDetails(token: String; var PayerID: String; var decoder: NVPCodec; var retMsg: String): Boolean;
    method DoCheckoutPayment(finalPaymentAmount: String; token: String; PayerID: String; var decoder: NVPCodec; var retMsg: String): Boolean;
    method HttpCall(NvpRequest: String): String;
  private
    method buildCredentialsNVPString: String;
  public
    class method IsEmpty(s: String): Boolean;
  end;
type
  NVPCodec = public class(NameValueCollection)
  private
    class var AMPERSAND_CHAR_ARRAY: array of Char := AMPERSAND.ToCharArray();
    class var EQUALS_CHAR_ARRAY: array of Char := &EQUALS.ToCharArray();
    method GetArrayName(index: Integer; name: String): String;
 
  private
    class const AMPERSAND: String = '&';
    class const &EQUALS: String = '=';
  public
    method Encode: String;
    method Decode(nvpstring: String);
    method Add(name: String; value: String; index: Integer);
    method Remove(arrayName: String; index: Integer);
  
  end;



implementation

uses 
  NorpaNet.Helper;


method NVPAPICaller.SetCredentials(Userid: String; Pwd: String; Signature: String);
begin
  APIUsername := Userid;
  APIPassword := Pwd;
  APISignature := Signature;
end;

method NVPAPICaller.ShortcutExpressCheckout(amt: String; var token: String; var retMsg: String): Boolean;
begin
  if bSandbox then begin
    pEndPointURL := pEndPointURL_SB;
    host := host_SB;
  end;
  var returnURL: String := iif(WebConfigSettings.PayPalbSandbox,WebConfigSettings.PayPalCheckoutReviewURL_SB,WebConfigSettings.PayPalCheckoutReviewURL);
  var cancelURL: String := iif(WebConfigSettings.PayPalbSandbox,WebConfigSettings.PayPalCheckoutCancelURL_SB,WebConfigSettings.PayPalCheckoutCancelURL);
  var encoder: NVPCodec := new NVPCodec();
  encoder['METHOD'] := 'SetExpressCheckout';
  encoder['RETURNURL'] := returnURL;
  encoder['CANCELURL'] := cancelURL;
  encoder['BRANDNAME'] := WebConfigSettings.PayPalBrandName;
  encoder['PAYMENTREQUEST_0_AMT'] := amt.Replace(',','.');
  encoder['PAYMENTREQUEST_0_ITEMAMT'] := amt.Replace(',','.');
  encoder['PAYMENTREQUEST_0_PAYMENTACTION'] := 'Sale';
  encoder['PAYMENTREQUEST_0_CURRENCYCODE'] := WebConfigSettings.PayPalCurrency;
  //  Get the Shopping Cart Products
  using myCartOrders: ShoppingCartActions := new ShoppingCartActions() do
  begin
    var myOrderList: List<NorpaNet.Data.Business.cartitem> := myCartOrders.GetCartItems();
    for i: Integer := 0 to myOrderList.Count-1 do begin
      encoder['L_PAYMENTREQUEST_0_NAME' + i] := myOrderList[i].Product.Productname.ToString();
      encoder['L_PAYMENTREQUEST_0_AMT' + i] := myOrderList[i].Product.Unitprice.ToString.Replace(',','.');
      encoder['L_PAYMENTREQUEST_0_QTY' + i] := myOrderList[i].Quantity.ToString();
    end;
  end;
  var pStrrequestforNvp: String := encoder.Encode();
  var pStresponsenvp: String := HttpCall(pStrrequestforNvp);
  var decoder: NVPCodec := new NVPCodec();
  decoder.Decode(pStresponsenvp);
  var strAck: String := decoder['ACK'].ToLower();
  if (strAck <> nil) and ((strAck = 'success') or (strAck = 'successwithwarning')) then begin
    token := decoder['TOKEN'];
    var ECURL: String := ((('https://' + host) + '/cgi-bin/webscr?cmd=_express-checkout') + '&token=') + token;
    retMsg := ECURL;
    exit true;
  end
  else begin
    retMsg := (((((('ErrorCode=' + decoder['L_ERRORCODE0']) + '&') + 'Desc=') + decoder['L_SHORTMESSAGE0']) + '&') + 'Desc2=') + decoder['L_LONGMESSAGE0'];
    exit false;
  end;
end;


method NVPAPICaller.GetCheckoutDetails(token: String; var PayerID: String; var decoder: NVPCodec; var retMsg: String): Boolean;
begin
  if bSandbox then begin
    pEndPointURL := pEndPointURL_SB;
  end;
  var encoder: NVPCodec := new NVPCodec();
  encoder['METHOD'] := 'GetExpressCheckoutDetails';
  encoder['TOKEN'] := token;
  var pStrrequestforNvp: String := encoder.Encode();
  var pStresponsenvp: String := HttpCall(pStrrequestforNvp);
  decoder := new NVPCodec();
  decoder.Decode(pStresponsenvp);
  var strAck: String := decoder['ACK'].ToLower();
  if (strAck <> nil) and ((strAck = 'success') or (strAck = 'successwithwarning')) then begin
    PayerID := decoder['PAYERID'];
    exit true;
  end
  else begin
    retMsg := (((((('ErrorCode=' + decoder['L_ERRORCODE0']) + '&') + 'Desc=') + decoder['L_SHORTMESSAGE0']) + '&') + 'Desc2=') + decoder['L_LONGMESSAGE0'];
    exit false;
  end;
end;

method NVPAPICaller.DoCheckoutPayment(finalPaymentAmount: String; token: String; PayerID: String; var decoder: NVPCodec; var retMsg: String): Boolean;
begin
  if bSandbox then begin
    pEndPointURL := pEndPointURL_SB;
  end;
  var encoder: NVPCodec := new NVPCodec();
  encoder['METHOD'] := 'DoExpressCheckoutPayment';
  encoder['TOKEN'] := token;
  encoder['PAYERID'] := PayerID;
  encoder['PAYMENTREQUEST_0_AMT'] := finalPaymentAmount.Replace(',','.');
  encoder['PAYMENTREQUEST_0_CURRENCYCODE'] := 'EUR';
  encoder['PAYMENTREQUEST_0_PAYMENTACTION'] := 'Sale';
  var pStrrequestforNvp: String := encoder.Encode();
  var pStresponsenvp: String := HttpCall(pStrrequestforNvp);
  decoder := new NVPCodec();
  decoder.Decode(pStresponsenvp);
  var strAck: String := decoder['ACK'].ToLower();
  if (strAck <> nil) and ((strAck = 'success') or (strAck = 'successwithwarning')) then begin
    exit true;
  end
  else begin
    retMsg := (((((('ErrorCode=' + decoder['L_ERRORCODE0']) + '&') + 'Desc=') + decoder['L_SHORTMESSAGE0']) + '&') + 'Desc2=') + decoder['L_LONGMESSAGE0'];
    exit false;
  end;
end;

method NVPAPICaller.HttpCall(NvpRequest: String): String;
begin
  var url: String := pEndPointURL;
  var strPost: String := (NvpRequest + '&') + buildCredentialsNVPString();
  strPost := (strPost + '&BUTTONSOURCE=') + HttpUtility.UrlEncode(BNCode);
  var objRequest: HttpWebRequest := HttpWebRequest(WebRequest.&Create(url));
  objRequest.Timeout := Timeout;
  objRequest.&Method := 'POST';
  objRequest.ContentLength := strPost.Length;
  try
    using myWriter: StreamWriter := new StreamWriter(objRequest.GetRequestStream()) do
    begin
      myWriter.Write(strPost);
    end;
  except
    on e: Exception do
    begin
      //  Log the exception.
      NorpaNet.Logic.ExceptionUtility.LogException(e, 'HttpCall in PayPalFunction.pas');
    end;
  end;
  //  Retrieve the Response returned from the NVP API call to PayPal.
  var objResponse: HttpWebResponse := HttpWebResponse(objRequest.GetResponse());
  var fresult: String;
  using sr: StreamReader := new StreamReader(objResponse.GetResponseStream()) do
  begin
    fresult := sr.ReadToEnd();
  end;
  exit fresult;
end;

method NVPAPICaller.buildCredentialsNVPString: String;
begin
  var codec: NVPCodec := new NVPCodec();
  if not IsEmpty(APIUsername) then
    codec['USER'] := APIUsername;
  if not IsEmpty(APIPassword) then
    codec[PWD] := APIPassword;
  if not IsEmpty(APISignature) then
    codec[SIGNATURE] := APISignature;
  if not IsEmpty(Subject) then
    codec['SUBJECT'] := Subject;
  codec['VERSION'] := '88.0';
  exit codec.Encode();
end;

class method NVPAPICaller.IsEmpty(s: String): Boolean;
begin
  exit (s = nil) or (s.Trim() = String.&Empty);
end;


method NVPCodec.Encode: String;
begin
  var sb: StringBuilder := new StringBuilder();
  var firstPair: Boolean := true;
  for each kv: String in AllKeys do begin
    var name: String := HttpUtility.UrlEncode(kv);
    var value: String := HttpUtility.UrlEncode(self[kv]);
    if not firstPair then begin
      sb.Append(AMPERSAND);
    end;
    sb.Append(name).Append(&EQUALS).Append(value);
    firstPair := false;
  end;
  exit sb.ToString();
end;

method NVPCodec.Decode(nvpstring: String);
begin
  Clear();
  for each nvp: String in nvpstring.Split(AMPERSAND_CHAR_ARRAY) do begin
    var tokens: array of String := nvp.Split(EQUALS_CHAR_ARRAY);
    if tokens.Length >= 2 then begin
      var name: String := HttpUtility.UrlDecode(tokens[0]);
      var value: String := HttpUtility.UrlDecode(tokens[1]);
      self.Add(name, value);
    end;
  end;
end;

method NVPCodec.Add(name: String; value: String; index: Integer);
begin
  self.Add(GetArrayName(index, name), value);
end;

method NVPCodec.Remove(arrayName: String; index: Integer);
begin
  self.Remove(GetArrayName(index, arrayName));
end;

method NVPCodec.GetArrayName(index: Integer; name: String): String;
begin
  if index < 0 then begin
    raise new ArgumentOutOfRangeException('index', 'index cannot be negative : ' + index);
  end;
  exit name + index;
end;

end.



