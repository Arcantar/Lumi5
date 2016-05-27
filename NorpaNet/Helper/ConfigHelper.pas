namespace NorpaNet.Helper;

interface

uses
  System,
  System.Configuration,
  System.Globalization,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls;

type
  ConfigHelper = public static class
  public
    class method GetBoolProperty(key: System.String; defaultValue: System.Boolean): System.Boolean;

    class method GetBoolProperty(key: System.String; defaultValue: System.Boolean; byPassContext: System.Boolean): System.Boolean;


  private
    class method GetBoolSettingFromContext(key: System.String; defaultValue: System.Boolean): System.Boolean;

    class method GetBoolPropertyFromConfig(key: System.String; defaultValue: System.Boolean): System.Boolean;

  public
    class method GetStringProperty(key: System.String; defaultValue: System.String): System.String;

  private
    class method GetStringPropertyFromConfig(key: System.String; defaultValue: System.String): System.String;

    class method GetStringSettingFromContext(key: System.String; defaultValue: System.String): System.String;


  public
    class method GetIntProperty(key: System.String; defaultValue: System.Int32): System.Int32;

    class method GetLongProperty(key: System.String; defaultValue: System.Int64): System.Int64;

    class method GetUnit(key: System.String; defaultValue: &Unit): &Unit;

  end;


implementation


class method ConfigHelper.GetBoolProperty(key: System.String; defaultValue: System.Boolean): System.Boolean;
begin
  exit GetBoolSettingFromContext(key, defaultValue)
end;



class method ConfigHelper.GetBoolProperty(key: System.String; defaultValue: System.Boolean; byPassContext: System.Boolean): System.Boolean;
begin
  if byPassContext then    exit GetBoolPropertyFromConfig(key, defaultValue);
  exit GetBoolSettingFromContext(key, defaultValue)
end;



class method ConfigHelper.GetBoolSettingFromContext(key: System.String; defaultValue: System.Boolean): System.Boolean;
begin
  if (HttpContext.Current = nil) then begin
    exit GetBoolPropertyFromConfig(key, defaultValue)
  end else begin
    var setting: System.Boolean;
    if HttpContext.Current.Items[key] = nil then begin
      setting := GetBoolPropertyFromConfig(key, defaultValue);
      HttpContext.Current.Items[key] := setting
    end
    else begin
      setting := System.Boolean(HttpContext.Current.Items[key])
    end;
    exit setting
  end;
end;



class method ConfigHelper.GetBoolPropertyFromConfig(key: System.String; defaultValue: System.Boolean): System.Boolean;
begin
  if ConfigurationManager.AppSettings[key] = nil then    exit defaultValue;
  if ( ConfigurationManager.AppSettings[key].IsCaseInsensitiveMatch('true')) then exit true;
  if ( ConfigurationManager.AppSettings[key].IsCaseInsensitiveMatch('false')) then exit false;
  exit defaultValue
end;



class method ConfigHelper.GetStringProperty(key: System.String; defaultValue: System.String): System.String;
begin
  exit GetStringSettingFromContext(key, defaultValue)
end;

class method ConfigHelper.GetStringPropertyFromConfig(key: System.String; defaultValue: System.String): System.String;
begin
  if ConfigurationManager.AppSettings[key] = nil then    exit defaultValue;
  exit ConfigurationManager.AppSettings[key]
end;

class method ConfigHelper.GetStringSettingFromContext(key: System.String; defaultValue: System.String): System.String;
begin
  if HttpContext.Current = nil then begin
    exit GetStringPropertyFromConfig(key, defaultValue)
  end;

  var setting: System.String;
  if HttpContext.Current.Items[key] = nil then begin
    setting := GetStringPropertyFromConfig(key, defaultValue);
    HttpContext.Current.Items[key] := setting
  end
  else begin
    setting := HttpContext.Current.Items[key].ToString()
  end;
  exit setting
end;



class method ConfigHelper.GetIntProperty(key: System.String; defaultValue: System.Int32): System.Int32;
begin
  var setting: System.Int32;
  exit iif(System.Int32.TryParse(ConfigurationManager.AppSettings[key], out setting), setting, defaultValue)
end;

class method ConfigHelper.GetLongProperty(key: System.String; defaultValue: System.Int64): System.Int64;
begin
  var setting: System.Int64;
  exit iif(System.Int64.TryParse(ConfigurationManager.AppSettings[key], out setting), setting, defaultValue)
end;

class method ConfigHelper.GetUnit(key: System.String; defaultValue: &Unit): &Unit;
begin
  if ConfigurationManager.AppSettings[key] <> nil then begin
    exit &Unit.Parse(ConfigurationManager.AppSettings[key], CultureInfo.InvariantCulture)
  end;
  exit defaultValue
end;

end.
