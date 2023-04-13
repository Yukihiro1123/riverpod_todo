// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError; //プロフィール画像
  String? get imageUrl => throw _privateConstructorUsedError; //所属しているグループ
  List<String>? get gruops => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String userId,
      String email,
      DateTime createdAt,
      String? userName,
      String? imageUrl,
      List<String>? gruops});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? createdAt = null,
    Object? userName = freezed,
    Object? imageUrl = freezed,
    Object? gruops = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gruops: freezed == gruops
          ? _value.gruops
          : gruops // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$_AppUserCopyWith(
          _$_AppUser value, $Res Function(_$_AppUser) then) =
      __$$_AppUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String email,
      DateTime createdAt,
      String? userName,
      String? imageUrl,
      List<String>? gruops});
}

/// @nodoc
class __$$_AppUserCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$_AppUser>
    implements _$$_AppUserCopyWith<$Res> {
  __$$_AppUserCopyWithImpl(_$_AppUser _value, $Res Function(_$_AppUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? createdAt = null,
    Object? userName = freezed,
    Object? imageUrl = freezed,
    Object? gruops = freezed,
  }) {
    return _then(_$_AppUser(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gruops: freezed == gruops
          ? _value._gruops
          : gruops // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser implements _AppUser {
  _$_AppUser(
      {required this.userId,
      required this.email,
      required this.createdAt,
      this.userName,
      this.imageUrl,
      final List<String>? gruops = const []})
      : _gruops = gruops;

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

  @override
  final String userId;
  @override
  final String email;
  @override
  final DateTime createdAt;
  @override
  final String? userName;
//プロフィール画像
  @override
  final String? imageUrl;
//所属しているグループ
  final List<String>? _gruops;
//所属しているグループ
  @override
  @JsonKey()
  List<String>? get gruops {
    final value = _gruops;
    if (value == null) return null;
    if (_gruops is EqualUnmodifiableListView) return _gruops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AppUser(userId: $userId, email: $email, createdAt: $createdAt, userName: $userName, imageUrl: $imageUrl, gruops: $gruops)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._gruops, _gruops));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, email, createdAt,
      userName, imageUrl, const DeepCollectionEquality().hash(_gruops));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      __$$_AppUserCopyWithImpl<_$_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUserToJson(
      this,
    );
  }
}

abstract class _AppUser implements AppUser {
  factory _AppUser(
      {required final String userId,
      required final String email,
      required final DateTime createdAt,
      final String? userName,
      final String? imageUrl,
      final List<String>? gruops}) = _$_AppUser;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override
  String get userId;
  @override
  String get email;
  @override
  DateTime get createdAt;
  @override
  String? get userName;
  @override //プロフィール画像
  String? get imageUrl;
  @override //所属しているグループ
  List<String>? get gruops;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
