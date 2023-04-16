import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';

part 'edit_task_screen_controller.g.dart';

@riverpod
class EditTaskScreenController extends _$EditTaskScreenController {
  @override
  FutureOr<void> build() {
    //
  }

  Future<bool> submit({
    required String projectId,
    required String title,
    required String description,
    required int status,
    required List<String> members,
    required Task task,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(tasksRepositoryProvider);
    state = await AsyncValue.guard(() => repository.updateTask(
          projectId: projectId,
          task: task.copyWith(
            taskTitle: title,
            taskDescription: description,
            members: members,
            status: status,
          ),
        ));
    return state.hasError == false;
  }
}
