import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter city name here!',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
    size: 48.0,
  ),
);

final kButtonTextStyle = GoogleFonts.roboto(
  fontSize: 30.0,
  color: Color.fromRGBO(253, 184, 19, 1),
  fontWeight: FontWeight.w700,
);

final kTempTextStyle = GoogleFonts.roboto(
  fontSize: 64.0,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(253, 184, 19, 1),
);

final kCityNameTextStyle = GoogleFonts.roboto(
    fontSize: 56.0, fontWeight: FontWeight.w500, color: Colors.white);

final kContentTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 12.0,
);

final kWeatherMessageTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 32.0,
);

final kErrorMessageTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w500,
  fontSize: 40.0,
  color: Colors.white,
);
