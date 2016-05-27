namespace NorpaNet.Logic;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Web,
  System.IO;

type
  ExceptionUtility = public class
  private
    //  All methods are static, so this can be private
    constructor;
  public
    //  Log an Exception
    class method LogException(exc: Exception; source: String);
  end;

implementation

constructor ExceptionUtility;
begin
end;

class method ExceptionUtility.LogException(exc: Exception; source: String);
begin
  //  Include logic for logging exceptions
  //  Get the absolute path to the log file
  var logFile: String := '~/App_Data/ErrorLog.txt';
  logFile := HttpContext.Current.Server.MapPath(logFile);
  //  Open the log file for append and write the log
  var sw: StreamWriter := new StreamWriter(logFile, true);
  sw.WriteLine('********** {0} **********', DateTime.Now);
  if exc = nil then sw.WriteLine(source) else begin
    if exc.InnerException <> nil then begin
      sw.&Write('Inner Exception Type: ');
      sw.WriteLine(exc.InnerException.GetType().ToString());
      sw.&Write('Inner Exception: ');
      sw.WriteLine(exc.InnerException.Message);
      sw.&Write('Inner Source: ');
      sw.WriteLine(exc.InnerException.Source);
      if exc.InnerException.StackTrace <> nil then begin
        sw.WriteLine('Inner Stack Trace: ');
        sw.WriteLine(exc.InnerException.StackTrace);
      end;
    end;
    sw.&Write('Exception Type: ');
    sw.WriteLine(exc.GetType().ToString());
    sw.WriteLine('Exception: ' + exc.Message);
    sw.WriteLine('Source: ' + source);
    sw.WriteLine('Stack Trace: ');
    if exc.StackTrace <> nil then begin
      sw.WriteLine(exc.StackTrace);
      sw.WriteLine();
    end;
  end;
  sw.Close();
end;

end.
