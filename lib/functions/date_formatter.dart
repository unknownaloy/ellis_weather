import 'package:intl/intl.dart';

int _generateSystemTime() {
  return DateTime.now().millisecondsSinceEpoch;
}

class DateTimeFormatter {
  final int Function() _getCurrentTime;

  DateTimeFormatter([this._getCurrentTime = _generateSystemTime]);

  final _hourMinutesFormat = DateFormat('jm');

  final _weekdayMonthDayFormat = DateFormat("EEEE, LLL d");

  final _abrWeekDayMonthDayFormat = DateFormat("E, LLL d");

  /// This method takes in the time stamp which is an integer value of
  /// "milli seconds since epoch" and formats it using [_hourMinutesFormat]
  String hourMinutesFormatter(int? timeStamp) {
    if (timeStamp == null) {
      final now = _getCurrentTime();
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(now * 1000);

      return _hourMinutesFormat.format(dateTime);
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _hourMinutesFormat.format(dateTime);

    return result;
  }

  /// This method takes in the time stamp which is an integer value of
  /// "milli seconds since epoch" and formats it using [_weekdayMonthDayFormat]
  /// e.g. => Monday, Jan 1
  String weekdayMonthDayFormatter(int? timeStamp) {
    if (timeStamp == null) {
      final now = _getCurrentTime();
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(now * 1000);

      return _weekdayMonthDayFormat.format(dateTime);
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _weekdayMonthDayFormat.format(dateTime);

    return result;
  }

  /// This method takes in the time stamp which is an integer value of
  /// "milli seconds since epoch" and formats it using [_abrWeekDayMonthDayFormat]
  /// e.g. => Mon, Jan 10
  String abbrWeekdayMonthFormatter(int? timeStamp) {
    if (timeStamp == null) {
      final now = _getCurrentTime();
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(now * 1000);
      return _abrWeekDayMonthDayFormat.format(dateTime);
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _abrWeekDayMonthDayFormat.format(dateTime);

    return result;
  }
}
