namespace NorpaNet.Helper;

interface

uses
  System,
  System.Collections.Generic,
  System.Globalization,
  System.Security,
  System.Text,
  System.Text.RegularExpressions,
  System.Web.Script.Serialization;


type
   [System.Runtime.CompilerServices.Extension]
  StringHelper = public static class

  public
    [System.Runtime.CompilerServices.Extension]
    class method IsCaseInsensitiveMatch(str1: System.String; str2: System.String): System.Boolean;

    [System.Runtime.CompilerServices.Extension]
    class method ContainsCaseInsensitive(source: System.String; value: System.String): System.Boolean;

    class method ToJsonString(jsonObj: System.Object): System.String;

    class method DecodeBase64String(base64String: System.String; encoding: Encoding): System.String;

    class method GetBase64EncodedUnicodeString(unicodeString: System.String): System.String;

    class method GetBase64EncodedAsciiString(unicodeString: System.String): System.String;



{$region string Extension Methods}

    [System.Runtime.CompilerServices.Extension]
    class method ToSerialDate(s: System.String): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method HtmlEscapeQuotes(s: System.String): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method RemoveCDataTags(s: System.String): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method CsvEscapeQuotes(s: System.String): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method RemoveAngleBrackets(s: System.String): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method Coalesce(s: System.String; alt: System.String): System.String;

/// <summary>
/// Converts a unicode string into its closest ascii equivalent
/// </summary>
/// <param name="s"></param>
/// <returns></returns>
    [System.Runtime.CompilerServices.Extension]
    class method ToAscii(s: System.String): System.String;

/// <summary>
/// Converts a unicode string into its closest ascii equivalent.
/// If the ascii encode string length is less than or equal to 1 returns the original string
/// as this means the string is probably in a language with no ascii equivalents
/// </summary>
/// <param name="s"></param>
/// <returns></returns>
    [System.Runtime.CompilerServices.Extension]
    class method ToAsciiIfPossible(s: System.String): System.String;

/// <summary>
/// Vire le catractère #160
/// et le remplace par un espace
/// </summary>
/// <param name="s"></param>
/// <returns></returns>
    [System.Runtime.CompilerServices.Extension]
    class method ToValideString(s: System.String): System.String;

/// <summary>
/// Remap International Chars To Ascii
/// http://meta.stackoverflow.com/questions/7435/non-us-ascii-characters-dropped-from-full-profile-url/7696#7696
/// </summary>
/// <param name="c"></param>
/// <returns></returns>
    [System.Runtime.CompilerServices.Extension]
    class method RemapInternationalCharToAscii(c: System.Char): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method RemoveNonNumeric(s: System.String): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method RemoveLineBreaks(s: System.String): System.String;


    [System.Runtime.CompilerServices.Extension]
    class method EscapeXml(s: System.String): System.String;

    [System.Runtime.CompilerServices.Extension]
    class method UnescapeXml(s: System.String): System.String;


    [System.Runtime.CompilerServices.Extension]
    class method SplitOnChar(s: System.String; c: System.Char): List<System.String>;

    [System.Runtime.CompilerServices.Extension]
    class method SplitOnCharAndTrim(s: System.String; c: System.Char): List<System.String>;

    [System.Runtime.CompilerServices.Extension]
    class method SplitOnPipes(s: System.String): List<System.String>;
    
    [System.Runtime.CompilerServices.Extension]
    class method ReplaceFirst(text: String; search: String; replace: String): String;

    [System.Runtime.CompilerServices.Extension]
    class method RemoveDiacritics(text: String): String;

    [System.Runtime.CompilerServices.Extension]
    class method indexOf_CA_CI_AI(text: String; partext:String): Int32;
    
    [System.Runtime.CompilerServices.Extension]    
    class method EgalString_CA_CI_AI( text: String; partext:String): Boolean;
    [System.Runtime.CompilerServices.Extension] 
    class method StringHtmlEncode(text: String): String;
{$endregion}

  end;


implementation


class method StringHelper.IsCaseInsensitiveMatch(str1: System.String; str2: System.String): System.Boolean;
begin
  exit System.String.Equals(str1, str2, StringComparison.InvariantCultureIgnoreCase)
end;



class method StringHelper.ContainsCaseInsensitive(source: System.String; value: System.String): System.Boolean;
begin
  var results: System.Int32 := source.IndexOf(value, StringComparison.CurrentCultureIgnoreCase);
  exit iif(results = -1, false, true)
end;

class method StringHelper.ToJsonString(jsonObj: System.Object): System.String;
begin
  exit new JavaScriptSerializer().Serialize(jsonObj)
end;

class method StringHelper.DecodeBase64String(base64String: System.String; encoding: Encoding): System.String;
begin
  if System.String.IsNullOrEmpty(base64String) then begin
    exit base64String
  end;
  var encodedBytes: array of System.Byte := Convert.FromBase64String(base64String);
  exit encoding.GetString(encodedBytes, 0, encodedBytes.Length)
end;


class method StringHelper.GetBase64EncodedUnicodeString(unicodeString: System.String): System.String;
begin
  var encoding: Encoding := encoding.Unicode;
  var bytes: array of System.Byte := encoding.GetBytes(unicodeString);

  exit System.Convert.ToBase64String(bytes)
end;


class method StringHelper.GetBase64EncodedAsciiString(unicodeString: System.String): System.String;
begin
  var encoding: Encoding := encoding.ASCII;
  var bytes: array of System.Byte := encoding.GetBytes(unicodeString);

  exit System.Convert.ToBase64String(bytes)
end;


class method StringHelper.ToSerialDate(s: System.String): System.String;
begin
  if s.Length = 8 then begin
    exit s.Substring(0, 4) + '-' + s.Substring(4, 2) + '-' + s.Substring(6, 2)
  end;
  exit s
end;

class method StringHelper.HtmlEscapeQuotes(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  exit s.Replace(#39, '&#39;').Replace('"', '&#34;')
end;


class method StringHelper.RemoveCDataTags(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  exit s.Replace('<![CDATA[', System.String.Empty).Replace(']]>', System.String.Empty)
end;


class method StringHelper.CsvEscapeQuotes(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  exit s.Replace('"', '""')
end;


class method StringHelper.RemoveAngleBrackets(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  exit s.Replace('<', System.String.Empty).Replace('>', System.String.Empty)
end;


class method StringHelper.Coalesce(s: System.String; alt: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit alt
  end;
  exit s
end;

class method StringHelper.ToAscii(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  try
    var normalized: System.String := s.Normalize(NormalizationForm.FormKD);

    var ascii: Encoding := Encoding.GetEncoding('us-ascii', new EncoderReplacementFallback(System.String.Empty), new DecoderReplacementFallback(System.String.Empty));

    var encodedBytes: array of System.Byte := new System.Byte[ascii.GetByteCount(normalized)];
    var numberOfEncodedBytes: System.Int32 := ascii.GetBytes(normalized, 0, normalized.Length, encodedBytes, 0);

    var newString: System.String := ascii.GetString(encodedBytes);

    exit newString
  
  except begin
      exit s
    end;
  end
end;

class method StringHelper.ToValideString(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  var len: System.Int32 := s.Length;
  var sb: StringBuilder := new StringBuilder(len);
  var c: System.Char;

    var i: System.Int32 := 0;
    while i < len do begin 
        c := s[i];

        //var tmpC : Integer := System.Int32(c);

        if c = #160 then c:=' ';
      
        sb.Append(c);
      
    inc(i);
  end;

  exit sb.ToString()
end;


class method StringHelper.ToAsciiIfPossible(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  s := s.Replace(#230, 'ae');
  s := s.Replace(#198, 'ae');
  s := s.Replace(#229, 'aa');
  s := s.Replace(#197, 'aa');

  var len: System.Int32 := s.Length;
  var sb: StringBuilder := new StringBuilder(len);
  var c: System.Char;

  begin
    var i: System.Int32 := 0;
    while i < len do begin begin
        c := s[i];
        if c = #160 then c:=' ';
        if System.Int32(c) >= 128 then begin
          sb.Append(RemapInternationalCharToAscii(c))
        end

        else begin
          sb.Append(c)
        end
      end;
      inc(i);
    end;
  end;
  exit sb.ToString()
end;



class method StringHelper.RemapInternationalCharToAscii(c: System.Char): System.String;
begin
  var s: System.String := c.ToString().ToLowerInvariant();
  if #224#229#225#226#228#227#229#261.Contains(s) then begin
    exit 'a'
  end
  else if #232#233#234#235#281.Contains(s) then begin
    exit 'e'
  end
  else if #236#237#238#239#305.Contains(s) then begin
    exit 'i'
  end
  else if #242#243#244#245#246#248#337#240.Contains(s) then begin
    exit 'o'
  end
  else if #249#250#251#252#365#367.Contains(s) then begin
    exit 'u'
  end
  else if #231#263#269#265.Contains(s) then begin
    exit 'c'
  end
  else if #380#378#382.Contains(s) then begin
    exit 'z'
  end
  else if #347#351#353#349.Contains(s) then begin
    exit 's'
  end
  else if #241#324.Contains(s) then begin
    exit 'n'
  end
  else if #253#255.Contains(s) then begin
    exit 'y'
  end
  else if #287#285.Contains(s) then begin
    exit 'g'
  end
  else if c = #345 then begin
    exit 'r'
  end
  else if c = #322 then begin
    exit 'l'
  end
  else if c = #273 then begin
    exit 'd'
  end
  else if c = #223 then begin
    exit 'ss'
  end
  else if c = #222 then begin
    exit 'th'
  end
  else if c = #293 then begin
    exit 'h'
  end
  else if c = #309 then begin
    exit 'j'
  end
  else begin
    exit System.String.Empty
  end
end;

class method StringHelper.RemoveNonNumeric(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  var fresult: array of System.Char := new System.Char[s.Length];
  var resultIndex: System.Int32 := 0;
  for each c: System.Char in s do begin
    if System.Char.IsNumber(c) then begin
      inc(resultIndex);
      fresult[resultIndex] := c
    end;
  end;
  if 0 = resultIndex then    s := System.String.Empty
  else if fresult.Length <> resultIndex then
    s := new System.String(fresult, 0, resultIndex);

  exit s
end;

class method StringHelper.RemoveLineBreaks(s: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(s) then begin
    exit s
  end;

  exit s.Replace(#13#10, System.String.Empty).Replace(#10, System.String.Empty).Replace(#13, System.String.Empty)
end;

class method StringHelper.EscapeXml(s: System.String): System.String;
begin
  var xml: System.String := s;
  if not System.String.IsNullOrEmpty(xml) then begin
// replace literal values with entities
    xml := xml.Replace('&', '&amp;');
    xml := xml.Replace('&lt;', '&lt;');
    xml := xml.Replace('&gt;', '&gt;');
    xml := xml.Replace('"', '&quot;');
    xml := xml.Replace(#39, '&apos;')
  end;
  exit xml
end;

class method StringHelper.UnescapeXml(s: System.String): System.String;
begin
  var unxml: System.String := s;
  if not System.String.IsNullOrEmpty(unxml) then begin
// replace entities with literal values
    unxml := unxml.Replace('&apos;', #39);
    unxml := unxml.Replace('&quot;', '"');
    unxml := unxml.Replace('&gt;', '&gt;');
    unxml := unxml.Replace('&lt;', '&lt;');
    unxml := unxml.Replace('&amp;', '&')
  end;
  exit unxml
end;

class method StringHelper.SplitOnChar(s: System.String; c: System.Char): List<System.String>;
begin
  var list: List<System.String> := new List<System.String>();
  if System.String.IsNullOrEmpty(s) then begin
    exit list
  end;

  var a: array of System.String := s.Split(c);
  for each item: System.String in a do begin
    if not System.String.IsNullOrEmpty(item) then begin
      list.Add(item)
    end
  end;


  exit list
end;

class method StringHelper.SplitOnCharAndTrim(s: System.String; c: System.Char): List<System.String>;
begin
  var list: List<System.String> := new List<System.String>();
  if System.String.IsNullOrEmpty(s) then begin
    exit list
  end;

  var a: array of System.String := s.Split(c);
  for each item: System.String in a do begin
    if not System.String.IsNullOrEmpty(item) then begin
      list.Add(item.Trim())
    end
  end;
  exit list
end;

class method StringHelper.SplitOnPipes(s: System.String): List<System.String>;
begin
  var list: List<System.String> := new List<System.String>();
  if System.String.IsNullOrEmpty(s) then begin
    exit list
  end;

  var a: array of System.String := s.Split('|');
  for each item: System.String in a do begin
    if not System.String.IsNullOrEmpty(item) then begin
      list.Add(item)
    end
  end;
  exit list
end;

class method StringHelper.ReplaceFirst(text: String; search: String; replace: String): String;
begin
  var pos: Integer := text.IndexOf(search);
  if pos < 0 then
  begin
    exit text
  end;
  exit text.Substring(0, pos) + replace + text.Substring(pos + search.Length)
end;


class method StringHelper.RemoveDiacritics(text: String): String;
begin
 var destEncoding: Encoding := Encoding.GetEncoding('iso-8859-8');  //iso-8859-1 not good :-(
exit destEncoding.GetString(Encoding.Convert(Encoding.UTF8, destEncoding, Encoding.UTF8.GetBytes(text)));
end;

class method StringHelper.indexOf_CA_CI_AI( text: String; partext:String): Int32;
begin
  if ((String.IsNullOrEmpty(text)) or (String.IsNullOrEmpty(partext))) then exit -1;
  
exit RemoveDiacritics(text).IndexOf(RemoveDiacritics(partext), StringComparison.InvariantCultureIgnoreCase)
end;

class method StringHelper.EgalString_CA_CI_AI( text: String; partext:String): Boolean;
begin
  if ((String.IsNullOrEmpty(text)) or (String.IsNullOrEmpty(partext))) then exit false;
  
exit String.Compare(RemoveDiacritics(text),RemoveDiacritics(partext), true)=0;
end;

class method StringHelper.StringHtmlEncode(text: String): String;
begin
  if text = nil then
    exit nil;
  var sb: StringBuilder := new StringBuilder(text.Length);
  var len: Integer := text.Length;
  for i: Integer := 0 to len-1 do begin
    case Integer(text[i]) of
      39,

      128 .. 100000 :begin
          sb.Append('&#');
          sb.Append((Integer(text[i])).ToString(System.Globalization.CultureInfo.InvariantCulture));
          sb.Append(';');
        end
        else
          sb.Append(text[i]);

    end;
   (* case text[i] of
      '<': begin
        sb.Append('&lt;');
      end;
      '>': begin
        sb.Append('&gt;');
      end;
      '"': begin
        sb.Append('&quot;');
      end;
      '&': begin
        sb.Append('&amp;');
      end;
      else begin*)
  //     if Integer(text[i]) > 159 then begin
  //       //  decimal numeric entity
  //       sb.Append('&#');
  //       sb.Append((Integer(text[i])).ToString(System.Globalization.CultureInfo.InvariantCulture));
  //       sb.Append(';');
  //     end
  //     else
  //       sb.Append(text[i]);
     // end;
    //end;
  end;
  exit sb.ToString();
end;


end.
