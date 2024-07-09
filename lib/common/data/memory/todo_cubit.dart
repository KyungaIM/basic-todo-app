import 'package:fast_app_base/common/data/memory/bloc_status.dart';
import 'package:fast_app_base/common/data/memory/todo_bloc_state.dart';
import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screen/dialog/d_confirm.dart';
import '../../../screen/main/write/d_write_todo.dart';

class TodoCubit extends Cubit<TodoBlocState> {
  TodoCubit() : super(const TodoBlocState(BlocStatus.initial, <Todo>[]));

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList);
      copiedOldTodoList.add(Todo(
          id: DateTime.now().microsecondsSinceEpoch,
          title: result.todo,
          dueDate: result.dateTime,
          createdTime: DateTime.now(),
          status: TodoStatus.incomplete));
      emitNewList(copiedOldTodoList);
    }
  }

  void changeTodoStatus(Todo todo) async {
    final copiedOldTodoList = List.of(state.todoList);
    final todoIndex =
        copiedOldTodoList.indexWhere((element) => element.id == todo.id);

    TodoStatus status = todo.status;
    switch (todo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }
    copiedOldTodoList[todoIndex] = todo.copyWith(status: status);
    emitNewList(copiedOldTodoList);
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(editValue: todo).show();
    if (result != null) {

      final copiedOldTodoList = List<Todo>.from(state.todoList);
      copiedOldTodoList[copiedOldTodoList.indexOf(todo)] = todo.copyWith(
        title: result.todo,
        dueDate: result.dateTime,
      );
      emitNewList(copiedOldTodoList);
    }
  }

  void removeTodo(Todo todo) {
    final copiedOldTodoList = List<Todo>.from(state.todoList);
    copiedOldTodoList.removeWhere((element) => element.id == todo.id);
    emitNewList(copiedOldTodoList);
  }

  void emitNewList(List<Todo> copiedOldTodoList) =>
      emit(state.copyWith(todoList: copiedOldTodoList));
}
