// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodoNotifier)
final todoProvider = TodoNotifierProvider._();

final class TodoNotifierProvider
    extends $AsyncNotifierProvider<TodoNotifier, PaginationState<Todo>> {
  TodoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoNotifierHash();

  @$internal
  @override
  TodoNotifier create() => TodoNotifier();
}

String _$todoNotifierHash() => r'9dabc18b751f418eb337c65911a85e3002ba0188';

abstract class _$TodoNotifier extends $AsyncNotifier<PaginationState<Todo>> {
  FutureOr<PaginationState<Todo>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<PaginationState<Todo>>, PaginationState<Todo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginationState<Todo>>,
                PaginationState<Todo>
              >,
              AsyncValue<PaginationState<Todo>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
