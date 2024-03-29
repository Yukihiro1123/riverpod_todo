import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/avatar.dart';
import 'package:riverpod_todo/src/common_widgets/confirm_dialog.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/common_widgets/grid_item_builder.dart';

import 'package:riverpod_todo/src/features/account/presentation/edit_profile/edit_profile_screen.dart';
import 'package:riverpod_todo/src/features/account/presentation/my_task_list_part.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
import 'package:riverpod_todo/src/features/projects/presentation/projects/projects_screen_controller.dart';

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
      const Tab(child: Text('プロジェクト')),
    ];
    final _controller = useTabController(initialLength: tabList.length);
    final userId = ref.watch(authRepositoryProvider).currentUser!.uid;

    void _signOut() {
      ref.read(authRepositoryProvider).signOut();
    }

    void _copyToClipBoard(String userId) {
      Clipboard.setData(
        ClipboardData(
          text: userId,
        ),
      );
      Fluttertoast.showToast(msg: "クリップボードにコピーしました");
    }

    return ref.watch(getAppUserByIdProvider(userId)).when(
          data: (user) {
            return Scaffold(
              appBar: AppBar(actions: [
                IconButton(
                  onPressed: () {
                    showConfirmDialog(
                        context: context,
                        title: "ログアウト",
                        content: "ログアウトしても良いですか",
                        onConfirmed: (isConfirmed) {
                          if (isConfirmed) {
                            _signOut();
                          }
                        });
                  },
                  icon: const Icon(Icons.logout),
                )
              ]),
              body: Column(
                children: [
                  hpaddingBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      vpaddingBox,
                      Avatar(radius: 40, photoUrl: user.imageUrl),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.userName ?? "名無し"),
                          hpaddingBox,
                          Text(user.email),
                          hpaddingBox,
                          Row(
                            children: [
                              const Text("ユーザーID:"),
                              vpaddingBox,
                              Row(
                                children: [
                                  Text("${user.userId.substring(0, 16)}..."),
                                  IconButton(
                                      onPressed: () {
                                        _copyToClipBoard(user.userId);
                                      },
                                      icon: const Icon(Icons.copy))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      vpaddingBox,
                      vpaddingBox,
                      ElevatedButton(
                        onPressed: () {
                          // context.goNamed(AppRoute.editProfile.name,
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
                      physics:
                          kIsWeb ? const NeverScrollableScrollPhysics() : null,
                      children: [
                        MyTaskListPart(userId: userId, status: 1),
                        MyTaskListPart(userId: userId, status: 2),
                        Consumer(
                          builder: (context, ref, child) {
                            ref.listen<AsyncValue>(
                                projectsScreenControllerProvider, (_, state) {
                              return state.showAlertDialogOnError(context);
                            });
                            return GridItemsBuilder<Project>(
                              data: ref.watch(myProjectsStreamProvider(userId)),
                              itemBuilder: (context, model) {
                                return InkWell(
                                  onTap: () {
                                    context.goNamed(
                                      AppRoute.project.name,
                                      params: {'projectId': model.projectId},
                                    );
                                  },
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ListTile(
                                          leading: const Icon(Icons.album),
                                          title: Text(model.projectTitle),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.arrow_forward),
                                              onPressed: () {
                                                context.goNamed(
                                                  AppRoute.project.name,
                                                  params: {
                                                    'projectId': model.projectId
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
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
            return const CupertinoActivityIndicator();
          },
        );
  }
}
