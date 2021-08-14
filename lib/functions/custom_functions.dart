import 'package:intl/intl.dart';

class CustomFunctions {
  /// Hour and minutes format
  static final _hourMinutesFormat = DateFormat('jm');

  static final _weekdayMonthDayFormat = DateFormat("EEEE, LLL d");

  static final _abrWeekDayMonthDayFormat = DateFormat("E, LLL d");

  static String hourMinutesFormatter(int? timeStamp) {
    if (timeStamp == null) {
      int year = DateTime.now().year;
      return year.toString();
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _hourMinutesFormat.format(dateTime);

    return result;
  }

  static String weekdayMonthDayFormatter(int? timeStamp) {
    if (timeStamp == null) return "Today";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _weekdayMonthDayFormat.format(dateTime);

    return result;
  }

  static String testingOne(int? timeStamp) {
    if (timeStamp == null) return "000";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _abrWeekDayMonthDayFormat.format(dateTime);

    return result;
  }

  static String addOrdinalSymbol(String? dateTime) {
    if (dateTime == null) return "";
    late String result;

    int stringLength = dateTime.length - 1;

    if (dateTime[stringLength] == "1") {
      result = "st";
    } else if (dateTime[stringLength] == "2") {
      result = "nd";
    } else if (dateTime[stringLength] == "3") {
      result = "rd";
    } else {
      result = "th";
    }

    return result;
  }

  static String generateIconUrl(String? iconCode) {
    return "http://openweathermap.org/img/wn/$iconCode@2x.png";
  }

  static String generateBackgroundImage(String? iconCode) {
    if (iconCode == null || iconCode == "") return "default_image";

    int stringLength = iconCode.length - 1;

    iconCode = iconCode.substring(0, stringLength);

    late String backgroundImage;

    switch (iconCode) {
      case "01":
        backgroundImage = "clear_sky";
        break;
      case "02":
        backgroundImage = "few_clouds";
        break;
      case "03":
        backgroundImage = "scattered_clouds";
        break;
      case "04":
        backgroundImage = "broken_clouds";
        break;
      case "09":
        backgroundImage = "rain";
        break;
      case "10":
        backgroundImage = "rain";
        break;
      case "11":
        backgroundImage = "thunderstorm";
        break;
      case "13":
        backgroundImage = "snow";
        break;
      case "50":
        backgroundImage = "mist";
        break;
      default:
        backgroundImage = "default_image";
        break;
    }

    return backgroundImage;
  }
}
