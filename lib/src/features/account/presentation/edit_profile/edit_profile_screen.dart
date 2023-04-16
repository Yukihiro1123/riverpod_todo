import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:riverpod_todo/src/common_widgets/avatar.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/account/presentation/edit_profile/edit_profile_screen_controller.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';

class EditProfileScreen extends HookConsumerWidget {
  final String userId;

  const EditProfileScreen({super.key, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _userName = useState<String>("");
    var _selectedProfileImage = useState<Uint8List?>(null);

    Future<void> _selectProfileImage(BuildContext context) async {
      _selectedProfileImage.value = await ref
          .read(editProfileScreenControllerProvider.notifier)
          .pickImage();
    }

    Future<void> _submit(AppUser appUser) async {
      final success =
          await ref.read(editProfileScreenControllerProvider.notifier).submit(
                userName: _userName.value,
                imageUrl: _selectedProfileImage.value,
                user: appUser,
              );
    }

    return ref.watch(getAppUserByIdProvider(userId)).when(
          data: (data) {
            if (_userName.value == "") {
              _userName.value = data.userName!;
            }

            return IntroductionScreen(
              pages: [
                PageViewModel(
                  title: "プロフィールの編集",
                  bodyWidget: Column(
                    children: [
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'ユーザー名'),
                          validator: (value) =>
                              (value ?? '').isNotEmpty ? null : '必須入力項目です',
                          initialValue: _userName.value,
                          onSaved: (value) => _userName.value = value!,
                        ),
                      ),
                    ],
                  ),
                ),
                PageViewModel(
                  title: 'アイコン画像の選択',
                  bodyWidget: GestureDetector(
                      onTap: () async {
                        await _selectProfileImage(context);
                      },
                      child: _selectedProfileImage.value != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage:
                                  MemoryImage(_selectedProfileImage.value!),
                            )
                          : Avatar(radius: 100, photoUrl: data.imageUrl)),
                ),
                PageViewModel(
                  title: 'プロフィール情報が更新されました',
                  body: "",
                ),
              ],
              onDone: () async {
                print(_userName.value);
                if (_userName.value != data.userName ||
                    _selectedProfileImage.value != null) {
                  _submit(data);
                }
                context.pop();
              },
              next: const Text("Next"),
              showSkipButton: true,
              showNextButton: true,
              skip: const Text("スキップ"),
              done: const Text("マイページへ",
                  style: TextStyle(fontWeight: FontWeight.w600)),
            );
          },
          error: (_, __) => const EmptyContent(
            title: 'Something went wrong',
            message: 'Can\'t load items right now',
          ),
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        );
  }
}
