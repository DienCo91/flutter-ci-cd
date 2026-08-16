// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tutorial)
final tutorialProvider = TutorialProvider._();

final class TutorialProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  TutorialProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tutorialProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tutorialHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return tutorial(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$tutorialHash() => r'61378b104d4ebd08e9ae814388a2423156c45325';
