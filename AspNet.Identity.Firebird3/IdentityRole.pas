namespace AspNet.Identity.Firebird3;

interface

uses
  Microsoft.AspNet.Identity,
  System;

type
  /// <summary>
  /// Class that implements the ASP.NET Identity
  /// IRole interface
  /// </summary>
  IdentityRole = public class(IRole)
  public
    /// <summary>
    /// Role ID
    /// </summary>
    property Id: String;
    /// <summary>
    /// Role name
    /// </summary>
    property Name: String;
    /// <summary>
    /// Default constructor for Role
    /// </summary>
    constructor;
    /// <summary>
    /// Constructor that takes names as argument
    /// </summary>
    /// <param name="name"></param>
    constructor(name: String);
    constructor(name: String; id: String);
  end;

implementation

constructor IdentityRole;
begin
  Id := Guid.NewGuid().ToString();
end;

constructor IdentityRole(name: String);
begin
  name := name;
end;

constructor IdentityRole(name: String; id: String);
begin
  name := name;
  id := id;
end;








end.

