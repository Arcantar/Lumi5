namespace NorpaNet.Models;

interface

uses
  System.ComponentModel.DataAnnotations;

type
  [Serializable()]
  Product = public class
  public
    property ProductID: Integer;
    property ProductName: String;
    property Description: String;
    property ImagePath: String;
    property UnitPrice: nullable Double;
    property CategoryID: nullable Integer;
    property Category: Category;
  end;

implementation

end.
