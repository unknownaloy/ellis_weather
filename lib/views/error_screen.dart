import 'package:ellis_weather/utilities/const.dart';
import 'package:ellis_weather/components/wrapper.dart';
import 'package:ellis_weather/view_models/city_search_view_model.dart';
import 'package:ellis_weather/view_models/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Main weather view model
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    final weatherState = weatherViewModel.weatherState;

    /// City view model
    final cityViewModel = Provider.of<CitySearchViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/default_image.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.srcATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Error message
              Text(
                "Sorry something went wrong",
                textAlign: TextAlign.center,
                style: kErrorMessageTextStyle,
              ),
              SizedBox(
                height: 32.0,
              ),

              /// "Try again" button
              ElevatedButton(
                onPressed: () {
                  if (weatherState == WeatherState.ERROR) {
                    weatherViewModel.fetchWeatherData();
                  } else {
                    cityViewModel.fetchCityWeatherData();
                  }
                },
                child: Text("Try again!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
