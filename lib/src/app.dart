import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/routing/app_router.dart';

import 'package:riverpod_todo/src/utils/style.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        unselectedWidgetColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 2.0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[200],
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ja'),
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
    );
  }
}

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();
  @override
  String get registerHintText => 'アカウントをお持ちでない方はこちら';
  @override
  String get signInHintText => 'アカウントをお持ちのかたはこちら';
  @override
  String get signInText => 'ログイン';
  @override
  String get emailInputLabel => 'メールアドレス';
  @override
  String get passwordInputLabel => 'パスワード';
  @override
  String get confirmPasswordInputLabel => 'パスワード（確認用）';
  @override
  String get signInActionText => 'ログイン';
  @override
  String get registerText => '会員登録';
  @override
  String get registerActionText => '会員登録';
  @override
  String get forgotPasswordButtonLabel => 'パスワードを忘れた方はこちら';
  @override
  String get forgotPasswordViewTitle => 'パスワード再設定';
  @override
  String get forgotPasswordHintText =>
      'こちらのフォームにメールアドレスをご入力頂くと、パスワード再設定メールが送信されます';
  @override
  String get resetPasswordButtonLabel => 'パスワード再設定';
  @override
  String get goBackButtonLabel => '戻る';

  @override
  String get emailIsRequiredErrorText => 'メールアドレスを入力してください';
  @override
  String get passwordIsRequiredErrorText => 'パスワードを入力してください';
  @override
  String get isNotAValidEmailErrorText => '無効なメールアドレスです';
  @override
  String get userNotFoundErrorText => 'ユーザーが見つかりません';
  @override
  String get emailTakenErrorText => 'すでに利用されているメールアドレスです';
  @override
  String get accessDisabledErrorText => 'こちらのメールアドレスは現在ご利用いただけません';
  @override
  String get wrongOrNoPasswordErrorText => 'メールアドレスもしくはパスワードが間違っています';
  @override
  String get passwordResetEmailSentText => 'パスワード再設定メールを送信いたしました';
}
