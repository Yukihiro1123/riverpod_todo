import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/tasks/data/tasks_repository.dart';
import 'package:riverpod_todo/src/features/tasks/domain/task/task.dart';
import 'package:uuid/uuid.dart';
part 'add_task_screen_controller.g.dart';

@riverpod
class AddTaskScreenController extends _$AddTaskScreenController {
  @override
  FutureOr<void> build() {
    //
  }

  Future<bool> submit({
    required String title,
    required String description,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(tasksRepositoryProvider);
    state = await AsyncValue.guard(() => repository.addTask(
          uid: currentUser.uid,
          task: Task(
            taskId: const Uuid().v4(),
            userId: [currentUser.uid],
            title: title,
            description: description,
            createdAt: DateTime.now(),
            isDone: false,
          ),
        ));
    return state.hasError == false;
  }
}
