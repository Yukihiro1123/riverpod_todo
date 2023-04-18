import 'dart:async';

import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';

part 'projects_screen_controller.g.dart';

@riverpod
class ProjectsScreenController extends _$ProjectsScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> updateProject(Project project) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final database = ref.read(projectsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => database.updateProject(project: project),
    );
  }
}
