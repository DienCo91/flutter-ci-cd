import 'package:batterylevel/todos/bloc/todos_bloc.dart';
import 'package:batterylevel/todos/models/todo.dart';
import 'package:batterylevel/todos/view/todo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    void handleEditTodo(BuildContext context) {
      showDialog(
        context: context,
        builder: (contextDialog) => TodoDialog(mainContext: context, todo: todo),
      );
    }

    return Dismissible(
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final bool? res = await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return BlocListener<TodosBloc, TodosState>(
              bloc: context.read<TodosBloc>(),
              listenWhen: (previous, current) {
                return previous.actionStatus == TodoActionStatus.loading &&
                    (current.actionStatus == TodoActionStatus.success ||
                        current.actionStatus == TodoActionStatus.failure);
              },
              listener: (context, state) {
                return Navigator.of(dialogContext).pop(true);
              },
              child: BlocBuilder<TodosBloc, TodosState>(
                bloc: context.read<TodosBloc>(),
                buildWhen: (previous, current) => previous.actionStatus != current.actionStatus,
                builder: (dialogContextBuilder, state) {
                  final loading = state.actionStatus == TodoActionStatus.loading && state.targetTodoId == todo.id;

                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text('Xác nhận xóa?'),
                    content: Text('Bạn có chắc chắn muốn xóa công việc có ID: ${todo.id} không?'),
                    actions: [
                      TextButton(
                        onPressed: loading ? null : () => Navigator.of(dialogContext).pop(false),
                        child: const Text('Hủy', style: TextStyle(color: Colors.black54)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: loading ? null : () => context.read<TodosBloc>().add(TodoDeleteById(id: todo.id)),
                        child: loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Text('Xóa'),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );

        return res ?? false;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {},
            title: Text(todo.title ?? ""),
            subtitle: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${todo.id}'),
                    Text('Completed: ${todo.isComplete}'),
                    Text(
                      'Created At: ${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(todo.createdAt!).toLocal())}',
                    ),
                  ],
                ),
                const Spacer(),
                BlocBuilder<TodosBloc, TodosState>(
                  bloc: context.read<TodosBloc>(),
                  builder: (context, state) {
                    return ElevatedButton.icon(
                      onPressed: () => handleEditTodo(context),
                      label: Text('Edit'),
                      icon: Icon(Icons.edit_outlined),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Divider(height: 1)),
        ],
      ),
    );
  }
}
