import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:isar/isar.dart';
part 'todo_db_model.g.dart';

@collection
class TodoDbModel {
  Id id;

  @Index(type: IndexType.value)
  String title;

  @Index(type: IndexType.value)
  final DateTime? createdTime;

  @Index(type: IndexType.value)
  DateTime? modifyTime;

  DateTime dueDate;

  @enumerated
  TodoStatus status;

  TodoDbModel(
    this.id,
    this.title,
    this.createdTime,
    this.modifyTime,
    this.dueDate,
    this.status,
  );
}