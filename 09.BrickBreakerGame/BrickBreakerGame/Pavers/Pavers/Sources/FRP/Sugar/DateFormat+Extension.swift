//
//  DateFormat+Extension.swift
//  PaversFRP
//
//  Created by Keith on 02/01/2018.
//  Copyright © 2018 Keith. All rights reserved.
//

import Foundation

public typealias DateFormat = String

public extension DateFormat {
  public static let yyyy =
    DateFormatComponent.calendarYear.rawValue
      + DateFormatComponent.calendarYear.rawValue
      + DateFormatComponent.calendarYear.rawValue
      + DateFormatComponent.calendarYear.rawValue
  
  public static let mm =
    DateFormatComponent.monthNumber.rawValue
      + DateFormatComponent.monthNumber.rawValue
  
  public static let dd =
    DateFormatComponent.dayOfMonth.rawValue
      + DateFormatComponent.dayOfMonth.rawValue
  
  public static let h24 =
    DateFormatComponent.hour24.rawValue
    + DateFormatComponent.hour24.rawValue
  
  public static let mi =
    DateFormatComponent.minute.rawValue
    + DateFormatComponent.minute.rawValue
  
  public static let ss =
    DateFormatComponent.second.rawValue
    + DateFormatComponent.second.rawValue
  
  public static let ms =
    DateFormatComponent.fractionalSecond.rawValue
    + DateFormatComponent.fractionalSecond.rawValue
    + DateFormatComponent.fractionalSecond.rawValue
  
  public static let yyyymmdd = "\(yyyy)\(mm)\(dd)"
  
  public static let yyyy_mm_dd = "\(yyyy)-\(mm)-\(dd)"
  
  public static let h24miss = "\(h24)\(mi)\(ss)"
  
  public static let h24_mi_ss = "\(h24):\(mi):\(ss)"
  
  public static let h24_mi_ss_ms = "\(h24):\(mi):\(ss).\(ms)"
  
  public static let yyyymmddh24miss = "\(yyyymmdd)\(h24miss)"
  
  public static let yyyy_mm_dd_h24_mi_ss = "\(yyyy_mm_dd) \(h24_mi_ss)"
  
  public static let yyyy_mm_dd_h24_mi_ss_ms = "\(yyyy_mm_dd) \(h24_mi_ss_ms)"
}

public enum DateFormatComponent: DateFormat {
  /**
   Calendar year (numeric).
   In most cases the length of the y field specifies the minimum number of digits to display,
   zero-padded as necessary;
   more digits will be displayed if needed to show the full year.
   However, “yy” requests just the two low-order digits of the year, zero-padded as necessary.
   For most use cases, “y” or “yy” should be adequate.
   
   Y  2, 20, 201, 2017, 20173
   
   YY  02, 20, 01, 17, 73
   
   YYY  002, 020, 201, 2017, 20173
   
   YYYY  0002, 0020, 0201, 2017, 20173
   
   YYYYY+  ...
   */
  case calendarYear = "y"
  
  /**
   Year in “Week of Year” based calendars in which the year transition occurs on a week boundary;
   may differ from calendar year ‘y’ near a year transition.
   This numeric year designation is used in conjunction with pattern character ‘w’
   in the ISO year-week calendar as defined by ISO 8601,
   but can be used in non-Gregorian based calendar systems
   where week date processing is desired. The field length is interpreted
   in the same was as for ‘y’; that is, “yy” specifies use of the two low-order year digits,
   while any other field length specifies a minimum number of digits to display.
   
   Y  2, 20, 201, 2017, 20173
   
   YY  02, 20, 01, 17, 73
   
   YYY  002, 020, 201, 2017, 20173
   
   YYYY  0002, 0020, 0201, 2017, 20173
   
   YYYYY+  ...
   */
  case yearInWeekofYear = "Y"
  
  /**
   Extended year (numeric). This is a single number designating the year of this calendar system, encompassing all supra-year fields. For example, for the Julian calendar system, year numbers are positive, with an era of BCE or CE. An extended year value for the Julian calendar system assigns positive values to CE years and negative values to BCE years, with 1 BCE being year 0. For ‘u’, all field lengths specify a minimum number of digits; there is no special interpretation for “uu”.
   
   u+  4601
   */
  case extendedYear = "u"
  
  /**
   Cyclic year name. Calendars such as the Chinese lunar calendar (and related calendars) and the Hindu calendars use 60-year cycles of year names. If the calendar does not provide cyclic year name data, or if the year value to be formatted is out of the range of years for which cyclic name data is provided, then numeric formatting is used (behaves like 'y').
   Currently the data only provides abbreviated names, which will be used for all requested name widths.
   
   U..UUU  甲子
   
   UUUU  甲子 [for now]  Wide
   
   UUUUU  甲子 [for now]
   */
  case cyclicYearName = "U"
  
  /**
   Related Gregorian year (numeric). For non-Gregorian calendars, this corresponds to the extended Gregorian year in which the calendar’s year begins. Related Gregorian years are often displayed, for example, when formatting dates in the Japanese calendar — e.g. “2012(平成24)年1月15日” — or in the Chinese calendar — e.g. “2012壬辰年腊月初四”. The related Gregorian year is usually displayed using the "latn" numbering system, regardless of what numbering systems may be used for other parts of the formatted date. If the calendar’s year is linked to the solar year (perhaps using leap months), then for that calendar the ‘r’ year will always be at a fixed offset from the ‘u’ year. For the Gregorian calendar, the ‘r’ year is the same as the ‘u’ year. For ‘r’, all field lengths specify a minimum number of digits; there is no special interpretation for “rr”.
   
   r+  2017
   */
  case relatedGregorianYear = "r"
  
  /**
   Quarter number/name.
   
   Q 2 Numeric: 1 digit
   
   QQ 02 Numeric: 2 digits + zero pad
   
   QQQ  Q2  Abbreviated
   
   QQQQ  2nd quarter  Wide
   
   QQQQQ  2  Narrow
   */
  case quarterNumber = "Q"
  
  /**
   Stand-Alone Quarter number/name.
   
   Q 2 Numeric: 1 digit
   
   QQ 02 Numeric: 2 digits + zero pad
   
   QQQ  Q2  Abbreviated
   
   QQQQ  2nd quarter  Wide
   
   QQQQQ  2  Narrow
   */
  case standAloneQuarterNumber = "q"
  
  /**
   Month number/name, format style (intended to be used in conjunction with ‘d’ for day number).
   
   M  9, 12  Numeric: minimum digits
   
   MM  09, 12  Numeric: 2 digits, zero pad if needed
   
   MMM  Sep  Abbreviated
   
   MMMM  September  Wide
   
   MMMMM  S  Narrow
   */
  case monthNumber = "M"
  
  /**
   Stand-Alone Month number/name (intended to be used without ‘d’ for day number).
   
   L  9, 12  Numeric: minimum digits
   
   LL  09, 12  Numeric: 2 digits, zero pad if needed
   
   LLL  Sep  Abbreviated
   
   LLLL  September  Wide
   
   LLLLL  S  Narrow
   */
  case standAloneMonthNumber = "L"
  
  /**
   Week of Year (numeric). When used in a pattern with year, use ‘Y’ for the year field instead of ‘y’.
   
   w  8, 27  Numeric: minimum digits
   
   ww  08, 27  Numeric: 2 digits, zero pad if needed
   */
  case weekOfYear = "w"
  
  /**
   Week of Month (numeric)
   
   W  3  Numeric: 1 digit
   */
  case weekOfMonth = "W"
  
  /**
   Day of month (numeric).
   
   d  1  Numeric: minimum digits
   
   dd  01  Numeric: 2 digits, zero pad if needed
   */
  case dayOfMonth = "d"
  
  /**
   Day of year (numeric). The field length specifies the minimum number of digits, with zero-padding as necessary.
   
   D...DDD  345
   */
  case dayOfYear = "D"
  
  /**
   Day of Week in Month (numeric). The example is for the 2nd Wed in July
   
   F  2
   */
  case dayOfWeekInMonth = "F"
  
  /**
   Modified Julian day (numeric). This is different from the conventional Julian day number in two regards. First, it demarcates days at local zone midnight, rather than noon GMT. Second, it is a local number; that is, it depends on the local time zone. It can be thought of as a single number that encompasses all the date-related fields.The field length specifies the minimum number of digits, with zero-padding as necessary.
   
   g+  2451334
   */
  case modifiedJulianDay = "g"
  
  /**
   Day of week name, format style.
   
   E..EEE  Tue  Abbreviated
   
   EEEE  Tuesday  Wide
   
   EEEEE  T  Narrow
   
   EEEEEE  Tu  Short
   */
  case dateOfWeekName = "E"
  
  /**
   Local day of week number/name, format style. Same as E except adds a numeric value that will depend on the local starting day of the week. For this example, Monday is the first day of the week.
   
   e  2  Numeric: 1 digit
   
   ee  02  Numeric: 2 digits + zero pad
   
   eee  Tue  Abbreviated
   
   eeee  Tuesday  Wide
   
   eeeee  T  Narrow
   
   eeeeee  Tu  Short
   */
  case localDayOfWeekNumberOrName = "e"
  
  /**
   Stand-Alone local day of week number/name.
   
   c..cc  2  Numeric: 1 digit
   
   ccc  Tue  Abbreviated
   
   cccc  Tuesday  Wide
   
   ccccc  T  Narrow
   
   cccccc  Tu  Short
   */
  case standAloneLocalDayOfWeekNumberOrName = "c"
  
  /**
   Abbreviated  AM, PM
   
   May be upper or lowercase depending on the locale and other options. The wide form may be the same as the short form if the “real” long form (eg ante meridiem) is not customarily used. The narrow form must be unique, unlike some other fields.
   
   a..aaa  am. [e.g. 12 am.]
   
   aaaa  am. [e.g. 12 am.]  Wide
   
   aaaaa  a [e.g. 12a]  Narrow
   */
  case ampm = "a"
  
  /**
   Abbreviated  am, pm, noon, midnight
   
   May be upper or lowercase depending on the locale and other options. If the locale doesn't the notion of a unique "noon" = 12:00, then the PM form may be substituted. Similarly for "midnight" = 00:00 and the AM form. The narrow form must be unique, unlike some other fields.
   
   b..bbb  mid. [e.g. 12 mid.]
   
   bbbb  midnight
   
   [e.g. 12 midnight]  Wide
   
   bbbbb  md [e.g. 12 md]  Narrow
   */
  case amPmNoonMidnight = "b"
  
  
  /**
   Abbreviated  flexible day periods
   
   May be upper or lowercase depending on the locale and other options. Often there is only one width that is customarily used.
   
   B..BBB  at night
   
   [e.g. 3:00 at night]
   
   BBBB  at night
   
   [e.g. 3:00 at night]  Wide
   
   BBBBB  at night
   
   [e.g. 3:00 at night]  Narrow
   */
  case flexibleDayPeriod = "B"
  
  /**
   Hour [1-12]. When used in skeleton data or in a skeleton passed in an API for flexible date pattern generation, it should match the 12-hour-cycle format preferred by the locale (h or K); it should not match a 24-hour-cycle format (H or k).
   
   h  1, 12  Numeric: minimum digits
   
   hh  01, 12  Numeric: 2 digits, zero pad if needed
   */
  case hour12 = "h"
  
  /**
   Hour [0-23]. When used in skeleton data or in a skeleton passed in an API for flexible date pattern generation, it should match the 24-hour-cycle format preferred by the locale (H or k); it should not match a 12-hour-cycle format (h or K).
   
   H  0, 23  Numeric: minimum digits
   
   HH  00, 23  Numeric: 2 digits, zero pad if needed
   */
  case hour24 = "H"
  
  /**
   Hour [0-11]. When used in a skeleton, only matches K or h, see above.
   
   K  0, 11  Numeric: minimum digits
   
   KK  00, 11  Numeric: 2 digits, zero pad if needed
   */
  case hour12k = "K"
  
  /**
   Hour [1-24]. When used in a skeleton, only matches k or H, see above.
   
   k  1, 24  Numeric: minimum digits
   
   kk  01, 24  Numeric: 2 digits, zero pad if needed
   */
  case hour24k = "k"
  
  /**
   Minute (numeric). Truncated, not rounded.
   
   m  m  8, 59  Numeric: minimum digits
   
   mm  08, 59  Numeric: 2 digits, zero pad if needed
   */
  case minute = "m"
  
  /**
   Second (numeric). Truncated, not rounded.
   
   s  8, 12  Numeric: minimum digits
   
   ss  08, 12  Numeric: 2 digits, zero pad if needed
   */
  case second = "s"
  
  /**
   Fractional Second (numeric). Truncates, like other numeric time fields, but in this case to the number of digits specified by the field length. (Example shows display using pattern SSSS for seconds value 12.34567)
   
   S+  3456
   */
  case fractionalSecond = "S"
  
  /**
   Milliseconds in day (numeric). This field behaves exactly like a composite of all time-related fields, not including the zone fields. As such, it also reflects discontinuities of those fields on DST transition days. On a day of DST onset, it will jump forward. On a day of DST cessation, it will jump backward. This reflects the fact that is must be combined with the offset field to obtain a unique local time value. The field length specifies the minimum number of digits, with zero-padding as necessary.
   
   A+  69540000
   */
  case millisecondInDay = "A"
  
  /**
   The short specific non-location format. Where that is unavailable, falls back to the short localized GMT format ("O").
   
   z..zzz  PDT
   
   zzzz  Pacific Daylight Time  The long specific non-location format. Where that is unavailable, falls back to the long localized GMT format ("OOOO").
   */
  case timeZone = "z"
  
  /**
   The ISO8601 basic format with hours, minutes and optional seconds fields. The format is equivalent to RFC 822 zone format (when optional seconds field is absent). This is equivalent to the "xxxx" specifier.
   
   Z..ZZZ  -0800
   
   The long localized GMT format. This is equivalent to the "OOOO" specifier.
   
   ZZZZ  GMT-8:00
   
   The ISO8601 extended format with hours, minutes and optional seconds fields. The ISO8601 UTC indicator "Z" is used when local time offset is 0. This is equivalent to the "XXXXX" specifier.
   
   ZZZZZ  -08:00
   -07:52:58
   */
  case timeZoneISO8601 = "Z"
  
  /**
   GMT format
   
   O  GMT-8  The short localized GMT format.
   
   OOOO  GMT-08:00  The long localized GMT format.
   */
  case GTM = "O"
  
  /**
   The short generic non-location format. Where that is unavailable, falls back to the generic location format ("VVVV"), then the short localized GMT format as the final fallback.
   
   v  PT
   
   The long generic non-location format. Where that is unavailable, falls back to generic location format ("VVVV").
   
   vvvv  Pacific Time
   */
  case pacificTime = "v"
  
  /**
   V  uslax  The short time zone ID. Where that is unavailable, the special short time zone ID unk (Unknown Zone) is used.
   
   Note: This specifier was originally used for a variant of the short specific non-location format, but it was deprecated in the later version of this specification. In CLDR 23, the definition of the specifier was changed to designate a short time zone ID.
   VV  America/Los_Angeles  The long time zone ID.
   
   VVV  Los Angeles  The exemplar city (location) for the time zone. Where that is unavailable, the localized exemplar city name for the special zone Etc/Unknown is used as the fallback (for example, "Unknown City").
   
   VVVV  Los Angeles Time  The generic location format. Where that is unavailable, falls back to the long localized GMT format ("OOOO"; Note: Fallback is only necessary with a GMT-style Time Zone ID, like Etc/GMT-830.)
   
   This is especially useful when presenting possible timezone choices for user selection, since the naming is more uniform than the "v" format.
   */
  case timeZoneID = "V"
  
  /**
   X  -08
   
   +0530
   
   Z  The ISO8601 basic format with hours field and optional minutes field. The ISO8601 UTC indicator "Z" is used when local time offset is 0. (The same as x, plus "Z".)
   
   XX  -0800
   
   Z  The ISO8601 basic format with hours and minutes fields. The ISO8601 UTC indicator "Z" is used when local time offset is 0. (The same as xx, plus "Z".)
   
   XXX  -08:00
   
   Z  The ISO8601 extended format with hours and minutes fields. The ISO8601 UTC indicator "Z" is used when local time offset is 0. (The same as xxx, plus "Z".)
   
   XXXX  -0800
   
   -075258
   
   Z  The ISO8601 basic format with hours, minutes and optional seconds fields. The ISO8601 UTC indicator "Z" is used when local time offset is 0. (The same as xxxx, plus "Z".)
   
   Note: The seconds field is not supported by the ISO8601 specification.
   
   XXXXX  -08:00
   
   -07:52:58
   
   Z  The ISO8601 extended format with hours, minutes and optional seconds fields. The ISO8601 UTC indicator "Z" is used when local time offset is 0. (The same as xxxxx, plus "Z".)
   
   Note: The seconds field is not supported by the ISO8601 specification.
   */
  case ISO8601UTC_XandZ = "X"
  
  /**
   x  -08
   
   +0530
   
   +00  The ISO8601 basic format with hours field and optional minutes field. (The same as X, minus "Z".)
   
   xx  -0800
   
   +0000  The ISO8601 basic format with hours and minutes fields. (The same as XX, minus "Z".)
   
   xxx  -08:00
   
   +00:00  The ISO8601 extended format with hours and minutes fields. (The same as XXX, minus "Z".)
   
   xxxx  -0800
   
   -075258
   
   +0000  The ISO8601 basic format with hours, minutes and optional seconds fields. (The same as XXXX, minus "Z".)
   
   Note: The seconds field is not supported by the ISO8601 specification.
   
   xxxxx  -08:00
   
   -07:52:58
   
   +00:00  The ISO8601 extended format with hours, minutes and optional seconds fields. (The same as XXXXX, minus "Z".)
   
   Note: The seconds field is not supported by the ISO8601 specification.
   */
  case ISO8601UTC_XdivZ = "x"
  
}



















