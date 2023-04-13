import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:riverpod_todo/src/common_widgets/avatar.dart';

class EditProfileScreen extends HookConsumerWidget {
  final String userId;
  const EditProfileScreen({super.key, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  initialValue: "",
                  //onSaved: (value) => userName = value!,
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: 'アイコン画像の選択',
          bodyWidget: const Avatar(radius: 100),
        ),
        PageViewModel(
          title: 'プロフィール情報が更新されました',
          body: "",
        ),
      ],
      onDone: () async {
        context.pop();
      },
      next: const Text("Next"),
      showSkipButton: true,
      showNextButton: true,
      skip: const Text("スキップ"),
      done: const Text("マイページへ", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
