import 'package:ellis_weather/models/weather_data.dart';
import 'package:ellis_weather/services/weather_service.dart';
import 'package:flutter/cupertino.dart';

enum WeatherState {
  LOADING,
  DATA_PRESENT,
  ERROR,
}

class WeatherViewModel extends ChangeNotifier {
  WeatherService _weatherService = WeatherService();

  WeatherState _weatherState = WeatherState.LOADING;

  late WeatherData _weatherData;

  WeatherState get weatherState => _weatherState;

  WeatherData get weatherData => _weatherData;

  Future<void> fetchWeatherData() async {
    print("Hello friend");
    _weatherService.getWeatherData().then((data) {
      print("Getting data...");
      _weatherData = WeatherData.fromJson(data);
      _weatherData.cityName = _weatherService.cityName;
      print(_weatherData.current!.weather![0].description);
      _weatherState = WeatherState.DATA_PRESENT;

      // notifyListeners();
    }).catchError((onError) {
      print("Error");
      _weatherState = WeatherState.ERROR;
      // notifyListeners();
    }).whenComplete(() {
      print("Listeners were notified");
      notifyListeners();
    });

    // notifyListeners();
  }
}
