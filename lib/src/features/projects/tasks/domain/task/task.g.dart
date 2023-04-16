// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      taskId: json['taskId'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      taskTitle: json['taskTitle'] as String,
      taskDescription: json['taskDescription'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as int,
      projectId: json['projectId'] as String,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'members': instance.members,
      'taskTitle': instance.taskTitle,
      'taskDescription': instance.taskDescription,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
      'projectId': instance.projectId,
    };
