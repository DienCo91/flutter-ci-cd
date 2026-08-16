import 'package:batterylevel/core/model/pagination_state.dart';
import 'package:batterylevel/core/utils/extensions/cache_for_extensions.dart';
import 'package:batterylevel/features/tutorial/data/todo_repository.dart';
import 'package:batterylevel/todos/models/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_provider.g.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepository();
});

@riverpod
class TodoNotifier extends _$TodoNotifier {
  final limit = 8;

  @override
  Future<PaginationState<Todo>> build() async {
    ref.cacheFor(const Duration(minutes: 5));
    final todos = await ref.watch(todoRepositoryProvider).fetchTodos(page: 1, limit: limit);
    return PaginationState(data: todos, page: 1, hasNextPage: todos.length == limit, isLoadingMore: false);
  }

  Future<void> onLoadMore() async {
    final currentState = state.value;

    if (currentState == null || currentState.hasNextPage == false || currentState.isLoadingMore == true) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    try {
      final todos = await ref.read(todoRepositoryProvider).fetchTodos(page: currentState.page + 1, limit: limit);
      state = AsyncValue.data(
        currentState.copyWith(
          data: [...currentState.data, ...todos],
          page: currentState.page + 1,
          hasNextPage: todos.length == limit,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      print("Error: $e");
      state = AsyncValue.data(currentState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> onDeleteTodoById({required String id}) async {
    try {
      await ref.read(todoRepositoryProvider).deleteTodoById(id: id);
      state = AsyncValue.data(state.value!.copyWith(data: state.value!.data.where((todo) => todo.id != id).toList()));
    } catch (e) {
      print("Error: $e");
    }
  }
}
