import 'package:geolocator/geolocator.dart';

class LocationManager {
  Position? _currentPosition;
  static final LocationManager _instance = LocationManager._();

  LocationManager._();

  factory LocationManager() => _instance;

  Future<Position> getCurrentLocation() async {
    return _currentPosition ??= await Geolocator.getCurrentPosition();
  }
}
