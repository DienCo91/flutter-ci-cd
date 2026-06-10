part of 'todos_bloc.dart';

sealed class TodosEvent {}

class TodosFetched extends TodosEvent {
  final num? page;
  final num? limit;
  TodosFetched({this.page, this.limit});
}

class TodoDeleteById extends TodosEvent {
  final String? id;
  TodoDeleteById({this.id});
}

class TodoCreate extends TodosEvent {
  final Todo todo;
  TodoCreate({required this.todo});
}

class TodoUpdate extends TodosEvent {
  final Todo todo;
  TodoUpdate({required this.todo});
}
