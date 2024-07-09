import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'bloc_status.dart';

part 'todo_bloc_state.freezed.dart';

@freezed
class TodoBlocState with _$TodoBlocState {
  const factory TodoBlocState(
      BlocStatus statue,
      List<Todo> todoList,
      ) = _TodoBlocState;
}