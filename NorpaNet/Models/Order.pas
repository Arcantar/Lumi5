namespace NorpaNet.Models;

interface

uses
  System.ComponentModel.DataAnnotations,
  System.Collections.Generic,
  System.ComponentModel;

type
  [Serializable()]
  &Order = public class
  public
    property OrderId: Integer;
    property OrderDate: System.DateTime;
    property Username: String;
    property FirstName: String;
    property LastName: String;
    property Address: String;
    property City: String;
    property State: String;
    property PostalCode: String;
    property Country: String;
    property Phone: String;
    property Email: String;
    property Total: Decimal;
    property PaymentTransactionId: String;
    property HasBeenShipped: Boolean;
    property OrderDetails: List<OrderDetail>;
  end;

implementation

end.
