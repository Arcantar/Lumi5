namespace NorpaNet.Data;

interface

type
  Icartitems = public interface
    Property Itemid                          : System.Guid     read write;
    Property Cartid                          : System.Guid     read write;
    Property Quantity                        : System.Int32    read write;
    Property Datecreated                     : System.DateTime read write;
    Property Productid                       : System.Int64    read write;
    property Product                         : Iproducts       read write;
  end;

implementation

end.
