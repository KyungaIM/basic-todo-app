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

  factory Todo.fromJson(Map<String,Object?> json){
    return Todo(
      id: json['id'] as int,
      title: json['title'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: TodoStatus.values.asMap()[json['statue']] ?? TodoStatus.incomplete,
      createdTime: DateTime.parse(json['createdTime'] as String),
      modifyTime: DateTime.parse(json['modifyTime'] as String),
    );
  }

  Map<String, dynamic> toJson(){
    return <String,dynamic>{
      'id': id,
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'createdTime': createdTime.toIso8601String(),
      'modifyTime':createdTime.toIso8601String(),
    };
  }

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