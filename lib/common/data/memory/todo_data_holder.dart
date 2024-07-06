import 'package:fast_app_base/common/data/memory/todo_data_notifier.dart';
import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:flutter/cupertino.dart';

import '../../../screen/dialog/d_confirm.dart';
import '../../../screen/main/write/d_write_todo.dart';

class TodoDataHolder extends InheritedWidget {
  final TodoDataNotifier notifier;

  const TodoDataHolder({
    super.key,
    required super.child,
    required this.notifier,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    //이전 위젯과 동일한지 확인
    return true;
  }

  static TodoDataHolder of(BuildContext context) {
    //같은 위젯 트리 내의 어떤 곳에서도 TodoDataHolder의 값을 찾아줌
    TodoDataHolder inherited =
        (context.dependOnInheritedWidgetOfExactType<TodoDataHolder>())!;
    return inherited;
  }

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }
    notifier.notify();
  }

  void addTodo() async{
    final result = await WriteTodoDialog().show();
    if (result != null ) {
      notifier.addTodo(Todo(
        id: DateTime.now().microsecondsSinceEpoch,
        title: result.todo,
        dueDate: result.dateTime,
      ));
  }}

  void editTodo(Todo todo) async{
    final result = await WriteTodoDialog(editValue: todo).show();
    if (result != null ) {
      todo.title = result.todo;
      todo.dueDate = result.dateTime;
      notifier.notify();
      };
  }
  void removeTodo(Todo todo) {
    notifier.value.remove(todo);
    notifier.notify();
  }
}
