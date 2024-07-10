import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoDataProvider);
    return todoList.isEmpty ? '할 일을 작성해 보세요'.text.size(30).makeCentered() :
    Column(children: todoList.map((e) => TodoItem(todo: e)).toList(),);
}
}
