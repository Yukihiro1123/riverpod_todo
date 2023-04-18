import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';

import 'package:uuid/uuid.dart';
part 'add_task_screen_controller.g.dart';

@riverpod
class AddTaskScreenController extends _$AddTaskScreenController {
  @override
  FutureOr<void> build() {
    //
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool checkMemberBelongToProject(Project project) {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (project.members.contains(currentUser!.uid)) {
      return true;
    }
    return false;
  }

  Future<bool> submit({
    required String projectId,
    required String title,
    required String description,
    required List<String> members,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(tasksRepositoryProvider);
    state = await AsyncValue.guard(() => repository.addTask(
          projectId: projectId,
          task: Task(
            projectId: projectId,
            taskId: const Uuid().v4(),
            members: members,
            taskTitle: title,
            taskDescription: description,
            createdAt: DateTime.now(),
            status: 1,
          ),
        ));
    return state.hasError == false;
  }
}
