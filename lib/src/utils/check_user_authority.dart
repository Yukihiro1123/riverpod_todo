import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';

bool isProjectFormReadOnly(WidgetRef ref, Project data) {
  final currentUser = ref.read(authRepositoryProvider).currentUser;
  if (data.members.contains(currentUser!.uid)) {
    return false;
  }
  return true;
}
