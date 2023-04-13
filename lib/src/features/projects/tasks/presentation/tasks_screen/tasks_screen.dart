import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/common_widgets/empty_content.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';

import 'package:riverpod_todo/src/routing/app_router.dart';
import 'package:riverpod_todo/src/utils/async_value_ui.dart';

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
                  Text(data.projectDescription),
                  Text('タスク一覧'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
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
                            print(task);
                            return Dismissible(
                              key: Key('task-${task.taskId}'),
                              child: ListTile(
                                title: Text(task.taskTitle),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  context.pushNamed(
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
