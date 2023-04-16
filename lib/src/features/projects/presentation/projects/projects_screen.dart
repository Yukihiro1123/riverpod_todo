import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
import 'package:riverpod_todo/src/features/projects/presentation/projects/projects_screen_controller.dart';

import 'package:riverpod_todo/src/routing/app_router.dart';
import 'package:riverpod_todo/src/utils/async_value_ui.dart';

class ProjectsScreen extends HookConsumerWidget {
  const ProjectsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(AppRoute.addProject.name);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(projectsScreenControllerProvider, (_, state) {
            return state.showAlertDialogOnError(context);
          });
          final projectsQuery = ref.watch(projectsQueryProvider);
          return FirestoreListView<Project>(
            query: projectsQuery,
            itemBuilder: (context, doc) {
              final project = doc.data();
              return ListTile(
                title: Text(project.projectTitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.goNamed(
                    AppRoute.project.name,
                    params: {'projectId': project.projectId},
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
