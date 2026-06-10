import 'package:batterylevel/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    void onSearch(String? value) {
      context.read<WeatherBloc>().add(WeatherByLocationRequested(name: value ?? 'Ha Noi'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: context.read<WeatherBloc>(),
        builder: (context, state) {
          if (state.status == WeatherStatus.failure) {
            return const Center(child: Text('Failed to fetch weather'));
          }
          if (state.status == WeatherStatus.loading || state.status == WeatherStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Weather in ${state.name}'),
              Text('Temperature: ${state.weather?.temperature2m ?? 0}°C'),
              Text('Weather Condition: ${state.weather?.weatherCode.toWeatherCondition().name ?? 0}'),
              Text('Time: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.weather?.time ?? ''))}'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: onSearch,
                      decoration: InputDecoration(labelText: 'Search by location'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
