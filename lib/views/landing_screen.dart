import 'package:cached_network_image/cached_network_image.dart';
import 'package:ellis_weather/functions/date_formatter.dart';
import 'package:ellis_weather/utilities/utils.dart';
import 'package:ellis_weather/utilities/const.dart';
import 'package:ellis_weather/view_models/weather_view_model.dart';
import 'package:ellis_weather/views/search_by_city.dart';
import 'package:ellis_weather/components/weekdays_weather_table.dart';
import 'package:ellis_weather/components/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));

    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherViewModel>(context).weatherData;
    final dateFormatter = DateTimeFormatter();
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
                /// Use pull to refresh here
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Wrapper();
                }));
              },
              icon: Icon(
                Icons.refresh,
                size: 32.0,
                color: Colors.grey,
              ),
            ),
            title: Text(
                "${dateFormatter.weekdayMonthDayFormatter(weatherData.current!.dateTime)}"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 32.0,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchByCity();
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                width: 16.0,
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/${Utils.generateBackgroundImage(weatherData.current!.weather?[0].icon)}.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.75), BlendMode.srcATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: Center(
              child: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () {
                    return Provider.of<WeatherViewModel>(context, listen: false)
                        .pullToRefresh();
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Column(
                          children: [
                            /// City Name
                            Text(
                              weatherData.cityName ?? "...",
                              style: kCityNameTextStyle,
                            ),

                            /// Weather Description
                            Text(
                              "${Utils.capitalizeFirstLetterOfWords(weatherData.current!.weather?[0].description)}", // description,
                              style: kContentTextStyle,
                            ),

                            /// Weather Temperature
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${weatherData.current!.temp!.toInt()}°C", // '$temperature°C',
                                  style: kTempTextStyle,
                                ),
                                weatherData.current!.weather?[0].icon != null
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            "${Utils.generateIconUrl(weatherData.current!.weather![0].icon)}",
                                        width: 96.0,
                                        height: 96.0,
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),

                            /// Feels like and Humidity
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Feels like: ${weatherData.current!.feelsLike!.toInt()}°C",
                                  style: kContentTextStyle,
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Text(
                                  "Humidity: ${weatherData.current!.humidity}%",
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
                                  "Sunrise: ${dateFormatter.hourMinutesFormatter(weatherData.current!.sunrise)}",
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
                                  "Sunset: ${dateFormatter.hourMinutesFormatter(weatherData.current!.sunset)}",
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
                              child: WeekdaysWeatherTable(),
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
      ),
    );
  }
}
