import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_three/riverpod_sqfilite/todo.dart';

class TotoListView extends ConsumerWidget {
  const TotoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sqflite Todo'),
      ),
      body: const TodoView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final id = DateTime.now().millisecondsSinceEpoch;
          ref.read(todosProvider.notifier).add(
                Todo(
                  id: id,
                  description: 'Todo Item $id',
                  completed: false,
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    ); 
  }
}

class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todosProvider);

    // Riverpod 3.0ではwhenは非推奨。switch式を使用
    return switch (todosAsync) {
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final todo = value[index];
            return ListTile(
              title: Text(todo.description),
              leading: Checkbox(
                value: todo.completed,
                onChanged: (v) {
                  ref.read(todosProvider.notifier).toggle(todo.id);
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(todosProvider.notifier).remove(todo.id);
                },
              ),
            );
          },
        ),
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(child: Text('Error: $error')),
    };
  }
}
