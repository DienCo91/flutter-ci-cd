import 'package:batterylevel/features/tutorial/presentation/provider/todo_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final todoList = ref.watch(
                    todoProvider.select((state) => state.value?.data),
                  );
                  if (todoList == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (todoList.isEmpty) {
                    return const Center(child: Text('Không có dữ liệu'));
                  }

                  return ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Todo ${todoList[index].id}'),
                        onTap: () {
                          if (todoList[index].id == null) return;
                          ref
                              .read(todoProvider.notifier)
                              .onDeleteTodoById(id: todoList[index].id ?? "");
                        },
                      );
                    },
                  );
                },
              ),
            ),

            Consumer(
              builder: (context, ref, child) {
                final isLoadingMore = ref.watch(
                  todoProvider.select(
                    (state) => state.value?.isLoadingMore ?? false,
                  ),
                );

                if (isLoadingMore) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () => ref.read(todoProvider.notifier).onLoadMore(),
                  child: const Text('Load more'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
