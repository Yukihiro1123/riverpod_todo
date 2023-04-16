import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  factory Task({
    required String taskId,
    required List<String> members,
    required String taskTitle,
    required String taskDescription,
    required DateTime createdAt,
    required int status, //1未完了2完了済み
    required String projectId,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
