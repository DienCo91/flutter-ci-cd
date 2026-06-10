import 'package:batterylevel/timer/bloc/timer_bloc.dart';
import 'package:batterylevel/timer/views/timer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TimerBloc(), child: TimerView());
  }
}
