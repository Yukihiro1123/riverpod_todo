// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      userId: json['userId'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userName: json['userName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      gruops: (json['gruops'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
      'userName': instance.userName,
      'imageUrl': instance.imageUrl,
      'gruops': instance.gruops,
    };
