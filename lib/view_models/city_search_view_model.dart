import 'package:ellis_weather/services/weather_service.dart';
import 'package:flutter/foundation.dart';

class CitySearchViewModel extends ChangeNotifier {
  late String _cityName;

  String get cityName => _cityName;

  void setCityName(String searchedName) {
    _cityName = searchedName;
  }

  Future<void> fetchCityWeatherData() async {
    WeatherService weatherService = WeatherService();

    weatherService
        .getWeatherByCityName(_cityName)
        .then((cityData) {})
        .catchError((onError) {
      // Do something with the error
    }).whenComplete(() {
      // Call notifyListeners
    });
  }
}
