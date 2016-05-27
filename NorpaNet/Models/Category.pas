namespace NorpaNet.Models;

interface

uses
  System.Collections.Generic,
  System.ComponentModel.DataAnnotations;

type
  [Serializable()]
  Category = public class
  public
    property CategoryID: Integer;
    property CategoryName: String;
    property Description: String;
    property Products: ICollection<Product>;
  end;

implementation

end.
