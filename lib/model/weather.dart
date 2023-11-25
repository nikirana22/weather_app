import 'package:weather_app/model/wind.dart';

class Weather {
  int id;
  String main;
  String description;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;
  Wind wind;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.pressure,
      required this.humidity,
      required this.seaLevel,
      required this.grndLevel,
      required this.wind});

// this api is giving list of weather so i'm getting only 0 index for now (using this just because of saving time )
  factory Weather.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> weatherMap = map['weather'][0];
    Map<String, dynamic> mainMap = map['main'];
    return Weather(
        id: weatherMap['id'],
        main: weatherMap['main'],
        description: weatherMap['description'],
        pressure: mainMap['pressure'],
        humidity: mainMap['humidity'],
        seaLevel: mainMap['sea_level'],
        grndLevel: mainMap['grnd_level'],
        wind: Wind.fromMap(map['wind']));
  }
}
/*
https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=fefa237cecbb48958c910953f6d2bd8b
 */
