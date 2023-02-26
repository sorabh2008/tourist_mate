import 'package:geolocator/geolocator.dart';

class LocationService {
  String? _currentAddress;
  Position? _currentPosition;

  static Future<bool> isLocationEnabled() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<Position> getCurrentPosition() async {
    final hasPermission = await LocationService.isLocationEnabled();

    if (!hasPermission) {
      _currentPosition = Position(longitude: 0, latitude: 0, timestamp: new DateTime(0), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0);
    } else {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _currentPosition = position;
      }).catchError((e) {
        // print error
      });
    }
    return Future.value(_currentPosition);
  }

}