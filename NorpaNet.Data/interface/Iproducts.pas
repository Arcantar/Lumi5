namespace NorpaNet.Data;

interface

type
  Iproducts = public interface
    Property Productid                       : System.Int64    read write;
    Property Productname                     : System.String   read write;
    Property Description                     : System.String   read write;
    Property Imagepath                       : System.String   read write;
    Property Unitprice                       : System.Double   read write;
    Property Categoryid                      : System.Int64    read write;
  end;

implementation

end.
