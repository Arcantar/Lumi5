namespace NorpaNet.Models;

interface

uses
  System.ComponentModel.DataAnnotations;

type
  [Serializable()]
  OrderDetail = public class
  public
    property OrderDetailId: Integer;
    property OrderId: Integer;
    property Username: String;
    property ProductId: Integer;
    property Quantity: Integer;
    property UnitPrice : nullable Double;
  end;

implementation

end.
