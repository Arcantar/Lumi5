namespace WingtipToysForFireBird3.Models;

interface

uses
  System.Collections.Generic,
  System.Data.Entity;

type
  ProductDatabaseInitializer = public class(DropCreateDatabaseIfModelChanges)
  protected
    method Seed(context: ProductContext); virtual;
  private
    class method GetCategories: List<Category>;
    class method GetProducts: List<Product>;
  end;

implementation

method ProductDatabaseInitializer.Seed(context: ProductContext);
begin
  GetCategories().ForEach(c -> context.Categories.&Add(c));
  GetProducts().ForEach(p -> context.Products.&Add(p));
end;

class method ProductDatabaseInitializer.GetCategories: List<Category>;
begin
  var categories := new List<Category>(new Category(1, 'Cars'), new Category(2, 'Planes'), new Category(3, 'Trucks'), new Category(4, 'Boats'), new Category(5, 'Rockets'));
  exit categories;
end;

class method ProductDatabaseInitializer.GetProducts: List<Product>;
begin
  var products := new List<Product>(new Product(1, 'Convertible Car', 'This convertible car is fast! The engine is powered by a neutrino based battery (not included).' + 'Power it up and let it go!', 'carconvert.png', 22.5, 1), new Product(2, 'Old-time Car', 'There''s nothing old about this toy car, except it''s looks. Compatible with other old toy cars.', 'carearly.png', 15.95, 1), new Product(3, 'Fast Car', 'Yes this car is fast, but it also floats in water.', 'carfast.png', 32.99, 1), new Product(4, 'Super Fast Car', 'Use this super fast car to entertain guests. Lights and doors work!', 'carfaster.png', 8.95, 1), new Product(5, 'Old Style Racer', 'This old style racer can fly (with user assistance). Gravity controls flight duration.' + 'No batteries required.', 'carracer.png', 34.95, 1), new Product(6, 'Ace Plane', 'Authentic airplane toy. Features realistic color and details.', 'planeace.png', 95, 2), new Product(7, 'Glider', 'This fun glider is made from real balsa wood. Some assembly required.', 'planeglider.png', 4.95, 2), new Product(8, 'Paper Plane', 'This paper plane is like no other paper plane. Some folding required.', 'planepaper.png', 2.95, 2), new Product(9, 'Propeller Plane', 'Rubber band powered plane features two wheels.', 'planeprop.png', 32.95, 2), new Product(10, 'Early Truck', 'This toy truck has a real gas powered engine. Requires regular tune ups.', 'truckearly.png', 15, 3), new Product(11, 'Fire Truck', 'You will have endless fun with this one quarter sized fire truck.', 'truckfire.png', 26, 3), new Product(12, 'Big Truck', 'This fun toy truck can be used to tow other trucks that are not as big.', 'truckbig.png', 29, 3), new Product(13, 'Big Ship', 'Is it a boat or a ship. Let this floating vehicle decide by using its ' + 'artifically intelligent computer brain!', 'boatbig.png', 95, 4), new Product(14, 'Paper Boat', 'Floating fun for all! This toy boat can be assembled in seconds. Floats for minutes!' + 'Some folding required.', 'boatpaper.png', 4.95, 4), new Product(15, 'Sail Boat', 'Put this fun toy sail boat in the water and let it go!', 'boatsail.png', 42.95, 4), new Product(16, 'Rocket', 'This fun rocket will travel up to a height of 200 feet.', 'rocket.png', 122.95, 5));
  exit products;
end;

end.
