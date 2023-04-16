import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/presentation/tasks_screen/tasks_screen_controller.dart';
import 'package:riverpod_todo/src/routing/app_router.dart';
import 'package:riverpod_todo/src/utils/async_value_ui.dart';

import '../../projects/tasks/domain/task/task.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feed")),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(tasksScreenControllerProvider, (_, state) {
            return state.showAlertDialogOnError(context);
          });
          final feedQuery = ref.watch(feedTasksQueryProvider);
          return FirestoreListView<Task>(
            query: feedQuery,
            itemBuilder: (context, doc) {
              final Task task = doc.data();
              return ListTile(
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
              );
            },
          );
        },
      ),
    );
  }
}
