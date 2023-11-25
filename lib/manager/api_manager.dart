import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/manager/location_manager.dart';
import 'package:weather_app/model/weather.dart';

class ApiManager {
  static const String _apiKey = 'fefa237cecbb48958c910953f6d2bd8b';
  static const String _endPoint = 'https://api.openweathermap.org/data/2.5/';
  static final ApiManager _instance = ApiManager._();

  ApiManager._();

  factory ApiManager() => _instance;

  static void init() {
    Geolocator.getCurrentPosition();
  }

  static Future<String> get _currentWeatherEndPoint async {
    final position = await LocationManager().getCurrentLocation();
    return '${_endPoint}weather?lat=${position.latitude}&lon=${position.longitude}&appid=$_apiKey';
  }

  static Future<String> _get7DaysWeatherEndPoint([int days = 7]) async {
    final position = await LocationManager().getCurrentLocation();
    return '${_endPoint}forecast/daily?lat=${position.latitude}&lon=${position.longitude}cnt=$days&appid=$_apiKey';
  }

  static Future<Weather> getCurrentWeather() async {
    final response = await Dio().get(await _currentWeatherEndPoint);
    return Weather.fromMap(response.data);
  }

  static dynamic get7DaysWeather() async {
    final response = await Dio().get(await _get7DaysWeatherEndPoint());
    return response.data;
  }
}
/*
https://api.openweathermap.org/data/2.5/weather?lat=20.21&lon=40.22&appid=fefa237cecbb48958c910953f6d2bd8b
------------------------------
https://api.openweathermap.org/data/2.5/forecast/daily?lat=20.21&lon=40.22&cnt=7&appid=fefa237cecbb48958c910953f6d2bd8b
 */
