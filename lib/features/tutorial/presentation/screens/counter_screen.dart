import 'package:batterylevel/features/tutorial/presentation/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Consumer(
        builder: (context, ref, child) {
          final count = ref.watch(counterProvider);
          return Center(
            child: Column(
              children: [
                Text(count.toString()),
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).increment(),
                  child: const Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).decrement(),
                  child: const Text('Decrement'),
                ),
                ElevatedButton(onPressed: () => ref.read(counterProvider.notifier).reset(), child: const Text('Reset')),
              ],
            ),
          );
        },
      ),
    );
  }
}
