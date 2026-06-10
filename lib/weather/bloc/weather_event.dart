part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class WeatherByLocationRequested extends WeatherEvent {
  WeatherByLocationRequested({required this.name});

  final String name;
}
