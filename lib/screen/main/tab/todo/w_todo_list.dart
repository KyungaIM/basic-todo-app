import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/utils.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListNotifier = ref.watch(todoDataProvider);
    return todoListNotifier.loading
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading...'),
            ],
          )
        : todoListNotifier.todos.isEmpty
            ? '할 일을 작성해 보세요'.text.size(30).makeCentered()
            : Column(
                children: todoListNotifier.todos
                    .map((e) => TodoItem(todo: e).marginOnly(bottom: 10))
                    .toList(),
              );
  }
}
