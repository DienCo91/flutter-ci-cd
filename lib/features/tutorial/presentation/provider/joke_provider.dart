import 'package:batterylevel/features/tutorial/data/joke_repository.dart';
import 'package:batterylevel/features/tutorial/domain/joke.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'joke_provider.g.dart';

final jokeRepositoryProvider = Provider<JokeRepository>((ref) {
  return JokeRepository();
});

@riverpod
Future<Joke> randomJoke(Ref ref) async {
  final repository = ref.watch(jokeRepositoryProvider);

  return repository.fetchRandomJoke();
}
