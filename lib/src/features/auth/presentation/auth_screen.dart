import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/presentation/auth_providers.dart';
import 'package:riverpod_todo/src/features/auth/presentation/create_account_controller.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SignInScreen(
        providers: authProviders,
        actions: [
          AuthStateChangeAction<UserCreated>(
            (context, state) async {
              await _createUser(ref);
            },
          ),
        ],
        //会員登録いらない場合は以下をコメントアウト
        //showAuthActionSwitch: false,
        //ヘッダはタイトルの上 webでは表示されない
        headerBuilder: (context, constraints, _) {
          return const CircleAvatar(
            radius: 30,
            // images.unsplash.comの画像のパスを貼り付ける
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1658033014478-cc3b36e31a5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMDR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
          );
        },
        //サブタイトルはタイトルの下、アカウントをお持ちでない方の上
        subtitleBuilder: (context, action) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(action == AuthAction.signIn
                    ? ""
                    : "会員登録ボタンを押すと、利用規約に同意したものとみなします"),
              ),
            ],
          );
        },
        //左サイド
        sideBuilder: (context, constraints) {
          return Stack(children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/png/side_image2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Center(child: Text('sidebuilder')),
          ]);
        },
        //現時点でactionは動いていないっぽい
        // footerBuilder: (context, action) {
        //   print(action);
        //   return Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(action == AuthAction.signIn
        //         ? "Footer"
        //         : "会員登録ボタンを押すと、利用規約に同意したものとみなします"),
        //   );
        // },
      ),
    );
  }

  Future<void> _createUser(
    WidgetRef ref,
  ) async {
    await ref.read(editAccountControllerProvider.notifier).createUser();
  }
}
