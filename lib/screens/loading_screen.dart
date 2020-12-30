import 'package:ellis_weather/screens/error_screen.dart';
import 'package:ellis_weather/screens/landing_screen.dart';
import 'package:ellis_weather/services/weather_service.dart';
import 'package:ellis_weather/utilities/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherService _weatherService = WeatherService();

  void _getWeatherData() async {
    // var weatherData = await _weatherService.getWeatherData();
    GlobalVariables.weatherData = await _weatherService.getWeatherData();
    // String cityName = _weatherService.cityName;
    GlobalVariables.cityName = _weatherService.cityName;

    if (GlobalVariables.weatherData != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LandingScreen();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ErrorScreen();
      }));
    }
  }

  @override
  void initState() {
    super.initState();

    _getWeatherData();

    /// TODO: Make weather data query here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/default_image.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.75), BlendMode.srcATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: SpinKitSpinningCircle(
            color: Color.fromRGBO(253, 184, 19, 1),
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
