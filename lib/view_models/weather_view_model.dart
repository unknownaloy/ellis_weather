import 'package:ellis_weather/models/weather_data.dart';
import 'package:ellis_weather/services/weather_service.dart';
import 'package:flutter/cupertino.dart';

enum WeatherState {
  LOADING,
  ERROR,
  DATA_PRESENT,
}

class WeatherViewModel extends ChangeNotifier {
  WeatherService _weatherService = WeatherService();

  WeatherState _weatherState = WeatherState.LOADING;

  late WeatherData _weatherData;

  WeatherState get weatherState => _weatherState;

  WeatherData get weatherData => _weatherData;

  Future<void> fetchWeatherData() async {
    if (_weatherState != WeatherState.LOADING) {
      _weatherState = WeatherState.LOADING;
      notifyListeners();
    }

    try {
      WeatherData? temp = await _weatherService.getWeatherData();
      if (temp != null) {
        _weatherData = temp;
        _weatherState = WeatherState.DATA_PRESENT;
        notifyListeners();
      } else {
        _weatherState = WeatherState.ERROR;
        notifyListeners();
      }
    } catch (e) {
      _weatherState = WeatherState.ERROR;
      notifyListeners();
    }

    // _weatherService.getWeatherData().then((data) {
    //   _weatherData = WeatherData.fromJson(data);
    //   _weatherData.cityName = _weatherService.cityName;
    //
    //   _weatherState = WeatherState.DATA_PRESENT;
    // }).catchError((onError) {
    //   _weatherState = WeatherState.ERROR;
    // }).whenComplete(() {
    //   notifyListeners();
    // });
  }

  Future<void> pullToRefresh() async {
    WeatherData? temp = await _weatherService.getWeatherData();
    if (temp != null) {
      _weatherData = temp;
      notifyListeners();
    }
  }
}
