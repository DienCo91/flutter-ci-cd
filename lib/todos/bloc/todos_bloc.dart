import 'package:batterylevel/todos/models/todo.dart';
import 'package:batterylevel/todos/repository/todos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _repository;

  TodosBloc({required TodosRepository repository}) : _repository = repository, super(TodosState()) {
    on<TodosFetched>((event, emit) async {
      final page = (event.page ?? 1).toInt();
      final limit = (event.limit ?? 12).toInt();

      emit(state.copyWith(status: TodosStatus.loading, error: null, page: page, limit: limit));
      try {
        final res = await _repository.getTodos(page: page, limit: limit);
        final isLoadMore = res.length <= (event.limit ?? 12);
        emit(
          TodosState(
            todos: event.page == 1 ? res : state.todos + res,
            status: TodosStatus.success,
            page: event.page ?? 1,
            limit: event.limit ?? 12,
            isLoadMore: isLoadMore,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: TodosStatus.failure, error: e.toString(), isLoadMore: false));
      }
    });

    on<TodoDeleteById>((event, emit) async {
      final id = event.id;
      emit(state.copyWith(actionStatus: TodoActionStatus.loading, targetTodoId: id));
      try {
        await _repository.deleteTodoById(id);
        emit(
          state.copyWith(
            todos: state.todos.where((element) => element.id != id).toList(),
            actionStatus: TodoActionStatus.success,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: TodosStatus.failure, error: e.toString(), isLoadMore: false));
      } finally {
        emit(state.copyWith(actionStatus: TodoActionStatus.initial, targetTodoId: null));
      }
    });

    on<TodoCreate>((event, emit) async {
      final todo = event.todo;
      emit(state.copyWith(actionStatus: TodoActionStatus.loading));
      try {
        final res = await _repository.createTodo(todo);

        emit(state.copyWith(todos: [res, ...state.todos], actionStatus: TodoActionStatus.success));
      } catch (e) {
        emit(state.copyWith(status: TodosStatus.failure, error: e.toString()));
      } finally {
        emit(state.copyWith(actionStatus: TodoActionStatus.initial, targetTodoId: null));
      }
    });

    on<TodoUpdate>((event, emit) async {
      final todo = event.todo;
      emit(state.copyWith(actionStatus: TodoActionStatus.loading));
      try {
        final res = await _repository.updateTodo(todo);

        emit(
          state.copyWith(
            todos: state.todos.map((e) => e.id == res.id ? res : e).toList(),
            actionStatus: TodoActionStatus.success,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: TodosStatus.failure, error: e.toString()));
      } finally {
        emit(state.copyWith(actionStatus: TodoActionStatus.initial, targetTodoId: null));
      }
    });
  }
}
