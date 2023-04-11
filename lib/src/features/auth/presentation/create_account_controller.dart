import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';

import 'package:uuid/uuid.dart';

class EditAccountController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }
  Future<bool> createUser() async {
    final user = ref.watch(authRepositoryProvider).currentUser!;
    // set loading state
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.watch(authRepositoryProvider);
    AppUser appUser = AppUser(
      userId: const Uuid().v4(),
      email: user.email!,
      createdAt: DateTime.now(),
    );
    state = await AsyncValue.guard(
      () => repository.createAccont(
        user: appUser,
      ),
    );
    return state.hasError == false;
  }
}

final editAccountControllerProvider =
    AutoDisposeAsyncNotifierProvider<EditAccountController, void>(
        EditAccountController.new);
