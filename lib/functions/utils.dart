import 'package:intl/intl.dart';

class Utils {
  /// Refer to the intl date format documentation, link below =>
  /// [https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html]
  static final _hourMinutesFormat = DateFormat('jm');

  static final _weekdayMonthDayFormat = DateFormat("EEEE, LLL d");

  static final _abrWeekDayMonthDayFormat = DateFormat("E, LLL d");

  /// This method takes in the time stamp which is an integer value of
  /// "milli seconds since epoch" and formats it using [_hourMinutesFormat]
  /// e.g. => 12:00 AM
  static String hourMinutesFormatter(int? timeStamp) {
    if (timeStamp == null) {
      int year = DateTime.now().year;
      return year.toString();
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _hourMinutesFormat.format(dateTime);

    return result;
  }

  /// This method takes in the time stamp which is an integer value of
  /// "milli seconds since epoch" and formats it using [_weekdayMonthDayFormat]
  /// e.g. => Monday, Jan 1
  static String weekdayMonthDayFormatter(int? timeStamp) {
    if (timeStamp == null) return "Today";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _weekdayMonthDayFormat.format(dateTime);

    return result;
  }

  /// This method takes in the time stamp which is an integer value of
  /// "milli seconds since epoch" and formats it using [_abrWeekDayMonthDayFormat]
  /// e.g. => Mon, Jan 10
  static String abbrWeekdayMonthFormatter(int? timeStamp) {
    if (timeStamp == null) return "000";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String result = _abrWeekDayMonthDayFormat.format(dateTime);

    return result;
  }

  /// This method is responsible for adding ordinal symbols to the end of a number
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

  /// This method uses the icon code from an API call to generate the right URL
  /// to fetch the weather icon
  static String generateIconUrl(String? iconCode) {
    return "http://openweathermap.org/img/wn/$iconCode@2x.png";
  }

  /// This method uses the weather icon code to generate a matching background
  /// image for the weather condition
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

  /// This method uses the passed in temperature formulate a message feedback
  /// for the user
  static String generateWeatherMessage(int? temp) {
    if (temp == null) return "Weather is boring";

    if (temp > 25) {
      return "It's 🍦 time";
    } else if (temp > 20) {
      return "Time for shorts and 👕";
    } else if (temp < 10) {
      return "You'll need 🧣 and 🧤";
    } else {
      return "Bring a 🧥 just in case";
    }
  }

  /// This method capitalizes the first letter of every word passed in
  static String capitalizeFirstLetterOfWords(String? words) {
    if (words == null) return "";

    String formattedWords;
    formattedWords = words
        .toLowerCase()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return formattedWords;
  }
}
