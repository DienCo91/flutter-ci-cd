import 'package:dio/dio.dart';
import 'package:open_meteo_api/src/models/models.dart';

class LocationRequestFailedException implements Exception {
  final String message;

  LocationRequestFailedException(this.message);

  @override
  String toString() => message;
}

class WeatherRequestFailedException implements Exception {
  final String message;

  WeatherRequestFailedException(this.message);

  @override
  String toString() => message;
}

class OpenMeteoApiClient {
  OpenMeteoApiClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  final String _baseUrlGeocoding = "https://geocoding-api.open-meteo.com/v1/search";
  final String _baseUrlForecast = "https://api.open-meteo.com/v1/forecast";

  Future<Location> searchByLocationName(String locationName) async {
    final res = await _dio.get(_baseUrlGeocoding, queryParameters: {'name': locationName.trim(), 'count': 1});
    if (res.statusCode == 200) {
      final data = res.data;
      final results = data['results'] as List<dynamic>;
      return results.map((e) => Location.fromJson(e)).toList().first;
    } else {
      throw LocationRequestFailedException('Failed to search location');
    }
  }

  Future<Weather> getWeather({required double latitude, required double longitude}) async {
    final res = await _dio.get(
      _baseUrlForecast,
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'current': 'temperature_2m,weather_code',
        'timezone': 'Asia/Bangkok',
        'forecast_days': 1,
      },
    );
    if (res.statusCode == 200) {
      final data = res.data;
      final currentWeather = data['current'] as Map<String, dynamic>;
      return Weather.fromJson(currentWeather);
    } else {
      throw WeatherRequestFailedException('Failed to get weather');
    }
  }

  void close() {
    _dio.close();
  }
}
