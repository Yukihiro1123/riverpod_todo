import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  factory Task({
    required String taskId,
    required List<String> userId,
    required String title,
    required String description,
    required DateTime createdAt,
    required int status, //1未完了2完了済み
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
