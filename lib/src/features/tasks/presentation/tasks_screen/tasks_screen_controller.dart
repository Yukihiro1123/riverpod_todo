import 'dart:async';

import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/tasks/data/tasks_repository.dart';

import 'package:riverpod_todo/src/features/tasks/domain/task/task.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_screen_controller.g.dart';

@riverpod
class TasksScreenController extends _$TasksScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> updateTask(Task task) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final database = ref.read(tasksRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => database.updateTask(uid: currentUser.uid, task: task),
    );
  }

  Future<void> deleteTask(Task task) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    //firestore repository呼び出し
    final database = ref.read(tasksRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => database.deleteTask(uid: currentUser.uid, taskId: task.taskId),
    );
  }
}
