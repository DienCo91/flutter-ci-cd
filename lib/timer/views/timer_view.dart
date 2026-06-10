import 'package:batterylevel/timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  @override
  void initState() {
    super.initState();
    context.read<TimerBloc>().add(TimerInitialized(second: Duration(minutes: 120).inSeconds));
  }

  void handleStart() {
    context.read<TimerBloc>().add(TimerStarted());
  }

  void handlePause() {
    context.read<TimerBloc>().add(TimerPaused());
  }

  void handleReset() {
    context.read<TimerBloc>().add(TimerReset());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      bloc: context.read<TimerBloc>(),
      buildWhen: (previous, current) => previous.secondState != current.secondState,
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Timer Page'),
                Text(state.secondState.toHHMMSS()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: handleStart, child: Text('Start')),
                    SizedBox(width: 16),
                    ElevatedButton(onPressed: handlePause, child: Text('Pause')),
                    SizedBox(width: 16),
                    ElevatedButton(onPressed: handleReset, child: Text('Reset')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension DurationFormatter on int {
  String toHHMMSS() {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;
    final seconds = this % 60;

    final hh = hours.toString().padLeft(2, '0');
    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');

    return '$hh:$mm:$ss';
  }
}
