// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(randomJoke)
final randomJokeProvider = RandomJokeProvider._();

final class RandomJokeProvider
    extends $FunctionalProvider<AsyncValue<Joke>, Joke, FutureOr<Joke>>
    with $FutureModifier<Joke>, $FutureProvider<Joke> {
  RandomJokeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'randomJokeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$randomJokeHash();

  @$internal
  @override
  $FutureProviderElement<Joke> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Joke> create(Ref ref) {
    return randomJoke(ref);
  }
}

String _$randomJokeHash() => r'663771540d4099fa15375ea8b1c42ad8da5aa241';
