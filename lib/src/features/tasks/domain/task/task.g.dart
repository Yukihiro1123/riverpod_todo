// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      taskId: json['taskId'] as String,
      userId:
          (json['userId'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'isDone': instance.isDone,
      'createdAt': instance.createdAt.toIso8601String(),
    };
