import 'package:ellis_weather/screens/loading_screen.dart';
import 'package:ellis_weather/screens/search_by_city.dart';
import 'package:ellis_weather/services/weather_service.dart';
import 'package:ellis_weather/utilities/const.dart';
import 'package:ellis_weather/utilities/global_variables.dart';
import 'package:ellis_weather/utilities/weather_brain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  WeatherService _weatherService = WeatherService();

  int temperature = 0;
  String? weatherIcon;
  late String description;
  late String weatherMessage;
  late int feelsLike;
  late int humidity;
  late String sunriseTime;
  late String sunsetTime;
  late String currentDateTime;
  dynamic dailyDynamicData;

  String weatherImagePath = "default_image";

  /// Datetime variable needed for double-tap to exit the activity
  DateTime? _currentBackPressTime;

  /// Method for showing toast messages to the user
  void showToastMessage(String toastMessage) {
    Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 5,
      textColor: Colors.black,
      backgroundColor: Colors.white70,
      gravity: ToastGravity.BOTTOM,
    );
  }

  /// Method to exit the app
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      showToastMessage("Press back again to exit");

      return Future.value(false);
    }

    /// TODO: Check if this code to exit app works on iOS
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', true);

    // SystemNavigator.pop();
    return Future.value(true);
  }

  /// This method uses the weather icon code to determine the background image to
  /// use in displaying the weather information
  void weatherBackgroundGenerator(String? iconCode) {
    /// Remove the last letter of the String
    if (iconCode != null && iconCode != "") {
      int stringLength = iconCode.length - 1;
      iconCode = iconCode.substring(0, stringLength);
      if (iconCode == "01") {
        if (weatherImagePath != "clear_sky") {
          setState(() {
            weatherImagePath = "clear_sky";
          });
        }
      } else if (iconCode == "02") {
        if (weatherImagePath != "few_clouds") {
          setState(() {
            weatherImagePath = "few_clouds";
          });
        }
      } else if (iconCode == "03") {
        if (weatherImagePath != "scattered_clouds") {
          setState(() {
            weatherImagePath = "scattered_clouds";
          });
        }
      } else if (iconCode == "04") {
        if (weatherImagePath != "broken_clouds") {
          setState(() {
            weatherImagePath = "broken_clouds";
          });
        }
      } else if (iconCode == "09" || iconCode == "10") {
        if (weatherImagePath != "rain") {
          setState(() {
            weatherImagePath = "rain";
          });
        }
      } else if (iconCode == "11") {
        if (weatherImagePath != "thunderstorm") {
          setState(() {
            weatherImagePath = "thunderstorm";
          });
        }
      } else if (iconCode == "13") {
        if (weatherImagePath != "snow") {
          setState(() {
            weatherImagePath = "snow";
          });
        }
      } else if (iconCode == "50") {
        if (weatherImagePath != "mist") {
          setState(() {
            weatherImagePath = "mist";
          });
        }
      } else {
        if (weatherImagePath != "default_image") {
          setState(() {
            weatherImagePath = "default_image";
          });
        }
      }
    }
  }

  List<TableRow> tableWidgets(dynamic data) {
    List<TableRow> widgets = [];

    String addToDateEnd(String currentDate) {
      String result;

      int stringLength = currentDate.length - 1;

      if (currentDate[stringLength] == "1") {
        result = "st";
      } else if (currentDate[stringLength] == "2") {
        result = "nd";
      } else if (currentDate[stringLength] == "3") {
        result = "rd";
      } else {
        result = "th";
      }

      return result;
    }

    final dayOfWeekFormat = DateFormat("E, LLL d");

    /// Adding the headings for the daily weather forecast table
    TableRow tableHeading = TableRow(
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      children: [
        Text(
          "DAY OF WEEK",
          style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          "MAX",
          style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        Text(
          "MIN",
          style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        Text(
          "Humidity %",
          style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ],
    );

    widgets.add(tableHeading);

    /// Looping through the daily weather forecast and mapping its data to a TableRow
    /// NOTE: The first daily data is omitted because it's the same as the current
    /// weather data
    for (int i = 1; i < data.length; i++) {
      DateTime dayOfWeekDateTime =
          DateTime.fromMillisecondsSinceEpoch(data[i]["dt"] * 1000);
      String dayOfWeek = dayOfWeekFormat.format(dayOfWeekDateTime);
      int? maxTemp = data[i]["temp"]["max"].toInt();
      int? minTemp = data[i]["temp"]["min"].toInt();
      int? humidity = data[i]["humidity"].toInt();
      String? icon = data[i]["weather"][0]["icon"];
      String weatherIcon = _weatherService.getWeatherIcon(icon);

      TableRow tableRowChunk = TableRow(
        children: [
          Text(
            "$dayOfWeek${addToDateEnd(dayOfWeek)}",
            style: kContentTextStyle,
          ),
          Text(
            "$maxTemp°C",
            style: kContentTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            "$minTemp°C",
            style: kContentTextStyle,
            textAlign: TextAlign.center,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              weatherIcon != null
                  ? Image.network(
                      weatherIcon,
                      width: 32,
                      height: 32,
                    )
                  : SizedBox.shrink(),
              Text(
                "$humidity%",
                style: kContentTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      );

      widgets.add(tableRowChunk);
    }

    return widgets;
  }

  /// Method that updates the screen with the information of the weather data
  ///
  /// NOTE: This method is called in the initState
  void updateUI() {
    setState(() {
      temperature = GlobalVariables.weatherData["current"]["temp"].toInt();
      String? icon =
          GlobalVariables.weatherData["current"]["weather"][0]["icon"];
      weatherIcon = _weatherService.getWeatherIcon(icon);
      description =
          GlobalVariables.weatherData["current"]["weather"][0]["description"];
      description = WeatherBrain.capitalizeFirstLetterOfWords(description);
      weatherMessage = _weatherService.getMessage(temperature.toInt());
      feelsLike = GlobalVariables.weatherData["current"]["feels_like"].toInt();
      humidity = GlobalVariables.weatherData["current"]["humidity"].toInt();
      int sunrise = GlobalVariables.weatherData["current"]["sunrise"];
      int sunset = GlobalVariables.weatherData["current"]["sunset"];
      DateTime sunriseDate =
          DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
      DateTime sunsetDate = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
      sunriseTime = kHourMinuteFormat.format(sunriseDate);
      sunsetTime = kHourMinuteFormat.format(sunsetDate);
      weatherBackgroundGenerator(icon);
      int dateTime = GlobalVariables.weatherData["current"]["dt"];
      DateTime dateTimeData =
          DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
      final timeFormat = DateFormat("EEEE, LLL d");
      currentDateTime = timeFormat.format(dateTimeData);
      dailyDynamicData = GlobalVariables.weatherData["daily"];
    });
  }

  @override
  void initState() {
    super.initState();

    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoadingScreen();
                }));
              },
              icon: Icon(
                Icons.refresh,
                size: 32.0,
                color: Colors.grey,
              ),
            ),
            title: Text(currentDateTime),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 32.0,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SearchByCity();
                    }));
                  }),
              SizedBox(
                width: 16.0,
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/$weatherImagePath.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.75), BlendMode.srcATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        children: [
                          /// City Name
                          Text(
                            GlobalVariables.cityName,
                            style: kCityNameTextStyle,
                          ),

                          /// Weather Description
                          Text(
                            description,
                            style: kContentTextStyle,
                          ),

                          /// Weather Temperature
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '$temperature°C',
                                style: kTempTextStyle,
                              ),
                              weatherIcon != null
                                  ? Image.network(
                                      weatherIcon!,
                                      width: 96,
                                      height: 96,
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),

                          /// Feels like and Humidity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Feels like: $feelsLike°C",
                                style: kContentTextStyle,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                "Humidity: $humidity%",
                                style: kContentTextStyle,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10.0,
                          ),

                          /// Sunrise and Sunset
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sunrise: $sunriseTime",
                                style: kContentTextStyle,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              SvgPicture.asset(
                                'images/sunrise.svg',
                                color: Color.fromRGBO(253, 184, 19, 1),
                                width: 14.0,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                "Sunset: $sunsetTime",
                                style: kContentTextStyle,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              SvgPicture.asset(
                                'images/sunset.svg',
                                color: Color.fromRGBO(253, 184, 19, 1),
                                width: 14.0,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 96.0,
                          ),

                          /// Daily Forecast
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 56.0, left: 2.0, right: 2.0),
                            child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              border: TableBorder(
                                top: BorderSide(color: Colors.black, width: 1),
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                              columnWidths: {0: FractionColumnWidth(.4)},
                              children: tableWidgets(dailyDynamicData),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
