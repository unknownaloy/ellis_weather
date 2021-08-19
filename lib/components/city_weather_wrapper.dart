import 'package:ellis_weather/components/loader.dart';
import 'package:ellis_weather/view_models/city_search_view_model.dart';
import 'package:ellis_weather/views/city_weather_screen.dart';
import 'package:ellis_weather/views/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityWeatherWrapper extends StatefulWidget {
  CityWeatherWrapper({Key? key}) : super(key: key);

  @override
  _CityWeatherWrapperState createState() => _CityWeatherWrapperState();
}

class _CityWeatherWrapperState extends State<CityWeatherWrapper> {
  @override
  void initState() {
    super.initState();

    Provider.of<CitySearchViewModel>(context, listen: false)
        .fetchCityWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final cityViewModel = Provider.of<CitySearchViewModel>(context);
    final cityState = cityViewModel.cityState;

    if (cityState == CityState.LOADING) {
      return Loader();
    } else if (cityState == CityState.ERROR) {
      return ErrorScreen(
        onPressed: () {
          cityViewModel.fetchCityWeatherData();
        },
      );
    } else {
      return CityWeatherScreen();
    }
  }
}
