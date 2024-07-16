import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/data/local/collection/todo_db_model.dart';

class Todo {
  int id;
  String title;
  DateTime createdTime;
  DateTime? modifyTime;
  DateTime dueDate;
  TodoStatus status;

  Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    this.modifyTime,
    TodoStatus? status,
    DateTime? createdTime,
  }): createdTime = createdTime ?? DateTime.now(),status = status ?? TodoStatus.incomplete;

  factory Todo.fromDB(TodoDbModel e){
    return Todo(
      id: e.id,
      title: e.title,
      dueDate: e.dueDate,
      status: e.status,
      createdTime: e.createdTime,
      modifyTime: e.modifyTime,
    );
  }

  TodoDbModel get dbModel => TodoDbModel( id, title, createdTime, modifyTime, dueDate, status );
}