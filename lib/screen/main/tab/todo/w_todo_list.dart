import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/cupertino.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TodoDataHolder.of(context).notifier,
      builder: (context,todoList,child){
        return todoList.isEmpty ? '할 일을 작성해 보세요'.text.size(30).makeCentered():
            Column(children: todoList.map((e)=> TodoItem(todo: e)).toList(),);
      },);
  }
}
