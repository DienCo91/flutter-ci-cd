import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  const Weather({required this.temperature2m, required this.weatherCode, required this.time, required this.interval});

  final double temperature2m;
  final double weatherCode;
  final String time;
  final double interval;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Weather copyWith({double? temperature2m, double? weatherCode, String? time, double? interval}) {
    return Weather(
      temperature2m: temperature2m ?? this.temperature2m,
      weatherCode: weatherCode ?? this.weatherCode,
      time: time ?? this.time,
      interval: interval ?? this.interval,
    );
  }
}
