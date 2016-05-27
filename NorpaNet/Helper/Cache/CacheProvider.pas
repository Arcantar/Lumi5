namespace NorpaNet.Helper.Cache;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text;

type
  GetDataToCacheDelegate<T> = public delegate: T;

  ICacheProvider = public interface
    method Get<T>(cacheKey: System.String; absoluteExpiryDate: DateTime; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
    method Getex<T>(cacheKey: System.String; absoluteExpiryDate: DateTime; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
    method Get<T>(cacheKey: System.String; absoluteExpiryDate: DateTime; addToPerRequestCache: System.Boolean): T;
    method Get<T>(cacheKey: System.String; slidingExpiryWindow: TimeSpan; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
    method GetObject(cacheKey: System.String): System.Object;
    method InvalidateCacheItem(cacheKey: System.String);
    method &Add(cacheKey: System.String; absoluteExpiryDate: DateTime; dataToAdd: System.Object);
    method &Add(cacheKey: System.String; slidingExpiryWindow: TimeSpan; dataToAdd: System.Object);
    method AddToPerRequestCache(cacheKey: System.String; dataToAdd: System.Object);
  end;


/// <summary>
/// This class acts as a cache provider that will attempt to retrieve items from a cache, and if they do not exist,
/// execute the passed in delegate to perform a data retrieval, then place the item into the cache before returning it.
/// Subsequent accesses will get the data from the cache until it expires.
/// </summary>
type
  CacheProvider = public class(ICacheProvider)
  private
    var     _cache: ICache;


  public
    constructor (cache: ICache);
{$region ICacheProvider Members}

    method GetObject(cacheKey: System.String): System.Object;

    method Get<T>(cacheKey: System.String; expiryDate: DateTime; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
    method Getex<T>(cacheKey: System.String; expiryDate: DateTime; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
    method Get<T>(cacheKey: System.String; expiryDate: DateTime; addToPerRequestCache: System.Boolean): T;
    method Get<T>(cacheKey: System.String; slidingExpiryWindow: TimeSpan; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
    method InvalidateCacheItem(cacheKey: System.String);
    method &Add(cacheKey: System.String; absoluteExpiryDate: DateTime; dataToAdd: System.Object);
    method &Add(cacheKey: System.String; slidingExpiryWindow: TimeSpan; dataToAdd: System.Object);
    method AddToPerRequestCache(cacheKey: System.String; dataToAdd: System.Object);

  end;



implementation


constructor CacheProvider(cache: ICache);
begin
  _cache := cache

end;

method CacheProvider.GetObject(cacheKey: System.String): System.Object;
begin
  exit _cache.GetObject(cacheKey)
end;

method CacheProvider.Getex<T>(cacheKey: System.String; expiryDate: DateTime; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
 begin
     Get(cacheKey,expiryDate,getData,addToPerRequestCache);
 end;

 method CacheProvider.Get<T>(cacheKey: System.String; expiryDate: DateTime; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
 begin
//Get data from cache
var data: T := _cache.Get<T>(cacheKey);
if data = nil then begin
  //get data from source
  data := getData();

  //only add non null data to the cache.
  if data <> nil then begin
    if addToPerRequestCache then begin
      _cache.AddToPerRequestCache(cacheKey, data)
    end
    else begin
      _cache.Add(cacheKey, expiryDate, data);
    end
  end
end;
exit data
end;

 method CacheProvider.Get<T>(cacheKey: System.String; expiryDate: DateTime;  addToPerRequestCache: System.Boolean): T;
 begin
//Get data from cache
var data: T := _cache.Get<T>(cacheKey);
exit data
end;


method CacheProvider.Get<T>(cacheKey: System.String; slidingExpiryWindow: TimeSpan; getData: GetDataToCacheDelegate<T>; addToPerRequestCache: System.Boolean): T;
begin
var data: T := _cache.Get<T>(cacheKey);
if data = nil then begin
  //get data from source
  data := getData();

  //only add non null data to the cache.
  if data <> nil then begin
    if addToPerRequestCache then begin
      _cache.AddToPerRequestCache(cacheKey, data)
    end
    else begin
      _cache.Add(cacheKey, slidingExpiryWindow, data);
    end
  end
end;
exit data

end;



method CacheProvider.InvalidateCacheItem(cacheKey: System.String);
begin
  _cache.InvalidateCacheItem(cacheKey);
end;

method CacheProvider.&Add(cacheKey: System.String; absoluteExpiryDate: DateTime; dataToAdd: System.Object);
begin
  _cache.Add(cacheKey, absoluteExpiryDate, dataToAdd);
end;

method CacheProvider.&Add(cacheKey: System.String; slidingExpiryWindow: TimeSpan; dataToAdd: System.Object);
begin
  _cache.Add(cacheKey, slidingExpiryWindow, dataToAdd);
end;

method CacheProvider.AddToPerRequestCache(cacheKey: System.String; dataToAdd: System.Object);
begin
  _cache.AddToPerRequestCache(cacheKey, dataToAdd);
end;



end.


