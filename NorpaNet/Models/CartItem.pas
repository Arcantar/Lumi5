namespace NorpaNet.Models;

interface

uses
  NorpaNet.Data;

type
  [Serializable()]
  CartItem = public class
  private
    _ItemId: Guid;
    _CartId: Guid;
    _Quantity: Integer;
    _DateCreated: System.DateTime;
    _ProductId: Int64;
    _Product: Product;
  public
    constructor(ItemId : Guid);
    property ItemId: Guid read _ItemId write _ItemId;
    property CartId: Guid read _CartId write _CartId;
    property Quantity: Integer read _Quantity write _Quantity;
    property DateCreated: System.DateTime read _DateCreated write _DateCreated;
    property ProductId: Int64 read _ProductId write _ProductId;
    property Product: Product read _Product;
  end;

implementation

constructor CartItem(ItemId: Guid);
begin

end;

end.
