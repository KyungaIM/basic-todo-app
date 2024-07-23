import 'package:fast_app_base/common/data/memory/todo_state.dart';
import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:fast_app_base/data/network/todo_api.dart';
import 'package:fast_app_base/screen/dialog/d_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../screen/dialog/d_confirm.dart';
import '../../../screen/main/write/d_write_todo.dart';

final todoDataProvider = StateNotifierProvider<TodoDataHolder, TodoState>((ref){
  return TodoDataHolder(TodoApi.instance);
});

class TodoDataHolder extends StateNotifier<TodoState> {
  final TodoApi todoRepository;
  late final bool loading;

  TodoDataHolder(this.todoRepository) : super(TodoState(loading: true, todos: [])) {
    _init();
  }

  Future<void> _init() async {
    try {
      final requestResult = await todoRepository.getTodoList();
      requestResult.runIfSuccess((data) {
        state = TodoState(loading: false, todos: data);
      });
      requestResult.runIfFailure((error) {
        state = TodoState(loading: false, todos: []);
        MessageDialog(error.message).show();
      });
    } catch (e) {
      state = TodoState(loading: false, todos: []);
      MessageDialog(e.toString()).show();
    }
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      Todo todo = Todo(
          id: DateTime
              .now()
              .microsecondsSinceEpoch,
          title: result.todo,
          dueDate: result.dateTime,
          status: TodoStatus.incomplete);
      final requestResult = await todoRepository.addTodo(todo);
      requestResult.runIfSuccess((data) {
        final updateTodos = List<Todo>.from(state.todos)..add(todo);
        state = TodoState(loading: false, todos: updateTodos);
      });
      requestResult.runIfFailure((error) => MessageDialog(error.message).show());
    }}

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
        break;
      }
          final requestResult = await todoRepository.updateTodo(todo);
          requestResult.runIfSuccess((data) {
            final updatedTodos = state.todos.map((t) => t.id == todo.id ? todo : t).toList();
            state = TodoState(loading: false, todos: updatedTodos);
          });
          requestResult.runIfFailure((error) => MessageDialog(error.message).show());
    }

    void editTodo(Todo todo) async {
      final result = await WriteTodoDialog(editValue: todo).show();
      if (result != null) {
        todo.title = result.todo;
        todo.dueDate = result.dateTime;

        final requestResult = await todoRepository.updateTodo(todo);
        requestResult.runIfSuccess((data) {
          final updatedTodos = state.todos.map((t) => t.id == todo.id ? todo : t).toList();
          state = TodoState(loading: false, todos: updatedTodos);
        });
        requestResult.runIfFailure((error) => MessageDialog(error.message).show());
      }
    }

    void removeTodo(Todo todo) async {
      final requestResult = await todoRepository.removeTodo(todo.id);
      requestResult.runIfSuccess((data) {
        final updatedTodos = List<Todo>.from(state.todos)..remove(todo);
        state = TodoState(loading: false, todos: updatedTodos);
      });
      requestResult.runIfFailure((error) => MessageDialog(error.message).show());
    }
  }

  extension TodoListHolderProvider

  on WidgetRef

  {

  TodoDataHolder get readTodoHolder => read(todoDataProvider.notifier);
}
