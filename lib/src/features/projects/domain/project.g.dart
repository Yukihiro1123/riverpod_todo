// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Project _$$_ProjectFromJson(Map<String, dynamic> json) => _$_Project(
      projectId: json['projectId'] as String,
      projectTitle: json['projectTitle'] as String,
      projectDescription: json['projectDescription'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as int,
    );

Map<String, dynamic> _$$_ProjectToJson(_$_Project instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectTitle': instance.projectTitle,
      'projectDescription': instance.projectDescription,
      'members': instance.members,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
    };
