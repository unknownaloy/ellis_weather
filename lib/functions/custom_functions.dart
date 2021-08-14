import 'package:intl/intl.dart';

class CustomFunctions {
  /// Hour and minutes format
  static final _hourMinutesFormat = DateFormat('jm');

  static final _weekdayMonthDayFormat = DateFormat("EEEE, LLL d");

  static String hourMinutesFormatter(int? timeStamp) {
    if (timeStamp == null) {
      int year = DateTime.now().year;
      return year.toString();
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _hourMinutesFormat.format(dateTime);

    return result;
  }

  static String weekDayMonthDayFormatter(int? timeStamp) {
    if (timeStamp == null) return "Today";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _weekdayMonthDayFormat.format(dateTime);

    return result;
  }
}
