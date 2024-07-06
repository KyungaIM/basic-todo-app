import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:flutter/cupertino.dart';

class TodoDataNotifier extends ValueNotifier<List<Todo>>{
  TodoDataNotifier(): super([]);

  void addTodo(Todo todo){
    value.add(todo);
    // List<Todo>로 value가 설정됨,List<Todo>에 값 추가
    notifyListeners();
    //값이 수정된 것을 notifier에 알림
  }
  void notify(){
    notifyListeners();
  }
}