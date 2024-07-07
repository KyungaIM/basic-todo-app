import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_status.dart';
import 'package:flutter/material.dart';

import '../../../../common/data/memory/todo_data_holder.dart';
import '../../../../common/data/memory/vo_todo.dart';

class TodoItem extends StatelessWidget with TodoDataProvider{
  final Todo todo;
  TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction){
        todoData.removeTodo(todo);
      },
      key: ValueKey(todo.id),
      background: RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              EvaIcons.trash2Outline,
              color:Colors.white,
            ),
            width20
          ],
        ),
      ),
      child: RoundedContainer(
        color: context.appColors.itemBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          todo.dueDate.formattedDate.text.make(),
          Row(children: [
            TodoStatusWidget(todo:todo),
            Expanded(child: todo.title.text.size(20).medium.make()),
            IconButton(onPressed: (){
              todoData.editTodo(todo);
            }, icon: const Icon(EvaIcons.editOutline))
          ],)
        ],
      ).pOnly(top: 15, right: 15, left: 5, bottom: 10)),
    );
  }
}
