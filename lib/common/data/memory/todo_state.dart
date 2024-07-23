import 'package:fast_app_base/common/data/memory/vo_todo.dart';

class TodoState {
  final bool loading;
  final List<Todo> todos;

  TodoState({required this.loading, required this.todos});
}

// Stat