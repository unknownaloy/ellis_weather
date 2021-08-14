import 'package:ellis_weather/screens/error_screen.dart';
import 'package:ellis_weather/screens/landing_screen.dart';
import 'package:ellis_weather/screens/loading_screen.dart';
import 'package:ellis_weather/services/weather_service.dart';
import 'package:ellis_weather/utilities/global_variables.dart';
import 'package:ellis_weather/view_models/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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

    Provider.of<WeatherViewModel>(context, listen: false).fetchWeatherData();

    // _getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    if (viewModel.weatherState == WeatherState.LOADING) {
      return LoadingScreen();
    } else if (viewModel.weatherState == WeatherState.ERROR) {
      return ErrorScreen();
    } else {
      print("Weather has data");
      print(
          "DATA TESTING => ${viewModel.weatherData.current!.weather![0].main}");
      return Text("Data present!");
    }
  }
}
