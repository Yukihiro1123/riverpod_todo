import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';

import 'package:riverpod_todo/src/utils/firestore_data_source.dart';

class FirestorePath {
  static String users(String uid) => 'users/$uid';
}

class FirestoreRepository {
  const FirestoreRepository(this._dataSource);
  final FirestoreDataSource _dataSource;

  Future<void> setUser({required String userId, required AppUser user}) async {
    _dataSource.setData(
      path: FirestorePath.users(userId),
      data: user.toJson(),
    );
    print("User successfully created");
  }
}

final databaseProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(ref.watch(firestoreDataSourceProvider));
});
