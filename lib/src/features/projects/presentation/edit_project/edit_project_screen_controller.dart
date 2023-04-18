import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';

part 'edit_project_screen_controller.g.dart';

@riverpod
class EditProjectScreenController extends _$EditProjectScreenController {
  @override
  FutureOr<void> build() {}

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<bool> submit({
    required String title,
    required String description,
    required Project project,
    required List<String> members,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(projectsRepositoryProvider);
    state = await AsyncValue.guard(() => repository.updateProject(
          project: project.copyWith(
            projectTitle: title,
            projectDescription: description,
            members: members,
          ),
        ));
    return state.hasError == false;
  }

  Future<bool> delete({required String projectId}) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(projectsRepositoryProvider);
    state = await AsyncValue.guard(
        () => repository.deleteProject(projectId: projectId));
    return state.hasError == false;
  }

  bool isProjectFormReadOnly(Project project) {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (project.members.contains(currentUser!.uid)) {
      return false;
    }
    return true;
  }
}
