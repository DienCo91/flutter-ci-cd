// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FamilyNotifier)
final familyProvider = FamilyNotifierFamily._();

final class FamilyNotifierProvider
    extends $AsyncNotifierProvider<FamilyNotifier, String> {
  FamilyNotifierProvider._({
    required FamilyNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'familyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$familyNotifierHash();

  @override
  String toString() {
    return r'familyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FamilyNotifier create() => FamilyNotifier();

  @override
  bool operator ==(Object other) {
    return other is FamilyNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$familyNotifierHash() => r'8ac70591bede98999d52f1c1fe69fd1f69e7ec60';

final class FamilyNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FamilyNotifier,
          AsyncValue<String>,
          String,
          FutureOr<String>,
          String
        > {
  FamilyNotifierFamily._()
    : super(
        retry: null,
        name: r'familyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FamilyNotifierProvider call(String id) =>
      FamilyNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'familyProvider';
}

abstract class _$FamilyNotifier extends $AsyncNotifier<String> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<String> build(String id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
