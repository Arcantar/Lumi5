namespace NorpaNet.Helper;

interface

uses
  System,
  System.Globalization,
  System.Reflection,
  System.Text;


/// <summary>
/// A helper class for various cultures that are not as well supported in ASP.nET
/// </summary>
type
  CultureHelper = public static class
  public
    class method GetPersianCulture: CultureInfo;


{$region Digit Substitution}

// .ToString() does not localize digits, typically the digits used are always the ones configured in the
// Regional Settings of a computer
// this is unfortunate for web apps where we want to localize digits but cannot depend on the user
// always having the correct regional settings for the site language

/// <summary>
/// Example extension method for int, allows us to do digit substitution where needed.
/// Current example is only for Arabic but the same technique can be used for other languages
/// if we can add more conversion methods
/// </summary>
/// <param name="i"></param>
/// <returns></returns>
    [System.Runtime.CompilerServices.Extension]
    class method ToLocalString(i: System.Int32): System.String;

/// <summary>
/// based on http://weblogs.asp.net/abdullaabdelhaq/archive/2009/06/27/displaying-arabic-number.aspx
/// seems like a fairly expensive method to call so not sure if its suitable to use this everywhere
/// </summary>
/// <param name="input"></param>
/// <returns></returns>
    class method SubstituteArabicDigits(input: System.String): System.String;

{$endregion}


  end;


implementation


class method CultureHelper.GetPersianCulture: CultureInfo;
begin
  var persianCulture: CultureInfo := new CultureInfo('fa-IR');
  var info: DateTimeFormatInfo := persianCulture.DateTimeFormat;

  info.DayNames := array of System.String([#1740#1705#1588#1606#1576#1607, #1583#1608#1588#1606#1576#1607, #65203#65258#1588#1606#1576#1607, #1670#1607#1575#1585#1588#1606#1576#1607, #1662#1606#1580#1588#1606#1576#1607, #1580#1605#1593#1607, #1588#1606#1576#1607]);
  info.AbbreviatedDayNames := array of System.String([#1740, #1583, #1587, #1670, #1662, #1580, #1588]);

  info.MonthNames := array of System.String([#1601#1585#1608#1585#1583#1740#1606, #1575#1585#1583#1610#1576#1607#1588#1578, #1582#1585#1583#1575#1583, #1578#1610#1585, #1605#1585#1583#1575#1583, #1588#1607#1585#1740#1608#1585, #1605#1607#1585, #1570#1576#1575#1606, #1570#1584#1585, #1583#1740, #1576#1607#1605#1606, #1575#1587#1601#1606#1583, '']);
  info.AbbreviatedMonthNames := array of System.String([#1601#1585#1608#1585#1583#1740#1606, #1575#1585#1583#1610#1576#1607#1588#1578, #1582#1585#1583#1575#1583, #1578#1610#1585, #1605#1585#1583#1575#1583, #1588#1607#1585#1740#1608#1585, #1605#1607#1585, #1570#1576#1575#1606, #1570#1584#1585, #1583#1740, #1576#1607#1605#1606, #1575#1587#1601#1606#1583, '']);

  info.MonthGenitiveNames := array of System.String([#1601#1585#1608#1585#1583#1740#1606, #1575#1585#1583#1610#1576#1607#1588#1578, #1582#1585#1583#1575#1583, #1578#1610#1585, #1605#1585#1583#1575#1583, #1588#1607#1585#1740#1608#1585, #1605#1607#1585, #1570#1576#1575#1606, #1570#1584#1585, #1583#1740, #1576#1607#1605#1606, #1575#1587#1601#1606#1583, '']);
  info.AbbreviatedMonthGenitiveNames := array of System.String([#1601#1585#1608#1585#1583#1740#1606, #1575#1585#1583#1610#1576#1607#1588#1578, #1582#1585#1583#1575#1583, #1578#1610#1585, #1605#1585#1583#1575#1583, #1588#1607#1585#1740#1608#1585, #1605#1607#1585, #1570#1576#1575#1606, #1570#1584#1585, #1583#1740, #1576#1607#1605#1606, #1575#1587#1601#1606#1583, '']);

  info.AMDesignator := #1602'.'#1592;
  info.PMDesignator := #1576'.'#1592;
  info.ShortDatePattern := 'yyyy/MM/dd';
  info.LongDatePattern := 'dddd dd MMMM yyyy';
  info.FullDateTimePattern := 'dddd dd MMMM yyyy, HH:mm:ss';
  info.FirstDayOfWeek := DayOfWeek.Saturday;
  var cal: PersianCalendar := new PersianCalendar();

  if ConfigHelper.GetBoolProperty('UseNet35PersianHelper', false) then
    typeOf(DateTimeFormatInfo).GetField('calendar', BindingFlags.Public or BindingFlags.Instance or BindingFlags.NonPublic).SetValue(info, cal);
  var obj: System.Object := typeOf(DateTimeFormatInfo).GetField('m_cultureTableRecord', BindingFlags.Public or BindingFlags.Instance or BindingFlags.NonPublic).GetValue(info);
  obj.GetType().GetMethod('UseCurrentCalendar', BindingFlags.NonPublic or BindingFlags.Instance).Invoke(obj, array of System.Object([cal.GetType().GetProperty('ID', BindingFlags.Instance or BindingFlags.NonPublic).GetValue(cal, nil)]));

  typeOf(DateTimeFormatInfo).GetField('calendar', BindingFlags.Public or BindingFlags.Instance or BindingFlags.NonPublic).SetValue(info, cal);
  typeOf(CultureInfo).GetField('calendar', (BindingFlags.NonPublic or (BindingFlags.Public or BindingFlags.Instance))).SetValue(persianCulture, cal);

  persianCulture.DateTimeFormat := info;
  persianCulture.NumberFormat.CurrencyDecimalDigits := 0;
  exit persianCulture
end;



class method CultureHelper.ToLocalString(i: System.Int32): System.String;
begin
  case CultureInfo.CurrentCulture.TwoLetterISOLanguageName of 
    'ar': 
      exit SubstituteArabicDigits(i.ToString())
    else

      exit i.ToString();
  end

end;


class method CultureHelper.SubstituteArabicDigits(input: System.String): System.String;
begin
  if System.String.IsNullOrEmpty(input) then begin
    exit input
  end;

  var utf8: Encoding := new UTF8Encoding();
  var utf8Decoder: Decoder := utf8.GetDecoder();
  var fresult: StringBuilder := new StringBuilder();

  var translatedChars: array of Char := new Char[1];
  var inputChars: array of Char := input.ToCharArray();
  var bytes: array of Byte := [217, 160 ];

  for each c: Char in inputChars do begin
    if Char.IsDigit(c) then begin
      bytes[1] := Convert.ToByte(160 + Convert.ToInt32(System.Char.GetNumericValue(c)));
      utf8Decoder.GetChars(bytes, 0, 2, translatedChars, 0);
      fresult.Append(translatedChars[0])
    end
    else begin
      fresult.Append(c)
    end
  end;

  exit fresult.ToString()
end;

end.
