class Weather {
  final String city;
  final DateTime date;
  final String day;
  final String time;
  final int tempMax;
  final int tempMin;
  final int windSpeed;
  final int humidity;
  final String weatherDescription;
  final String weatherIcon;

  Weather({
    required this.city,
    required this.date,
    required this.day,
    required this.time,
    required this.tempMax,
    required this.tempMin,
    required this.windSpeed,
    required this.humidity,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['city'],
      date: DateTime.parse(json['date']),
      day: json['day'],
      time:json['time'],
      tempMax: json['tempMax'],
      tempMin: json['tempMin'],
      windSpeed: json['windSpeed'],
      humidity: json['humidity'],
      weatherDescription: json['weatherDescription'],
      weatherIcon: json['weatherIcon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'date': date.toIso8601String(),
      'day': day,
      'time': time,
      'tempMax': tempMax,
      'tempMin': tempMin,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
    };
  }
}
