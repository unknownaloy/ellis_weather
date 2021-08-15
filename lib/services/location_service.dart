import 'package:location/location.dart';

class LocationService {
  late double latitude;
  late double longitude;

  /// Using Location package
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Future<LocationData> getLocationData() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception("Location not enabled");
        // return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // return;
        throw Exception("Locations not enabled");
      }
    }

    return await location.getLocation();
  }

  Future getCurrentLocation() async {
    try {
      LocationData locationData = await getLocationData();
      print("Print location data $locationData");
      latitude = locationData.latitude!;
      longitude = locationData.longitude!;
    } catch (e) {
      print("Error from getCurrentLocation() $e");
    }
  }
}
