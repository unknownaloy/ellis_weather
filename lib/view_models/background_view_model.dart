import 'package:flutter/foundation.dart';

class BackgroundViewModel extends ChangeNotifier {
  String _background = "default_image";

  String get background => _background;

  void generateBackgroundImage(String? iconCode) {
    if (iconCode == null || iconCode == "") return;

    int stringLength = iconCode.length - 1;

    iconCode = iconCode.substring(0, stringLength);

    switch (iconCode) {
      case "01":
        _background = "clear_sky";
        break;
      case "02":
        _background = "few_clouds";
        break;
      case "03":
        _background = "scattered_clouds";
        break;
      case "04":
        _background = "broken_clouds";
        break;
      case "09":
        _background = "rain";
        break;
      case "10":
        _background = "rain";
        break;
      case "11":
        _background = "thunderstorm";
        break;
      case "13":
        _background = "snow";
        break;
      case "50":
        _background = "mist";
        break;
      default:
        _background = _background;
        break;
    }

    notifyListeners();
  }
}
