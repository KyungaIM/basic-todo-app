import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/memory/todo_bloc_state.dart';
import 'package:fast_app_base/common/data/memory/todo_cubit.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit,TodoBlocState>(builder: (context,state) =>
    state.todoList.isEmpty ? '할 일을 작성해 보세요'.text.size(30).makeCentered() :
    Column(children: state.todoList.map((e) => TodoItem(todo: e)).toList(),));
}
}
