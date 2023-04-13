import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  factory AppUser({
    required String userId,
    required String email,
    required DateTime createdAt,
    String? userName,
    //プロフィール画像
    String? imageUrl,
    //所属しているグループ
    @Default([]) List<String>? gruops,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
