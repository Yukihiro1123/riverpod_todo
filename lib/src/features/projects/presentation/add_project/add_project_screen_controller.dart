import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';

import 'package:uuid/uuid.dart';
part 'add_project_screen_controller.g.dart';

@riverpod
class AddProjectScreenController extends _$AddProjectScreenController {
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
    final repository = ref.read(projectsRepositoryProvider);
    state = await AsyncValue.guard(() => repository.addProject(
          uid: currentUser.uid,
          project: Project(
            projectId: const Uuid().v4(),
            members: [currentUser.uid],
            projectTitle: title,
            projectDescription: description,
            createdAt: DateTime.now(),
            status: 1,
          ),
        ));
    return state.hasError == false;
  }
}
