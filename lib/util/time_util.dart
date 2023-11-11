import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool get isExpired {
    var diffDays = DateTime.now().difference(this).inDays;
    return diffDays > 0;
  }

  bool get isAfterToday => isAfter(DateTime.now());
  bool get isAfterYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isAfter(yesterday);
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day && tomorrow.month == month && tomorrow.year == year;
  }
}

class TimeUtil {
  static int now() => convertDate2Millis(DateTime.now());
  static String nowIso() => DateTime.now().toIso8601String();
  static String getCurrentDate(String pattern) => DateFormat(pattern).format(DateTime.now());
  static int convertDate2Millis(DateTime value) => value.millisecondsSinceEpoch;
  static DateTime convertMillis2Date(int value) => DateTime.fromMillisecondsSinceEpoch(value);
  static String convertMillis2String(int value, String pattern) =>
      convertDateToString(convertMillis2Date(value), pattern);
  static String convertMillis2PrettyDate(int value) => convertDateToString(convertMillis2Date(value), 'd MMM yyyy');
  static String convertMillis2PrettyLongDate(int value) =>
      convertDateToString(convertMillis2Date(value), 'EEEE, d MMMM yyyy');
  static String convertMillis2PrettyShortDate(int value) => convertDateToString(convertMillis2Date(value), 'd MMM yy');
  static String convertDateToDDMMYYYY(DateTime value) => DateFormat('ddMMyyyy').format(value);
  static String convertDateToYYYYMMDD(DateTime value) => DateFormat('yyyyMMdd').format(value);

  static String convertMillis2YYYYMMDDHHMMSS(int? value) {
    String yyyyMMdd = convertMillisToString(value ?? DateTime.now().millisecondsSinceEpoch, 'yyyyMMdd');
    String hhmmss = convertMillisToString(value ?? DateTime.now().millisecondsSinceEpoch, 'HHmmss');
    return '$yyyyMMdd$hhmmss';
  }

  /**
 * dd-MM-yyyy hh:mm:ss
 dont use yyyyMMddHHmmss
 */
  static String convertDateToString(DateTime value, String pattern) => DateFormat(pattern).format(value);
  static String convertMillisToString(int millis, String pattern) =>
      DateFormat(pattern).format(convertMillis2Date(millis));
  static String convertMillisToDetailTime(int millis) =>
      convertDateToString(convertMillis2Date(millis), 'dd-MM-yyyy HH:mm:ss');

/**
dont use yyyyMMddHHmmss
dont use yyyyMMdd
use yyyy.MM.dd
 */
  static DateTime convertStringToDate(String value, String pattern) => DateFormat(pattern).parse(value);

  static bool isYesterday(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return date == yesterday;
  }

  static bool isExpired(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return date.difference(today).inDays < 0;
  }

  static bool isExpiredMillis(int millis) => isExpired(DateTime.fromMillisecondsSinceEpoch(millis));

  static bool isTommorrow(DateTime date) {
    final now = DateTime.now();
    final tom = DateTime(now.year, now.month, now.day + 1);
    return date == tom;
  }

  static DateTime changeTime(DateTime src, int hour, int minute, int seconds) =>
      DateTime(src.year, src.month, src.day, hour, minute, seconds, 0, 0);
  static bool isTimeBetween(DateTime src, DateTime startTime, DateTime endTime) =>
      src.isAfter(startTime) && src.isBefore(endTime);
  static DateTime addDays(DateTime dateLKP, int i) => dateLKP.add(Duration(days: i));
  static DateTime addMinutes(DateTime dateLKP, int i) => dateLKP.add(Duration(minutes: i));
  static bool isSameDay(DateTime date1, DateTime date2) =>
      date2.day == date1.day && date2.month == date1.month && date2.year == date1.year;
  static bool isSameDayMillis(int millis1, int millis2) =>
      isSameDay(DateTime.fromMillisecondsSinceEpoch(millis1), DateTime.fromMillisecondsSinceEpoch(millis2));
  static bool isSameYear(DateTime date1, DateTime date2) => date2.year == date1.year;
  static bool isSameYearMillis(int millis1, int millis2) =>
      isSameYear(DateTime.fromMillisecondsSinceEpoch(millis1), DateTime.fromMillisecondsSinceEpoch(millis2));
  static bool isToday(DateTime date) => isSameDay(date, DateTime.now());

  static bool isTodayMillis(int millis) {
    DateTime day1 = convertMillis2Date(millis);
    DateTime day2 = DateTime.now();
    return isSameDay(day1, day2);
  }

  static bool isWorkingHours() => true;
  static void logTime(String msg) => print('${convertDateToString(DateTime.now(), 'dd-MM-yyyy HH:mm:ss')}::$msg');

  static int diffDays(int millis1, int millis2) {
    final day1 = convertMillis2Date(millis1);
    final day2 = convertMillis2Date(millis2);
    return day2.difference(day1).inDays;
  }

  /// Biasa dipakai untuk mengetahui apakah jam di device berbeda jauh dengan jam di server.
  static int diffHours(int millis1, int millis2) {
    final day1 = convertMillis2Date(millis1);
    final day2 = convertMillis2Date(millis2);
    return day2.difference(day1).inHours;
  }

  static int diffMinutes(int millis1, int millis2) {
    final day1 = convertMillis2Date(millis1);
    final day2 = convertMillis2Date(millis2);
    return day2.difference(day1).inMinutes;
  }

  /// 1..12
  static int getMonth(int millis) => DateTime.fromMillisecondsSinceEpoch(millis).month;
  static int getYear(int millis) => DateTime.fromMillisecondsSinceEpoch(millis).year;
  static int getCurrentMonth() => DateTime.now().month;
  static int yesterday() => convertDate2Millis(addDays(convertMillis2Date(now()), -1));

  static String changeDayname(String dayName) {
    switch (dayName.toLowerCase()) {
      case 'monday':
        return 'Senin';
      case 'tuesday':
        return 'Selasa';
      case 'wednesday':
        return 'Rabu';
      case 'thursday':
        return 'Kamis';
      case 'friday':
        return 'Jumat';
      case 'saturday':
        return 'Sabtu';
      case 'sunday':
        return 'Minggu';
      default:
        return dayName;
    }
  }

  static String getNamaHari(int? millis) {
    if (millis == null) return '';
    var ret = DateFormat('EEE').format(convertMillis2Date(millis));
    switch (ret.toLowerCase()) {
      case 'sun':
        return 'minggu';
      case 'mon':
        return 'senin';
      case 'tue':
        return 'selasa';
      case 'wed':
        return 'rabu';
      case 'thu':
        return 'kamis';
      case 'fri':
        return 'jumat';
      case 'sat':
        return 'sabtu';
      default:
        return ret;
    }
  }

  static String getNamaBulan(int monthIndex) {
    switch (monthIndex) {
      case DateTime.january:
        return 'Januari';
      case DateTime.february:
        return 'Februari';
      case DateTime.march:
        return 'Maret';
      case DateTime.april:
        return 'April';
      case DateTime.may:
        return 'Mei';
      case DateTime.june:
        return 'Juni';
      case DateTime.july:
        return 'July';
      case DateTime.august:
        return 'Agustus';
      case DateTime.september:
        return 'September';
      case DateTime.october:
        return 'Oktober';
      case DateTime.november:
        return 'November';
      case DateTime.december:
        return 'Desember';
      default:
        return '-';
    }
  }

  static String greetingEnglish() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  static String greetingIndonesia() {
    var hour = DateTime.now().hour;
    if (hour >= 3 && hour < 11) {
      return 'Pagi';
    } else if (hour >= 11 && hour < 15) {
      return 'Siang';
    } else if (hour >= 15 && hour <= 18) {
      return 'Sore';
    }

    return 'Malam';
  }

  static String getCurrentPeriode() => convertDateToString(DateTime.now(), 'yyyyMM');

  /// return the last date of selected month
  static int getLastDateOfMonth(DateTime date) => DateTime(date.year, date.month + 1, 0).day;

  static String prettyShortDateNoYear(int millis) {
    var dt = convertMillis2Date(millis);
    return convertDateToString(dt, 'd MMM');
  }

  static int countExpired(List<DateTime> list) => list.where((e) => e.isExpired).length;
}
