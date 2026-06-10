import 'package:batterylevel/weather/bloc/weather_bloc.dart';
import 'package:batterylevel/weather/view/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = WeatherBloc(repository: context.read<WeatherRepository>());
        bloc.add(WeatherByLocationRequested(name: 'Ha Noi'));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Weather')),
        body: const WeatherView(),
      ),
    );
  }
}
