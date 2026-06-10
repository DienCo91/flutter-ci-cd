part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState {
  final Weather? weather;
  final WeatherStatus? status;
  final String? name;

  WeatherState({this.weather, this.status, this.name});

  factory WeatherState.initial() => WeatherState(weather: null, status: WeatherStatus.initial, name: null);

  WeatherState copyWith({Weather? weather, WeatherStatus? status, String? name}) {
    return WeatherState(weather: weather ?? this.weather, status: status ?? this.status, name: name ?? this.name);
  }
}
