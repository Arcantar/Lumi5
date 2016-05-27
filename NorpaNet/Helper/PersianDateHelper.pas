namespace NorpaNet.Helper;

interface

uses
  System,
  System.Globalization;

/// <summary>
/// A helper class for Persian language
/// </summary>
type
  PersianDateHelper = public class


  public
    constructor ;

{$region this.DateManager.AddDays}
    method ChangeDate(PersionDate: System.String; Days: System.Int32): System.String;
{$endregion}
    method ToDay: System.String;
    method StringShToDateM(Ddate: System.String): DateTime;
    method ShtoM(strd: System.String): DateTime;

    method MtoSh(ddat: System.DateTime): System.String;

    method GetPersianMonth(ddat: System.DateTime): System.Int32;

    method GetPersianYear(ddat: System.DateTime): System.Int32;

    method MtoSh(strdat: System.String): System.String;
    method GetWeek(strdat: System.String): System.Int32;
    method GetYear(strdat: System.String): System.Int32;
    method GetDate(Year: System.Int32; Week: System.Int32; DayInWeek: System.Int32): System.String;
  end;



implementation


constructor PersianDateHelper;
begin

//
// TODO: Add constructor logic here
//
end;

method PersianDateHelper.ChangeDate(PersionDate: System.String; Days: System.Int32): System.String;
begin
  var aDate: DateTime := ShtoM(PersionDate);
  if Days >= 0 then begin

    aDate := aDate.AddDays(Days)
  end
  else begin
    var adays: System.TimeSpan := new TimeSpan(Days, 0, 0, 0, 0);
    aDate := aDate.Subtract(adays)
  end;
  PersionDate := self.MtoSh(aDate);
  exit PersionDate
end;

method PersianDateHelper.ToDay: System.String;
begin
  exit MtoSh(DateTime.Today)
end;

method PersianDateHelper.StringShToDateM(Ddate: System.String): DateTime;
begin
  var dt: DateTime := new DateTime();
  try
    exit dt
  
  except begin
      exit dt
    end;
  end
end;



method PersianDateHelper.ShtoM(strd: System.String): DateTime;
begin
  var dt: System.DateTime := new DateTime();
  try

    if strd.Length = 6 then      strd := '13' + strd;
    if strd.Length = 8 then      strd := strd.Trim().Substring(0, 4) + '/' + strd.Trim().Substring(4, 2) + '/' + strd.Trim().Substring(6, 2);
    var tt1: System.String;
    var tt2: System.String;
    var tt3: System.String;
    var bt: System.Int32;
    var at: System.Int32;
    var ct: System.Int32;
    var ST: System.Int32 := 0;

    if (strd = '    /  /  ') or (strd = '13  /  /  ') then      exit dt;
    tt1 := strd.Trim().Substring(0, 4);
    tt2 := strd.Trim().Substring(5, 2);
    tt3 := strd.Trim().Substring(8, 2);
    var tmptt: System.Int32;
    tmptt := (System.Int32.Parse(tt1) + 621);
    tt1 := tmptt.ToString();
    if (System.Int32.Parse(tt1) > 1995) and (System.Int32.Parse(tt1) mod 4 = 0) then      dt := new DateTime(System.Int32.Parse(tt1), 3, 20)
    else      dt := new DateTime(System.Int32.Parse(tt1), 3, 21);
    at := System.Int32.Parse(tt1);
    bt := System.Int32.Parse(tt2);
    ct := System.Int32.Parse(tt3);
    case bt of 
      1, 2, 3, 4, 5, 6: begin
        ST := ((bt - 1) * 31) + ct;
      end;
      7, 8, 9, 10, 11, 12: begin
        ST := (6 * 31) + ((bt - 7) * 30) + ct;
      end;
    end;

    dt := dt.AddDays(ST - 1);

    exit dt
  
  except begin
      exit dt
    end;
  end
end;

method PersianDateHelper.MtoSh(ddat: System.DateTime): System.String;
begin
  try
    var da: System.Int32;
    var mo: System.Int32;
    var ye: System.Int32;
    var ld: System.Int32;
    var tt1: System.String;
    var tt2: System.String;
    var tt3: System.String;

    var buf1: array of System.Int32;
    var buf2: array of System.Int32;
    buf1 := new System.Int32[12];
    buf2 := new System.Int32[12];
    buf1[0] := 0;
    buf1[1] := 31;
    buf1[2] := 59;
    buf1[3] := 90;
    buf1[4] := 120;
    buf1[5] := 151;
    buf1[6] := 181;
    buf1[7] := 212;
    buf1[8] := 243;
    buf1[9] := 273;
    buf1[10] := 304;
    buf1[11] := 334;

    buf2[0] := 0;
    buf2[1] := 31;
    buf2[2] := 60;
    buf2[3] := 91;
    buf2[4] := 121;
    buf2[5] := 152;
    buf2[6] := 182;
    buf2[7] := 213;
    buf2[8] := 244;
    buf2[9] := 274;
    buf2[10] := 305;
    buf2[11] := 335;

    if (ddat.Year mod 4) <> 0 then begin
      da := buf1[ddat.Month - 1] + ddat.Day;
      if da > 79 then begin
        da := da - 79;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        if (ddat.Year > 1996) and ((ddat.Year mod 4) = 1) then
          ld := 11
        else          ld := 10;
        da := da + ld;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end
    else begin
      da := buf2[ddat.Month - 1] + ddat.Day;
      if ddat.Year >= 1996 then        ld := 79
      else        ld := 80;
      if da > ld then begin
        da := da - ld;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        da := da + 10;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end;
    tt1 := ye.ToString().Trim();
    tt2 := mo.ToString().Trim();
    if tt2.Length = 1 then      tt2 := '0' + tt2;
    tt3 := da.ToString().Trim();
    if tt3.Length = 1 then      tt3 := '0' + tt3;

    exit (tt1 + '/' + tt2 + '/' + tt3)
  
  except    on System.Exception do begin
      exit System.String.Empty
    end;
  end
end;

method PersianDateHelper.GetPersianMonth(ddat: System.DateTime): System.Int32;
begin
  try
    var da: System.Int32;
    var mo: System.Int32;
    var ye: System.Int32;
    var ld: System.Int32;

    var buf1: array of System.Int32;
    var buf2: array of System.Int32;
    buf1 := new System.Int32[12];
    buf2 := new System.Int32[12];
    buf1[0] := 0;
    buf1[1] := 31;
    buf1[2] := 59;
    buf1[3] := 90;
    buf1[4] := 120;
    buf1[5] := 151;
    buf1[6] := 181;
    buf1[7] := 212;
    buf1[8] := 243;
    buf1[9] := 273;
    buf1[10] := 304;
    buf1[11] := 334;

    buf2[0] := 0;
    buf2[1] := 31;
    buf2[2] := 60;
    buf2[3] := 91;
    buf2[4] := 121;
    buf2[5] := 152;
    buf2[6] := 182;
    buf2[7] := 213;
    buf2[8] := 244;
    buf2[9] := 274;
    buf2[10] := 305;
    buf2[11] := 335;

    if (ddat.Year mod 4) <> 0 then begin
      da := buf1[ddat.Month - 1] + ddat.Day;
      if da > 79 then begin
        da := da - 79;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        if (ddat.Year > 1996) and ((ddat.Year mod 4) = 1) then
          ld := 11
        else          ld := 10;
        da := da + ld;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end
    else begin
      da := buf2[ddat.Month - 1] + ddat.Day;
      if ddat.Year >= 1996 then        ld := 79
      else        ld := 80;
      if da > ld then begin
        da := da - ld;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        da := da + 10;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end;

    exit mo
  
  except    on System.Exception do begin
      exit ddat.Month
    end;
  end
end;

method PersianDateHelper.GetPersianYear(ddat: System.DateTime): System.Int32;
begin
  try
    var da: System.Int32;
    var mo: System.Int32;
    var ye: System.Int32;
    var ld: System.Int32;

    var buf1: array of System.Int32;
    var buf2: array of System.Int32;
    buf1 := new System.Int32[12];
    buf2 := new System.Int32[12];
    buf1[0] := 0;
    buf1[1] := 31;
    buf1[2] := 59;
    buf1[3] := 90;
    buf1[4] := 120;
    buf1[5] := 151;
    buf1[6] := 181;
    buf1[7] := 212;
    buf1[8] := 243;
    buf1[9] := 273;
    buf1[10] := 304;
    buf1[11] := 334;

    buf2[0] := 0;
    buf2[1] := 31;
    buf2[2] := 60;
    buf2[3] := 91;
    buf2[4] := 121;
    buf2[5] := 152;
    buf2[6] := 182;
    buf2[7] := 213;
    buf2[8] := 244;
    buf2[9] := 274;
    buf2[10] := 305;
    buf2[11] := 335;

    if (ddat.Year mod 4) <> 0 then begin
      da := buf1[ddat.Month - 1] + ddat.Day;
      if da > 79 then begin
        da := da - 79;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        if (ddat.Year > 1996) and ((ddat.Year mod 4) = 1) then
          ld := 11
        else          ld := 10;
        da := da + ld;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end
    else begin
      da := buf2[ddat.Month - 1] + ddat.Day;
      if ddat.Year >= 1996 then        ld := 79
      else        ld := 80;
      if da > ld then begin
        da := da - ld;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        da := da + 10;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end;

    exit ye
  
  except    on System.Exception do begin
      exit ddat.Month
    end;
  end
end;

method PersianDateHelper.MtoSh(strdat: System.String): System.String;
begin
  try
    var ddat: System.DateTime := new DateTime(System.Int32.Parse(strdat.Substring(0, 4)), System.Int32.Parse(strdat.Substring(5, 2)), System.Int32.Parse(strdat.Substring(8, 2)));
    var da: System.Int32;
    var mo: System.Int32;
    var ye: System.Int32;
    var ld: System.Int32;
    var tt1: System.String;
    var tt2: System.String;
    var tt3: System.String;

    var buf1: array of System.Int32;
    var buf2: array of System.Int32;
    buf1 := new System.Int32[12];
    buf2 := new System.Int32[12];
    buf1[0] := 0;
    buf1[1] := 31;
    buf1[2] := 59;
    buf1[3] := 90;
    buf1[4] := 120;
    buf1[5] := 151;
    buf1[6] := 181;
    buf1[7] := 212;
    buf1[8] := 243;
    buf1[9] := 273;
    buf1[10] := 304;
    buf1[11] := 334;

    buf2[0] := 0;
    buf2[1] := 31;
    buf2[2] := 60;
    buf2[3] := 91;
    buf2[4] := 121;
    buf2[5] := 152;
    buf2[6] := 182;
    buf2[7] := 213;
    buf2[8] := 244;
    buf2[9] := 274;
    buf2[10] := 305;
    buf2[11] := 335;

    if (ddat.Year mod 4) <> 0 then begin
      da := buf1[ddat.Month - 1] + ddat.Day;
      if da > 79 then begin
        da := da - 79;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        if (ddat.Year > 1996) and ((ddat.Year mod 4) = 1) then
          ld := 11
        else          ld := 10;
        da := da + ld;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end
    else begin
      da := buf2[ddat.Month - 1] + ddat.Day;
      if ddat.Year >= 1996 then        ld := 79
      else        ld := 80;
      if da > ld then begin
        da := da - ld;
        if da <= 186 then begin
          case da mod 31 of 
            0: begin
              mo := da / 31;
              da := 31;
            end
            else
              mo := System.Int32((da / 31)) + 1;
              da := da mod 31;
          end;
          ye := ddat.Year - 621
        end
        else begin
          da := da - 186;
          case da mod 30 of 
            0: begin
              mo := (da / 30) + 6;
              da := 30;
            end
            else
              mo := System.Int32((da / 30)) + 7;
              da := da mod 30;
          end;
          ye := ddat.Year - 621
        end
      end
      else begin
        da := da + 10;
        case da mod 30 of 
          0: begin
            mo := (da / 30) + 9;
            da := 30;
          end
          else
            mo := System.Int32((da / 30)) + 10;
            da := da mod 30;
        end;
        ye := ddat.Year - 622
      end
    end;
    tt1 := ye.ToString().Trim();
    tt2 := mo.ToString().Trim();
    if tt2.Length = 1 then      tt2 := '0' + tt2;
    tt3 := da.ToString().Trim();
    if tt3.Length = 1 then      tt3 := '0' + tt3;

    exit (tt1 + '/' + tt2 + '/' + tt3)
  
  except begin
      exit String.Empty;
    end;
  end
end;

method PersianDateHelper.GetWeek(strdat: System.String): System.Int32;
begin
  var W: System.Int32 := 1;
  var dys: System.Int32 := 0;
  var Week1: System.Int32 := 0;
  var str: array of System.String := strdat.Split('/');
  var FirstDayOfYear: DateTime := self.ShtoM(str[0].ToString() + '/01/01');
  case FirstDayOfYear.DayOfWeek of 
    DayOfWeek.Saturday: begin
      Week1 := 7;
    end;
    DayOfWeek.Sunday: begin
      Week1 := 6;
    end;

    DayOfWeek.Monday: begin
      Week1 := 5;
    end;
    DayOfWeek.Tuesday: begin
      Week1 := 4;
    end;
    DayOfWeek.Wednesday: begin
      Week1 := 3;
    end;
    DayOfWeek.Thursday: begin
      Week1 := 2;
    end;
    DayOfWeek.Friday: begin
      Week1 := 1;
    end;  end;


  var m: System.Int32 := System.Int32.Parse(str[1].ToString());
  var d: System.Int32 := System.Int32.Parse(str[2].ToString());
  if m < 7 then begin
    dec(m);
    dys := m * 31 + d
  end
  else begin

    if m = 12 then begin
      dys := 5 * 30 + 6 * 31 + d
    end
    else begin
      dec(m);
      dys := m * 30 + d
    end
  end;
  var Rem: System.Int32 := 0;
  Math.DivRem((dys - Week1), 7, out Rem);
  if Rem > 0 then begin
    W := ((dys - Week1) / 7) + 2
  end
  else begin
    W := ((dys - Week1) / 7) + 1
  end;
  exit W
end;

method PersianDateHelper.GetYear(strdat: System.String): System.Int32;
begin
  var str: array of System.String := new System.String[3];
  str := strdat.Split('/');
  exit System.Int32.Parse(str[0].ToString())
end;

method PersianDateHelper.GetDate(Year: System.Int32; Week: System.Int32; DayInWeek: System.Int32): System.String;
begin
  var Day: System.Int32 := 1;
  var DayInMoth: System.Int32 := 1;
  var month: System.Int32 := 1;
  var Week1: System.Int32 := 0;
  var startDate: System.String := '';
  var FirstDayOfYear: DateTime := self.ShtoM(Year.ToString() + '/01/01');
  case FirstDayOfYear.DayOfWeek of 
    DayOfWeek.Saturday: begin
      Week1 := 7;
    end;
    DayOfWeek.Sunday: begin
      Week1 := 6;
    end;

    DayOfWeek.Monday: begin
      Week1 := 5;
    end;
    DayOfWeek.Tuesday: begin
      Week1 := 4;
    end;
    DayOfWeek.Wednesday: begin
      Week1 := 3;
    end;
    DayOfWeek.Thursday: begin
      Week1 := 2;
    end;
    DayOfWeek.Friday: begin
      Week1 := 1;
    end;  end;
  Day := (Week - 2) * 7 + DayInWeek + Week1;
  if Day <= 186 then begin
    month := (Day / 31) + 1;
    DayInMoth := Day mod 31;
    if DayInMoth = 0 then begin
      dec(month);
      DayInMoth := 31
    end
  end
  else begin
    Day := Day - 186;
    month := (Day / 30) + 7;
    DayInMoth := Day mod 30;
    if DayInMoth = 0 then begin
      dec(month);
      DayInMoth := 30
    end
  end;
  if (month > 9) and (DayInMoth > 9) then    startDate := Year.ToString() + '/' + month.ToString() + '/' + DayInMoth.ToString();
  if (month < 10) and (DayInMoth > 9) then    startDate := Year.ToString() + '/0' + month.ToString() + '/' + DayInMoth.ToString();
  if (month > 9) and (DayInMoth < 10) then    startDate := Year.ToString() + '/' + month.ToString() + '/0' + DayInMoth.ToString();
  if (month < 10) and (DayInMoth < 10) then    startDate := Year.ToString() + '/0' + month.ToString() + '/0' + DayInMoth.ToString();
  exit startDate
end;

end.
