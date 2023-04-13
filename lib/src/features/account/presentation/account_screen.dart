import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/avatar.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/account/presentation/edit_profile_screen.dart';
import 'package:riverpod_todo/src/features/account/presentation/my_task_list_part.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';

import 'package:riverpod_todo/src/routing/app_router.dart';
import 'package:riverpod_todo/src/utils/async_value_ui.dart';
import 'package:riverpod_todo/src/utils/style.dart';

class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> tabList = [
      const Tab(child: Text('未完了タスク')),
      const Tab(child: Text('完了済タスク')),
      const Tab(child: Text('グループ')),
    ];
    final _controller = useTabController(initialLength: tabList.length);
    return ref.watch(getAppUserByIdProvider).when(
          data: (user) {
            return Scaffold(
              appBar: AppBar(actions: [
                IconButton(
                  onPressed: () {
                    ref.read(authRepositoryProvider).signOut();
                  },
                  icon: const Icon(Icons.settings),
                )
              ]),
              body: Column(
                children: [
                  hpaddingBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      vpaddingBox,
                      Avatar(radius: 40, photoUrl: user!.imageUrl),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.userName ?? "アカウント"),
                          Text(user.email),
                        ],
                      ),
                      vpaddingBox,
                      vpaddingBox,
                      ElevatedButton(
                        onPressed: () {
                          // context.pushNamed(AppRoute.editProfile.name,
                          //     params: {"id": user.userId});
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: editProfileDialogShape,
                                  backgroundColor: Colors.grey[200],
                                  content: SizedBox(
                                    width: 600,
                                    height: 600,
                                    child:
                                        EditProfileScreen(userId: user.userId),
                                  ),
                                );
                              });
                        },
                        child: const Text('プロフィールを編集'),
                      ),
                    ],
                  ),
                  hpaddingBox,
                  hpaddingBox,
                  TabBar(
                    controller: _controller,
                    tabs: tabList,
                    labelColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    /// タブの中身を表示するWidget
                    child: TabBarView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),

                      /// タブに表示したいWidgetをchildrenに記載する
                      children: const [
                        MyTaskListPart(status: 1),
                        MyTaskListPart(status: 2),
                        Center(child: Text('Groups')),
                      ],
                    ),
                  ),
                ],
              ),
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
