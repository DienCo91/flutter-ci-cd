import 'package:batterylevel/features/tutorial/presentation/provider/family_provider.dart';
import 'package:batterylevel/features/tutorial/presentation/provider/todo_provider.dart';
import 'package:batterylevel/features/tutorial/presentation/provider/tutorial_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TutorialScreen extends ConsumerWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(tutorialProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Tutorial')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data),
            ElevatedButton(
              onPressed: () => context.push('/joke'),
              child: const Text('Go to Joke'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/counter_riverpod_screen'),
              child: const Text('Go to Counter'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/todo_riverpod_screen'),
              child: const Text('Go to Todo Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                for (final reference in ref.container.allProviders(
                  family: familyProvider,
                )) {
                  ref.invalidate(reference.provider);
                }
                ref.invalidate(todoProvider);
              },
              child: const Text('Invalidation'),
            ),
          ],
        ),
      ),
    );
  }
}
