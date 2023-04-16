import 'dart:html';

import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_todo/src/common_widgets/avatar.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';

import 'package:riverpod_todo/src/routing/app_router.dart';
import 'package:riverpod_todo/src/utils/async_value_ui.dart';
import 'package:riverpod_todo/src/utils/style.dart';

import '../../../../auth/domain/app_user.dart';
import 'tasks_screen_controller.dart';

class TasksScreen extends HookConsumerWidget {
  final String projectId;
  const TasksScreen({super.key, required this.projectId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(projectStreamProvider(projectId)).when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: Text(data.projectTitle),
                centerTitle: true,
                actions: const [],
              ),
              body: Column(
                children: [
                  hpaddingBox,
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: SingleChildScrollView(
                            child: Container(
                              child: Linkify(
                                text: data.projectDescription,
                                onOpen: (link) {
                                  window.open(link.url, "");
                                },
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              tooltip: "プロジェクトを編集",
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                context.goNamed(AppRoute.editProject.name,
                                    params: {"projectId": projectId});
                                //メンバー追加処理 projectのメンバーの箇所をアップデートする
                                //メンバーリストと検索フォーム付きdialogが出てきて、ユーザーを検索する
                                //フォームの横の追加ボタンでメンバーを追加
                              },
                            ),
                            hpaddingBox,
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Text('${data.members.length}人のメンバー'),
                                  hpaddingBox,
                                  SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.members.length,
                                      itemBuilder: (context, index) {
                                        final userNames = ref.watch(
                                            getAppUserByIdProvider(
                                                data.members[index]));
                                        return userNames.when(
                                          data: (AppUser? data) {
                                            return Tooltip(
                                              message: data!.userName,
                                              child: Avatar(
                                                  radius: 25,
                                                  photoUrl: data.imageUrl),
                                            );
                                          },
                                          error: (error, stackTrace) {
                                            print(error);
                                            return const EmptyContent();
                                          },
                                          loading: () => const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  hpaddingBox,
                  const Text('タスク一覧'),
                  hpaddingBox,
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Consumer(
                      builder: (context, ref, child) {
                        ref.listen<AsyncValue>(tasksScreenControllerProvider,
                            (_, state) {
                          return state.showAlertDialogOnError(context);
                        });
                        final tasksQuery =
                            ref.watch(tasksQueryProvider(projectId));
                        return FirestoreListView<Task>(
                          query: tasksQuery,
                          itemBuilder: (context, doc) {
                            final task = doc.data();
                            return Dismissible(
                              key: Key('task-${task.taskId}'),
                              child: ListTile(
                                title: Text(task.taskTitle),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  context.goNamed(
                                    AppRoute.editTask.name,
                                    params: {
                                      'projectId': projectId,
                                      'taskId': task.taskId
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  child: const Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    context.goNamed(AppRoute.addTask.name,
                        params: {"projectId": projectId});
                  }),
            );
          },
          error: (error, stackTrace) {
            print(error);
            return const EmptyContent();
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
