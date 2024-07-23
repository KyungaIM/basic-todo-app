import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:fast_app_base/data/network/result/api_error.dart';
import 'package:fast_app_base/data/simple_result.dart';
import 'package:fast_app_base/data/todo_repository.dart';

class TodoApi implements TodoRepository<ApiError> {

  //플랫폼에 따라 서버 변환 가능 (안드로이드의 경우 localhost를 tcp/ip로 재설정 필요)
  final client = Dio(BaseOptions(baseUrl: Platform.isAndroid
      ? 'http://10.0.2.2:8080/'
      : 'http://localhost:8080/'));

  TodoApi._();

  static TodoApi instance = TodoApi._();

  @override
  Future<SimpleResult<void, ApiError>> addTodo(Todo todo) {
    return tryRequest(() async {
      await client.post('todos', data: todo.toJson());
      return SimpleResult.success();
    });
  }

  @override
  Future<SimpleResult<List<Todo>, ApiError>> getTodoList() {
    return tryRequest(() async {
      final todoList = await client.get<List>('todos');
      return SimpleResult.success(
          todoList.data?.map((e) => Todo.fromJson(e)).toList());
    });
  }

  @override
  Future<SimpleResult<void, ApiError>> removeTodo(int id) {
    return tryRequest(() async {
      await client.delete('todos/$id');
      return SimpleResult.success();
    });
  }

  @override
  Future<SimpleResult<void, ApiError>> updateTodo(Todo todo) {
    return tryRequest(() async {
      await client.put('todos/${todo.id}', data: todo.toJson());
      return SimpleResult.success();
    });
  }

  Future<SimpleResult<T, ApiError>> tryRequest<T>(
      Future<SimpleResult<T, ApiError>> Function() apiLogic) async {
    try {
      return await apiLogic();
    } catch (e) {
      return ApiError.createErrorResult(e);
    }
  }
}