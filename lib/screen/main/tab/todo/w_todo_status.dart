import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_fire.dart';
import 'package:flutter/material.dart';

import '../../../../common/data/memory/todo_data_holder.dart';
import '../../../../common/data/memory/vo_todo.dart';

class TodoStatusWidget extends StatelessWidget with TodoDataProvider{
  final Todo todo;
  TodoStatusWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: (){
        todoData.changeTodoStatus(todo);
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: switch(todo.status){
          TodoStatus.complete => Checkbox(
            value:true,
            onChanged: null,
            fillColor: WidgetStateProperty.all(context.appColors.checkBoxColor),
          ),
          TodoStatus.incomplete => Checkbox(
            value:false,
            onChanged:null,
            fillColor: WidgetStateProperty.all(context.appColors.checkBoxColor),
          ),
          TodoStatus.ongoing => const Fire(),
        }
      ),
    );
  }
}
