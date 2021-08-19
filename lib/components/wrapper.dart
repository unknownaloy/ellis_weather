import 'package:ellis_weather/components/loader.dart';
import 'package:ellis_weather/view_models/weather_view_model.dart';
import 'package:ellis_weather/views/error_screen.dart';
import 'package:ellis_weather/views/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();

    Provider.of<WeatherViewModel>(context, listen: false).fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = Provider.of<WeatherViewModel>(context).weatherState;

    if (weatherState == WeatherState.LOADING) {
      return Loader();
    } else if (weatherState == WeatherState.ERROR) {
      return ErrorScreen();
    } else {
      return LandingScreen();
    }
  }
}
