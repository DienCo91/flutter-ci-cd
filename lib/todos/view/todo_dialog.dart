import 'package:batterylevel/todos/bloc/todos_bloc.dart';
import 'package:batterylevel/todos/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoDialog extends StatefulWidget {
  final BuildContext mainContext;
  final Todo? todo;
  const TodoDialog({super.key, required this.mainContext, this.todo});

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  late TextEditingController controller;
  bool isChecked = false;

  @override
  void initState() {
    controller = TextEditingController(text: widget.todo?.title ?? "");
    setState(() {
      isChecked = widget.todo?.isComplete ?? false;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (widget.todo != null) {
      final newTodo = widget.todo!.copyWith(title: controller.text, isComplete: isChecked);

      widget.mainContext.read<TodosBloc>().add(TodoUpdate(todo: newTodo));
    } else {
      widget.mainContext.read<TodosBloc>().add(
        TodoCreate(
          todo: Todo(
            title: controller.text,
            isComplete: isChecked,
            createdAt: DateTime.now().toUtc().toIso8601String(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosBloc, TodosState>(
      bloc: widget.mainContext.read<TodosBloc>(),
      listenWhen: (previous, current) {
        return previous.actionStatus == TodoActionStatus.loading &&
            (current.actionStatus == TodoActionStatus.success || current.actionStatus == TodoActionStatus.failure);
      },
      listener: (context, state) {
        Navigator.of(context).pop();
        if (state.actionStatus == TodoActionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? "")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(duration: Duration(milliseconds: 500), content: Text("Success"), backgroundColor: Colors.green),
          );
        }
      },
      child: BlocBuilder<TodosBloc, TodosState>(
        bloc: widget.mainContext.read<TodosBloc>(),
        builder: (context, state) {
          final isLoading = state.actionStatus == TodoActionStatus.loading;

          return AlertDialog(
            title: Text(widget.todo != null ? "Edit todo" : 'Add todo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: controller, autofocus: true, onSubmitted: (value) {}),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => setState(() {
                    isChecked = !isChecked;
                  }),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: isChecked,
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Completed'),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onSubmit,
                    child: Text(widget.todo != null ? "Edit todo" : 'Add todo'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
