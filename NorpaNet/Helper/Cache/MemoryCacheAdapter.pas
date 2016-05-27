namespace NorpaNet.Helper.Cache;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.Runtime.Caching;







type
  MemoryCacheAdapter = public class(ICache)
  private
    var     _cache: MemoryCache := MemoryCache.Default;


  public
    constructor ;

  private

  public
    method &Add(cacheKey: System.String; expiry: DateTime; dataToAdd: System.Object);

    method GetObject(cacheKey: System.String): System.Object;

    method Get<T>(cacheKey: System.String): T;

    method InvalidateCacheItem(cacheKey: System.String);

    method &Add(cacheKey: System.String; slidingExpiryWindow: TimeSpan; dataToAdd: System.Object);

    method AddToPerRequestCache(cacheKey: System.String; dataToAdd: System.Object);

    method exists(cacheKey: System.String): Boolean;


  end;


implementation


constructor MemoryCacheAdapter;
begin


end;


method MemoryCacheAdapter.&Add(cacheKey: System.String; expiry: DateTime; dataToAdd: System.Object);
begin
  var policy := new CacheItemPolicy();
  policy.AbsoluteExpiration := new DateTimeOffset(expiry);

  if dataToAdd <> nil then begin
    _cache.Add(cacheKey, dataToAdd, policy);
  end

end;

method MemoryCacheAdapter.GetObject(cacheKey: System.String): System.Object;
begin
  exit _cache.Get(cacheKey)
end;

method MemoryCacheAdapter.Get<T>(cacheKey: System.String): T;
begin
  var data: T := T(_cache.Get(cacheKey));
  exit data
end;

method MemoryCacheAdapter.InvalidateCacheItem(cacheKey: System.String);
begin
  if _cache.Contains(cacheKey) then    _cache.Remove(cacheKey)
end;

method MemoryCacheAdapter.exists(cacheKey: System.String):Boolean;
begin
  exit _cache.Contains(cacheKey);
end;

method MemoryCacheAdapter.&Add(cacheKey: System.String; slidingExpiryWindow: TimeSpan; dataToAdd: System.Object);
begin
  if dataToAdd <> nil then begin
    var item := new CacheItem(cacheKey, dataToAdd);
    var policy := new CacheItemPolicy(
      SlidingExpiration := slidingExpiryWindow);
    _cache.Add(item, policy);
  end

end;

method MemoryCacheAdapter.AddToPerRequestCache(cacheKey: System.String; dataToAdd: System.Object);
begin
// memory cache does not have a per request concept nor does it need to since all cache nodes should be in sync
// You could simulate this in code with a dependency on the ASP.NET framework and its inbuilt request
// objects but we wont do that here. We simply add it into the cache for 1 second.
// Its hacky but this behaviour will be specific to the scenario at hand.
  &Add(cacheKey, TimeSpan.FromSeconds(150), dataToAdd)
end;




end.

