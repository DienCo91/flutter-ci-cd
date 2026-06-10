import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _repository;

  WeatherBloc({WeatherRepository? repository})
    : _repository = repository ?? WeatherRepository(),
      super(WeatherState.initial()) {
    on<WeatherByLocationRequested>(_fetchWeatherByName);
  }

  void _fetchWeatherByName(WeatherByLocationRequested event, Emitter<WeatherState> emit) async {
    try {
      emit(state.copyWith(status: WeatherStatus.loading));
      final weather = await _repository.getWeatherByName(name: event.name);
      emit(state.copyWith(status: WeatherStatus.success, weather: weather, name: event.name));
    } catch (e, st) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }
}
