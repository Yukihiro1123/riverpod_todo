import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';

bool isProjectFormReadOnly(WidgetRef ref, Project data) {
  final currentUser = ref.read(authRepositoryProvider).currentUser;
  if (data.members.contains(currentUser!.uid)) {
    return false;
  }
  return true;
}

Future<bool> isTaskFormReadOnly(WidgetRef ref, Task data) async {
  final currentUser = ref.read(authRepositoryProvider).currentUser;
  final Project project = await ref
      .read(projectsRepositoryProvider)
      .fetchProject(projectId: data.projectId);
  if (project.members.contains(currentUser!.uid)) {
    return false;
  }
  return true;
}
