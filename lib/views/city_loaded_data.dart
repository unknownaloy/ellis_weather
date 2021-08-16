import 'package:ellis_weather/functions/utils.dart';
import 'package:ellis_weather/utilities/const.dart';
import 'package:ellis_weather/view_models/city_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CityLoadedData extends StatelessWidget {
  const CityLoadedData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CitySearchViewModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title:
            Text("${Utils.weekdayMonthDayFormatter(data.cityData.dateTime)}"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/${Utils.generateBackgroundImage(data.cityData.weather?[0].icon)}.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.75), BlendMode.srcATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 56.0),
                  child: Column(
                    children: [
                      /// City name
                      Text(
                        data.cityName,
                        style: kCityNameTextStyle,
                      ),

                      /// Weather Description
                      Text(
                        "${data.cityData.weather![0].description}", // description,
                        style: kContentTextStyle,
                      ),

                      /// Weather Temperature
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${data.cityData.cityMain!.temp!.toInt()}°C',
                            style: kTempTextStyle,
                          ),
                          data.cityData.weather?[0].icon != null
                              ? Image.network(
                                  "${Utils.generateIconUrl(data.cityData.weather![0].icon)}",
                                  width: 96,
                                  height: 96,
                                )
                              : SizedBox.shrink(),
                        ],
                      ),

                      /// Feels like and Humidity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Feels like: ${data.cityData.cityMain!.feelsLike!.toInt()}°C",
                            style: kContentTextStyle,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "Humidity: ${data.cityData.cityMain!.humidity}%",
                            style: kContentTextStyle,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

                      /// MAX Temperature and MIN Temperature
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "MAX Temp: ${data.cityData.cityMain!.maxTemp}°C",
                            style: kContentTextStyle,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "MIN Temp: ${data.cityData.cityMain!.minTemp}°C",
                            style: kContentTextStyle,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

                      /// Sunrise and Sunset
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sunrise: ${Utils.hourMinutesFormatter(data.cityData.citySys!.sunrise)}",
                            style: kContentTextStyle,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          SvgPicture.asset(
                            'images/sunrise.svg',
                            color: Color.fromRGBO(253, 184, 19, 1),
                            width: 14.0,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "Sunset: ${Utils.hourMinutesFormatter(data.cityData.citySys!.sunset)}",
                            style: kContentTextStyle,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          SvgPicture.asset(
                            'images/sunset.svg',
                            color: Color.fromRGBO(253, 184, 19, 1),
                            width: 14.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "${Utils.generateWeatherMessage(data.cityData.cityMain!.temp!.toInt())} in ${data.cityName}",
                    style: kWeatherMessageTextStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}