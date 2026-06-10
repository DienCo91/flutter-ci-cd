import 'package:open_meteo_api/open_meteo_api.dart';

enum WeatherCondition { clear, rain, clouds, snow, wind, unknown }

class WeatherRepository {
  WeatherRepository({OpenMeteoApiClient? openMeteoApiClient})
    : _openMeteoApiClient = openMeteoApiClient ?? OpenMeteoApiClient();

  final OpenMeteoApiClient _openMeteoApiClient;

  Future<Weather> getWeatherByName({required String name}) async {
    final location = await _openMeteoApiClient.searchByLocationName(name);
    final weather = await _openMeteoApiClient.getWeather(latitude: location.latitude, longitude: location.longitude);
    return weather;
  }
}

extension WeatherConditionExtension on double {
  WeatherCondition toWeatherCondition() {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return WeatherCondition.clouds;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherCondition.rain;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snow;
      default:
        return WeatherCondition.unknown;
    }
  }
}
