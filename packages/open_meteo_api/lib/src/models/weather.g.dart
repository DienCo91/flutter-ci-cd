// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Weather',
  json,
  ($checkedConvert) {
    final val = Weather(
      temperature2m: $checkedConvert(
        'temperature_2m',
        (v) => (v as num).toDouble(),
      ),
      weatherCode: $checkedConvert(
        'weather_code',
        (v) => (v as num).toDouble(),
      ),
      time: $checkedConvert('time', (v) => v as String),
      interval: $checkedConvert('interval', (v) => (v as num).toDouble()),
    );
    return val;
  },
  fieldKeyMap: const {
    'temperature2m': 'temperature_2m',
    'weatherCode': 'weather_code',
  },
);

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
  'temperature_2m': instance.temperature2m,
  'weather_code': instance.weatherCode,
  'time': instance.time,
  'interval': instance.interval,
};
