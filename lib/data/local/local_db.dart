import 'package:fast_app_base/data/local/collection/todo_db_model.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


import '../../common/data/memory/vo_todo.dart';
import '../../data/local/error/local_db_error.dart';
import '../simple_result.dart';
import '../todo_repository.dart';

class LocalDB implements TodoRepository<LocalDBError>{
  static late final Isar _isar;

  LocalDB._();

  static LocalDB instance = LocalDB._();

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TodoDbModelSchema], maxSizeMiB: 512, directory: dir.path);
  }

  @override
  Future<SimpleResult<List<Todo>, LocalDBError>> getTodoList() async {
    try {
      debugPrint('get response success');
      final documents = await _isar.todoDbModels.where().findAll();
      return SimpleResult.success(documents.map((e)=> Todo.fromDB(e)).toList());
    } catch (e) {
      debugPrint('get response fail');
      return SimpleResult.failure(LocalDBError(LocalDBErrorType.unknown, '에러가 발생했습니다.'));
    }
  }

  @override
  Future<SimpleResult<void, LocalDBError>> addTodo(Todo todo) async {
    await _isar.writeTxn(() async {
      await _isar.todoDbModels.put(todo.dbModel);
    });
    return SimpleResult.success();
  }

  @override
  Future<SimpleResult<void, LocalDBError>> removeTodo(int id) async {
    await _isar.writeTxn(() async {
      await _isar.todoDbModels.delete(id);
    });
    return SimpleResult.success();
  }

  @override
  Future<SimpleResult<void, LocalDBError>> updateTodo(Todo todo) async {
    await _isar.writeTxn(() async {
      await _isar.todoDbModels.put(todo.dbModel);
    });
    return SimpleResult.success();
  }
}
