import 'package:batterylevel/features/tutorial/presentation/provider/joke_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JokeScreen extends StatelessWidget {
  const JokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke Generator')),
      body: SizedBox.expand(
        child: Consumer(
          builder: (context, ref, child) {
            final data = ref.watch(randomJokeProvider);

            return Stack(
              alignment: Alignment.center,
              children: [
                switch (data) {
                  AsyncValue(isLoading: true) =>
                    const CircularProgressIndicator(),
                  AsyncValue(:final value?) => SelectableText(
                    '${value.setup}\n\n${value.punchline}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                  AsyncLoading() => const CircularProgressIndicator(),
                  AsyncError() => const Text('Error'),
                },

                Positioned(
                  bottom: 20,
                  child: ElevatedButton(
                    onPressed: () => ref.invalidate(randomJokeProvider),
                    child: const Text('Get another joke'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
