import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';
import 'package:riverpod_todo/src/features/projects/tasks/presentation/tasks_screen/tasks_screen_controller.dart';

import 'package:riverpod_todo/src/routing/app_router.dart';
import 'package:riverpod_todo/src/utils/async_value_ui.dart';

class MyTaskListPart extends HookConsumerWidget {
  final String userId;
  final int status;
  const MyTaskListPart({super.key, required this.status, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(tasksScreenControllerProvider, (_, state) {
            return state.showAlertDialogOnError(context);
          });
          final myTasksQuery = ref.watch(myTasksQueryProvider(status));
          return FirestoreListView<Task>(
            query: myTasksQuery
                .where("userId", arrayContains: userId)
                .where("status", isEqualTo: status),
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
                        'projectId': task.projectId,
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
    );
  }
}
