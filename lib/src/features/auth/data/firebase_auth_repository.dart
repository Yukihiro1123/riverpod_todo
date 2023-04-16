import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth, this._firestore);
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  static String usersPath(String uid) => 'users/$uid';

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  User? get currentUser {
    return _auth.currentUser;
  }

  //create user
  Future<void> createAccont({required AppUser user}) async {
    await _firestore.doc(usersPath(user.userId)).set(user.toJson());
  }

  //get user
  Stream<AppUser> getAppUserById({required String userId}) {
    return _firestore
        .doc(usersPath(userId))
        .snapshots()
        .map((event) => AppUser.fromJson(event.data() as Map<String, dynamic>));
  }

  Future<void> signOut() => _auth.signOut();

  Future<AppUser?> searchUser({required String userId}) async {
    final query = await _firestore
        .collection("users")
        .where("userId", isEqualTo: userId)
        .get();
    if (query.docs.isEmpty) return null;
    return AppUser.fromJson(query.docs[0].data());
  }
}

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
      ref.watch(firebaseAuthProvider), FirebaseFirestore.instance);
}

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

@riverpod
Stream<AppUser> getAppUserById(GetAppUserByIdRef ref, String userId) {
  return ref.watch(authRepositoryProvider).getAppUserById(userId: userId);
}
