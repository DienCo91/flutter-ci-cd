part of 'todos_bloc.dart';

enum TodosStatus { initial, loading, success, failure }

enum TodoActionStatus { initial, loading, success, failure }

final class TodosState {
  final TodosStatus status;
  final TodoActionStatus actionStatus;
  final List<Todo> todos;
  final num page;
  final num limit;
  final bool isLoadMore;
  final String? targetTodoId;
  final String? error;

  const TodosState({
    this.status = TodosStatus.initial,
    this.actionStatus = TodoActionStatus.initial,
    this.todos = const <Todo>[],
    this.page = 0,
    this.limit = 12,
    this.isLoadMore = false,
    this.targetTodoId,
    this.error,
  });

  TodosState copyWith({
    TodosStatus? status,
    TodoActionStatus? actionStatus,
    List<Todo>? todos,
    num? page,
    num? limit,
    bool? isLoadMore,
    String? targetTodoId,
    String? error,
  }) {
    return TodosState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      todos: todos ?? this.todos,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      targetTodoId: targetTodoId ?? this.targetTodoId,
      error: error,
    );
  }
}
