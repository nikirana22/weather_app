class Wind {
  double speed;
  int deg;
  double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  Wind.fromMap(Map<String, dynamic> map)
      : speed = map['speed'],
        deg = map['deg'],
        gust = map['gust'];
}
