package com.guyi.tools.common.lang.date;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.ObjectUtils;

/**
 * @author huliang
 * @date 2021/05/27 15:49
 */
public class DateUtils {

  private static int[] dateFields = new int[]{1, 2, 5, 11, 12, 13, 14};
  private static Map formatCache = new HashMap();
  private static long millisecondOfDay = 86400000L;
  private static int daysOfWeak = 7;
  private static int daysOfMonth = 30;

  public DateUtils() {
  }

  private static SimpleDateFormat getFormat(String pattern) {
    if (!formatCache.containsKey(pattern)) {
      formatCache.put(pattern, new SimpleDateFormat(pattern));
    }

    return (SimpleDateFormat) formatCache.get(pattern);
  }

  public static Date parseDate(String dateStr, String pattern) throws DateParseException {
    SimpleDateFormat parser = getFormat(pattern);

    try {
      return parser.parse(dateStr);
    } catch (ParseException var4) {
      throw new DateParseException(
          "can't format date [" + dateStr + "] with format [" + pattern + "]", var4);
    }
  }

  public static String formatDate(Date date, String pattern) {
    SimpleDateFormat parser = getFormat(pattern);
    return parser.format(date);
  }

  public static int getField(Date date, int calendarField) {
    Calendar c = Calendar.getInstance();
    c.setTime(date);
    return c.get(calendarField);
  }

  public static Date addField(Date date, int calendarField, int amount) {
    Calendar c = Calendar.getInstance();
    c.setTime(date);
    c.add(calendarField, amount);
    return c.getTime();
  }

  public static Date setField(Date date, int calendarField, int amount) {
    Calendar c = Calendar.getInstance();
    c.setLenient(false);
    c.setTime(date);
    c.set(calendarField, amount);
    return c.getTime();
  }

  public static Date truncate(Date date, int calendarField) {
    int index = getFieldIndex(calendarField);
    return index < dateFields.length - 1 ? clearField(date, index + 1) : date;
  }

  public static Date getStartTimeOfDate(Date date) {
    return truncate(date, 5);
  }

  public static Date getEndTimeOfDate(Date date) {
    Date nextDayZeroTime = truncate(addField(date, 5, 1), 5);
    return addField(nextDayZeroTime, 14, -1);
  }

  public static Date getStartDateOfMonth(Date date) {
    return truncate(date, 2);
  }

  public static Date getEndDateOfMonth(Date date) {
    Date nextMonthZeroTime = truncate(addField(date, 2, 1), 2);
    return addField(nextMonthZeroTime, 14, -1);
  }

  public static Date getStartDateOfYear(Date date) {
    return truncate(date, 1);
  }

  public static Date getEndDateOfYear(Date date) {
    Date nextYearZeroTime = truncate(addField(date, 1, 1), 1);
    return addField(nextYearZeroTime, 14, -1);
  }

  public static int getDaysBetween(Date startDate, Date endDate) {
    long startMs = truncate(startDate, 5).getTime();
    long endMs = truncate(endDate, 5).getTime();
    return (int) ((endMs - startMs) / millisecondOfDay);
  }

  public static int getWeeksBetweenByDay(Date startDate, Date endDate) {
    int days = getDaysBetween(startDate, endDate);
    return days / daysOfWeak;
  }

  public static int getWeeksBetweenByWeek(Date startDate, Date endDate) {
    int weeks = 0;
    Calendar beginCalendar = Calendar.getInstance();
    beginCalendar.setTime((Date) ObjectUtils.min(startDate, endDate));
    Calendar endCalendar = Calendar.getInstance();
    endCalendar.setTime((Date) ObjectUtils.max(startDate, endDate));

    while (beginCalendar.before(endCalendar) && (beginCalendar.get(1) != endCalendar.get(1)
        || beginCalendar.get(2) != endCalendar.get(2) || beginCalendar.get(8) != endCalendar
        .get(8))) {
      beginCalendar.add(6, 7);
      ++weeks;
    }

    return startDate.before(endDate) ? weeks : 0 - weeks;
  }

  public static int getMonthsBetweenByDay(Date startDate, Date endDate) {
    int days = getDaysBetween(startDate, endDate);
    return days / daysOfMonth;
  }

  public static int getMonthsBetweenByMonth(Date startDate, Date endDate) {
    int startYear = getField(startDate, 1);
    int startMonth = getField(startDate, 2);
    int endYear = getField(endDate, 1);
    int endMonth = getField(endDate, 2);
    int monthsBetween = endMonth - startMonth;
    int yearsBetween = endYear - startYear;
    return monthsBetween + yearsBetween * 12;
  }

  public static int getYearsBetween(Date startDate, Date endDate) {
    int startYear = getField(startDate, 1);
    int endYear = getField(endDate, 1);
    return endYear - startYear;
  }

  public static boolean isLeepYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  private static int getFieldIndex(int calendarField) {
    for (int i = 0; i < dateFields.length; ++i) {
      if (dateFields[i] == calendarField) {
        return i;
      }
    }

    throw new IllegalArgumentException("invalid field [" + calendarField + "]");
  }

  private static Date clearField(Date date, int start) {
    Calendar c = Calendar.getInstance();
    c.setLenient(false);
    c.setTime(date);

    for (int i = start; i < dateFields.length; ++i) {
      switch (dateFields[i]) {
        case 1:
          c.set(1, 1900);
          break;
        case 2:
          c.set(2, 0);
          break;
        case 3:
        case 4:
        default:
          c.set(dateFields[i], 0);
          break;
        case 5:
          c.set(5, 1);
      }
    }

    return c.getTime();
  }
}
