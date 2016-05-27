namespace NorpaNet;

interface

uses
  System.Linq,
  System.Web,
  System.Web.UI;

type
  _Default = public partial class(System.Web.UI.Page)  
  protected
    method Page_Load(sender: Object; e: EventArgs);
  private
    method Page_Error(sender: Object; e: EventArgs);
  end;

implementation

method _Default.Page_Load(sender: Object; e: EventArgs);
begin
end;


method _Default.Page_Error(sender: Object; e: EventArgs);
begin
 //  Get last error from the server.
 var exc: Exception := Server.GetLastError();
 //  Handle specific exception.
 if exc is InvalidOperationException then begin
   //  Pass the error on to the error page.
   Server.Transfer('ErrorPage.aspx?handler=Page_Error%20-%20Default.aspx', true);
 end;
end;

end.
