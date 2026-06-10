import 'package:batterylevel/counter/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    void handleIncrement() {
      context.read<CounterBloc>().add(CounterIncremented());
    }

    void handleDecrement() {
      context.read<CounterBloc>().add(CounterDecremented());
    }

    void handleReset() {
      context.read<CounterBloc>().add(CounterReset());
    }

    return Scaffold(
      body: BlocBuilder<CounterBloc, CounterState>(
        buildWhen: (previous, current) => previous.count != current.count,
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Counter Page'),
                Text('Counter Value: ${state.count}'),
                ElevatedButton(onPressed: handleIncrement, child: Text('Increment')),
                ElevatedButton(onPressed: handleDecrement, child: Text('Decrement')),
                ElevatedButton(onPressed: handleReset, child: Text('Reset')),
              ],
            ),
          );
        },
      ),
    );
  }
}
