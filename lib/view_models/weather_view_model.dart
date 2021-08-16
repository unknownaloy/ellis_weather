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
    print("Fetching data from weatherViewModel");
    _weatherService.getWeatherData().then((data) {
      _weatherData = WeatherData.fromJson(data);
      _weatherData.cityName = _weatherService.cityName;

      _weatherState = WeatherState.DATA_PRESENT;
    }).catchError((onError) {
      _weatherState = WeatherState.ERROR;
    }).whenComplete(() {
      notifyListeners();
    });
  }
}
