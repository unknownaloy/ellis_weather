import 'package:ellis_weather/screens/city_weather_screen.dart';
import 'package:ellis_weather/screens/landing_screen.dart';
import 'package:ellis_weather/utilities/const.dart';
import 'package:flutter/material.dart';

class SearchByCity extends StatefulWidget {
  @override
  _SearchByCityState createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _cityName = "";

  /// Text Controller listener method
  void textControllerListener() {
    _cityName = _textController.text.toLowerCase().trim();
  }

  @override
  void initState() {
    super.initState();

    _textController.addListener(textControllerListener);
  }

  @override
  void dispose() {
    _textController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return LandingScreen();
            }));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/default_image.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.srcATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _textController,
                    focusNode: _searchFocusNode,
                    autofocus: true,
                    style: TextStyle(color: Colors.black),
                    decoration: kTextFieldInputDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    String searchQuery = _cityName;
                    if (searchQuery.length > 1) {
                      if (_searchFocusNode.hasFocus) {
                        _searchFocusNode.unfocus();
                      }
                      _textController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityWeatherScreen(
                              cityName: searchQuery,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Get Weather',
                    style: kButtonTextStyle,
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
