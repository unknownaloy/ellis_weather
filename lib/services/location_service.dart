import 'package:geolocator/geolocator.dart';

class LocationService {
  double latitude;
  double longitude;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      if (permission == null)
        return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == null)
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getCurrentLocation() async {
    try {
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.low);

      Position position = await _determinePosition();
      print("Gotten position");
      latitude = position.latitude;
      longitude = position.longitude;

      print("LATITUDE: $latitude");
      print("LONGITUDE: $longitude");
    } catch (e) {
      print("Error from getCurrentLocation() $e");
    }
  }
}
