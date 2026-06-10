import 'package:batterylevel/todos/bloc/todos_bloc.dart';
import 'package:batterylevel/todos/view/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<TodosBloc>();

    final isLoadMore = bloc.state.isLoadMore;
    final isLoaded = bloc.state.status == TodosStatus.success;

    final nearBottom =
        _scrollController.hasClients && _scrollController.offset >= _scrollController.position.maxScrollExtent - 200;

    if (nearBottom && isLoadMore && isLoaded) {
      final nextPage = bloc.state.page + 1;
      bloc.add(TodosFetched(page: nextPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state.status == TodosStatus.success && state.todos.isEmpty) {
          return const Center(child: Text('No todos'));
        }
        return ListView.builder(
          controller: _scrollController,

          itemCount: state.todos.length + (state.status == TodosStatus.loading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= state.todos.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return TodoItem(todo: state.todos[index]);
          },
        );
      },
    );
  }
}
