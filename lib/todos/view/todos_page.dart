import 'package:batterylevel/todos/bloc/todos_bloc.dart';
import 'package:batterylevel/todos/controller/todo_controller.dart';
import 'package:batterylevel/todos/repository/todos_repository.dart';
import 'package:batterylevel/todos/view/todo_dialog.dart';
import 'package:batterylevel/todos/view/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  void handleShowDialogAddTodo(BuildContext mainContext) {
    showDialog(
      context: mainContext,
      builder: (BuildContext context) => TodoDialog(mainContext: mainContext),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoController = Get.put(TodoController());

    return BlocProvider(
      create: (context) {
        final bloc = TodosBloc(repository: context.read<TodosRepository>());
        bloc.add(TodosFetched());
        return bloc;
      },
      child: Builder(
        builder: (mainContext) {
          return Scaffold(
            appBar: AppBar(title: const Text('Todos')),
            floatingActionButton: FloatingActionButton(
              onPressed: () => handleShowDialogAddTodo(mainContext),
              child: const Icon(Icons.add),
            ),
            body: Column(
              children: [
                TextField(
                  onChanged: (value) => todoController.textSearch.value = value,
                  decoration: const InputDecoration(hintText: "Search..."),
                  enabled: true,
                  onSubmitted: (value) => todoController.search(),
                ),
                const Expanded(child: TodoList()),
              ],
            ),
          );
        },
      ),
    );
  }
}
