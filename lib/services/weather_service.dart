import 'dart:convert';

import 'package:ellis_weather/models/weather_data.dart';
import 'package:ellis_weather/services/location_service.dart';
import 'package:ellis_weather/utilities/api_key.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  late String cityName;

  /// Method to get weather data of the current location using the "One Call"
  /// method from "openweathermap.org"
  Future<WeatherData?> getWeatherData() async {
    try {
      LocationService locatorService = LocationService();
      print("locator service");
      await locatorService.getCurrentLocation();

      final coordinates =
          new Coordinates(locatorService.latitude, locatorService.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      cityName = first.locality!;

      var url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=${locatorService.latitude}&lon=${locatorService.longitude}&exclude=hourly,minutely,alerts&appid=$apiKey&units=metric");

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String data = response.body;
        final decodedData = jsonDecode(data);
        WeatherData weatherData = WeatherData.fromJson(decodedData);
        weatherData.cityName = cityName;
        return weatherData;
        return jsonDecode(data);
      } else {
        throw Exception(
            "Weather data not currently available in your location");
      }
    } catch (e) {
      /// TODO: Throw a better error message here and add on Socket Exception
      print(e);
    }
  }

  String getWeatherIcon(String? iconCode) {
    String openWeatherIconCode =
        "http://openweathermap.org/img/wn/$iconCode@2x.png";
    return openWeatherIconCode;
  }

  Future<dynamic> getWeatherByCityName(String cityName) async {
    try {
      var url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String data = response.body;
        print(response.body);
        return jsonDecode(data);
      } else {
        print("Error");
        throw Exception("Error");
      }
    } catch (e) {
      print(e);
    }
  }
}
