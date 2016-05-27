namespace AspNet.Identity.Firebird3;

interface

uses
  Microsoft.AspNet.Identity,
  System,
  System.Linq,
  System.Threading.Tasks;


type
  /// <summary>
  /// Class that implements the key ASP.NET Identity role store iterfaces
  /// </summary>
  RoleStore<TRole> = public class(IQueryableRoleStore<TRole>)
  where TRole is IdentityRole;
  private
    var roleTable: RoleTable;
  public
    property Database: FBDatabase;
    property Roles: IQueryable<TRole> read getRoles;
  private
    method getRoles: IQueryable<TRole>;
  public
    /// <summary>
    /// Default constructor that initializes a new FBDatabase
    /// instance using the Default Connection string
    /// </summary>
    constructor;
    /// <summary>
    /// Constructor that takes a FBDatabase as argument
    /// </summary>
    /// <param name="database"></param>
    constructor(database: FBDatabase);
    method CreateAsync(role: TRole): Task;
    method DeleteAsync(role: TRole): Task;
    method FindByIdAsync(roleId: String): Task<TRole>;
    method FindByNameAsync(roleName: String): Task<TRole>;
    method UpdateAsync(role: TRole): Task;
    method Dispose;
  end;

implementation

method RoleStore<TRole>.getRoles: IQueryable<TRole>;
begin
  raise new NotImplementedException();
end;

constructor RoleStore<TRole>;
begin
  new RoleStore<TRole>(new FBDatabase());
end;

constructor RoleStore<TRole>(database: FBDatabase);
begin
  database := database;
  roleTable := new RoleTable(database);
end;

method RoleStore<TRole>.CreateAsync(role: TRole): Task;
begin
  if role = nil then begin
    raise new ArgumentNullException('role');
  end;
  
  exit Task.FromResult(roleTable.Insert(role));
end;

method RoleStore<TRole>.DeleteAsync(role: TRole): Task;
begin
  if role = nil then begin
    raise new ArgumentNullException('user');
  end;
  
  exit Task.FromResult(roleTable.Delete(role.Id));
end;

method RoleStore<TRole>.FindByIdAsync(roleId: String): Task<TRole>;
begin
  var fresult: TRole := TRole(roleTable.GetRoleById(roleId));
  exit Task.FromResult(fresult);
end;

method RoleStore<TRole>.FindByNameAsync(roleName: String): Task<TRole>;
begin
  var fresult: TRole := TRole(roleTable.GetRoleByName(roleName));
  exit Task.FromResult(fresult);
end;

method RoleStore<TRole>.UpdateAsync(role: TRole): Task;
begin
  if role = nil then begin
    raise new ArgumentNullException('user');
  end;

  exit Task.FromResult( roleTable.Update(role));
end;

method RoleStore<TRole>.Dispose;
begin
  if Database <> nil then begin
    Database.Dispose();
    Database := nil;
  end;
end;

end.
