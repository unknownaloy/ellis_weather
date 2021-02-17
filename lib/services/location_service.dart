import 'package:location/location.dart';

class LocationService {
  double latitude;
  double longitude;

  /// Using Location package
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Future getLocationData() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    return await location.getLocation();
  }

  Future getCurrentLocation() async {
    try {
      LocationData locationData = await getLocationData();
      latitude = locationData.latitude;
      longitude = locationData.longitude;
    } catch (e) {
      print("Error from getCurrentLocation() $e");
    }
  }
}
