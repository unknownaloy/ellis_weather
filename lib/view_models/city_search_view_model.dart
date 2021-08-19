import 'package:ellis_weather/utilities/utils.dart';
import 'package:ellis_weather/models/city_weather_data.dart';
import 'package:ellis_weather/services/weather_service.dart';
import 'package:flutter/foundation.dart';

enum CityState {
  LOADING,
  ERROR,
  DATA_PRESENT,
}

class CitySearchViewModel extends ChangeNotifier {
  late String _cityName;

  String get cityName => _cityName;

  late CityWeatherData _cityData;

  CityWeatherData get cityData => _cityData;

  CityState _cityState = CityState.LOADING;

  CityState get cityState => _cityState;

  void setCityName(String searchedName) {
    searchedName = Utils.capitalizeFirstLetterOfWords(searchedName);
    _cityName = searchedName;
  }

  Future<void> fetchCityWeatherData() async {
    if (_cityState != CityState.LOADING) {
      _cityState = CityState.LOADING;
      notifyListeners();
    }
    WeatherService weatherService = WeatherService();
    weatherService.getWeatherByCityName(_cityName).then((data) {
      _cityData = CityWeatherData.fromJson(data);

      _cityState = CityState.DATA_PRESENT;
    }).catchError((onError) {
      _cityState = CityState.ERROR;
    }).whenComplete(() {
      // Call notifyListeners
      notifyListeners();
    });
  }
}
