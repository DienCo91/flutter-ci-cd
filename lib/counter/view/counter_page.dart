import 'package:batterylevel/counter/bloc/counter_bloc.dart';
import 'package:batterylevel/counter/view/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CounterBloc(), child: const CounterView());
  }
}
