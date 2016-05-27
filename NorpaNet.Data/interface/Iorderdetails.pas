namespace NorpaNet.Data;

interface

type
  Iorderdetails = public interface
    Property Orderdetailid                   : System.Int64    read write;
    Property Orderid                         : System.Int64    read write;
    Property Username                        : System.String   read write;
    Property Productid                       : System.Int64    read write;
    Property Quantity                        : System.Int32    read write;
    Property Unitprice                       : System.Double   read write;
  end;

implementation

end.
