import 'package:ellis_weather/services/weather_service.dart';
import 'package:ellis_weather/utilities/const.dart';
import 'package:ellis_weather/utilities/weather_brain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CityWeatherScreen extends StatefulWidget {
  final cityName;

  CityWeatherScreen({required this.cityName});

  @override
  _CityWeatherScreenState createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  WeatherService _weatherService = WeatherService();

  bool _isLoading = true;

  dynamic weatherData;

  late int temperature;
  late String description;
  late String cityName;
  late String weatherMessage;
  String? weatherIcon;
  late int feelsLike;
  late int humidity;
  late int maxTemp;
  late int minTemp;
  late String sunriseTime;
  late String sunsetTime;
  String? currentDateTime;

  String weatherImagePath = "default_image";

  Widget errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Problem occurred while getting city weather data. Please check city name and try again",
          textAlign: TextAlign.center,
          style: kErrorMessageTextStyle.copyWith(fontSize: 24.0),
        ),
        SizedBox(
          height: 24.0,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Try again!"),
        ),
      ],
    );
  }

  Widget weatherDataWidget() {
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 56.0),
              child: Column(
                children: [
                  /// City name
                  Text(
                    cityName,
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

                  /// MAX Temperature and MIN Temperature
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MAX Temp: $maxTemp°C",
                        style: kContentTextStyle,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "MIN Temp: $minTemp°C",
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "$weatherMessage in $cityName",
                style: kWeatherMessageTextStyle,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget validWidget() {
    if (weatherData != null) {
      return weatherDataWidget();
    } else {
      return errorWidget();
    }
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

  /// Method that updates the screen with the information of the weather data
  ///
  /// NOTE: This method is called in the initState
  void updateUI() async {
    weatherData = await _weatherService.getWeatherByCityName(widget.cityName);
    setState(() {
      _isLoading = false;
    });
    if (weatherData != null) {
      setState(() {
        temperature = weatherData["main"]["temp"].toInt();
        description = weatherData["weather"][0]["description"];
        description = WeatherBrain.capitalizeFirstLetterOfWords(description);
        weatherMessage = _weatherService.getMessage(temperature);
        String? icon = weatherData["weather"][0]["icon"];
        weatherIcon = _weatherService.getWeatherIcon(icon);
        feelsLike = weatherData["main"]["feels_like"].toInt();
        humidity = weatherData["main"]["humidity"].toInt();
        maxTemp = weatherData["main"]["temp_max"].toInt();
        minTemp = weatherData["main"]["temp_min"].toInt();
        int sunrise = weatherData["sys"]["sunrise"];
        int sunset = weatherData["sys"]["sunset"];
        DateTime sunriseDate =
            DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
        DateTime sunsetDate =
            DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
        sunriseTime = kHourMinuteFormat.format(sunriseDate);
        sunsetTime = kHourMinuteFormat.format(sunsetDate);
        cityName = weatherData["name"];
        weatherBackgroundGenerator(icon);
        int dateTime = weatherData["dt"];
        final timeFormat = DateFormat("EEEE, LLL d");
        DateTime cityDateTime =
            DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
        currentDateTime = timeFormat.format(cityDateTime);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(currentDateTime ?? " "),
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
        child: _isLoading
            ? Center(
                child: SpinKitSpinningCircle(
                  color: Color.fromRGBO(253, 184, 19, 1),
                  size: 100.0,
                ),
              )
            : validWidget(),
      ),
    );
  }
}
