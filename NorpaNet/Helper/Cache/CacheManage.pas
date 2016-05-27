namespace NorpaNet.Helper.Cache;

interface

uses
  System;
type
  ICache = public interface
    method Get<T>(cacheKey: System.String): T;
    method GetObject(cacheKey: System.String): System.Object;
    method &Add(cacheKey: System.String; absoluteExpiry: DateTime; dataToAdd: System.Object);
    method &Add(cacheKey: System.String; slidingExpiryWindow: TimeSpan; dataToAdd: System.Object);
    method InvalidateCacheItem(cacheKey: System.String);
    method exists(cacheKey: System.String):Boolean;
    method AddToPerRequestCache(cacheKey: System.String; dataToAdd: System.Object);
  end;

type
  CacheManager = public static class
  private
    class var     _cacheProvider: ICacheProvider;
    class var     _cache: ICache;

    const     AppFabricProvider: System.String = 'NorpaNet.Helper.Cache, norpa.Web';

    class constructor ;

  public
    class method PreStartInitialise;

    class property Cache: ICacheProvider read _cacheProvider;
  end;


implementation


class constructor CacheManager;
begin
  PreStartInitialise()

end;

class method CacheManager.PreStartInitialise;
begin
  _cache := new MemoryCacheAdapter();
 _cacheProvider := new CacheProvider(_cache)
end;


end.