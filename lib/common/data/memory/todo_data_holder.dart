import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../screen/dialog/d_confirm.dart';
import '../../../screen/main/write/d_write_todo.dart';

final userProvider = FutureProvider<String>((ref) => 'abc');
final todoDataProvider = StateNotifierProvider<TodoDataHolder, List<Todo>>((ref){
  final userID = ref.watch(userProvider);
  debugPrint(userID.value); //userId가 존재할 때에만 TodoDataHolder 실행
  return TodoDataHolder();
});

class TodoDataHolder extends StateNotifier<List<Todo>> {
  TodoDataHolder():super([]);

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      state.add(Todo(
          id: DateTime.now().microsecondsSinceEpoch,
          title: result.todo,
          dueDate: result.dateTime,
          status: TodoStatus.incomplete));
    }
      state = List.of(state);
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
    state = List.of(state);
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(editValue: todo).show();
    if (result != null) {
      todo.title = result.todo;
      todo.dueDate = result.dateTime;
      state = List.of(state);
    }
  }

  void removeTodo(Todo todo) {
    state.remove(todo);
    state = List.of(state);
  }
}

extension TodoListHolderProvider on WidgetRef {
  TodoDataHolder get readTodoHolder => read(todoDataProvider.notifier);
}
