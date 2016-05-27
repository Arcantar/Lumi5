namespace NorpaNet;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  NorpaNet.Logic;

type
  ErrorPage = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

method ErrorPage.Page_Load(sender: Object; e: EventArgs);
begin
  //  Create safe error messages.
  var generalErrorMsg: String := 'A problem has occurred on this web site. Please try again. ' + 'If this error continues, please contact support.';
  var httpErrorMsg: String := 'An HTTP error occurred. Page Not found. Please try again.';
  var unhandledErrorMsg: String := 'The error was unhandled by application code.';
  //  Display safe error message.
  FriendlyErrorMsg.Text := generalErrorMsg;
  //  Determine where error was handled.
  var errorHandlerstr: String := Request.QueryString['handler'];
  if errorHandlerstr = nil then begin
    errorHandlerstr := 'Error Page';
  end;
  //  Get the last error from the server.
  var ex: Exception := Server.GetLastError();
  //  Get the error number passed as a querystring value.
  var errorMsg: String := Request.QueryString['msg'];
  if errorMsg = '404' then begin
    ex := new HttpException(404, httpErrorMsg, ex);
    FriendlyErrorMsg.Text := ex.Message;
  end;
  //  If the exception no longer exists, create a generic exception.
  if ex = nil then begin
    ex := new Exception(unhandledErrorMsg);
  end;
  //  Show error details to only you (developer). LOCAL ACCESS ONLY.
  if Request.IsLocal then begin
    //  Detailed Error Message.
    ErrorDetailedMsg.Text := ex.Message;
    //  Show where the error was handled.
    ErrorHandler.Text := errorHandlerstr;
    //  Show local access details.
    DetailedErrorPanel.Visible := true;
    if ex.InnerException <> nil then begin
      InnerMessage.Text := (ex.GetType().ToString() + '<br/>') + ex.InnerException.Message;
      InnerTrace.Text := ex.InnerException.StackTrace;
    end
    else begin
      InnerMessage.Text := ex.GetType().ToString();
      if ex.StackTrace <> nil then begin
        InnerTrace.Text := ex.StackTrace.ToString().TrimStart();
      end;
    end;
  end;
  //  Log the exception.
  ExceptionUtility.LogException(ex, errorHandlerstr);
  //  Clear the error from the server.
  Server.ClearError();
end;

end.
