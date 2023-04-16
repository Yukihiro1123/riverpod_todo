import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/account/data/account_repository.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
part 'edit_profile_screen_controller.g.dart';

@riverpod
class EditProfileScreenController extends _$EditProfileScreenController {
  @override
  FutureOr<void> build() {}

  Future<Uint8List?> pickImage() async {
    final image = await FilePicker.platform.pickFiles(type: FileType.image);
    return image!.files.first.bytes;
  }

  Future<bool> submit({
    required String userName,
    required Uint8List? imageUrl,
    required AppUser user,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    state = const AsyncLoading().copyWithPrevious(state);
    String? imgPath = user.imageUrl;
    final repository = ref.read(accountRepositoryProvider);
    //画像あればアップロード
    if (imageUrl != null) {
      await AsyncValue.guard(
        () => repository.storeFile(id: user.userId, file: imageUrl),
      );
      imgPath = await repository.getPhotoUrl(user.userId);
    }
    print(imgPath);
    state = await AsyncValue.guard(() => repository.updateProfile(
          user: user.copyWith(
            userName: userName,
            imageUrl: imgPath ?? user.imageUrl,
          ),
        ));
    return state.hasError == false;
  }
}
