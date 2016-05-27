namespace NorpaNet.Data;

interface

type
  Iorders = public interface
    Property Orderid                         : System.Int64    read write;
    Property Orderdate                       : System.DateTime read write;
    Property Username                        : System.String   read write;
    Property Firstname                       : System.String   read write;
    Property Lastname                        : System.String   read write;
    Property Address                         : System.String   read write;
    Property City                            : System.String   read write;
    Property State                           : System.String   read write;
    Property Postalcode                      : System.String   read write;
    Property Country                         : System.String   read write;
    Property Phone                           : System.String   read write;
    Property Email                           : System.String   read write;
    Property Total                           : System.Decimal    read write;
    Property Paymenttransactionid            : System.String   read write;
    Property Hasbeenshipped                  : System.String   read write;
  end;

implementation

end.
