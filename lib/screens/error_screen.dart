import 'package:ellis_weather/screens/loading_screen.dart';
import 'package:ellis_weather/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return LoadingScreen();
                  }));
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
