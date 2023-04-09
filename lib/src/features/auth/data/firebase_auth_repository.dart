import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  Future<void> createAccont(
          {required User user,
          required String name,
          required int ratePerHour}) =>
      _firestore.collection(usersPath(user.uid)).add({});

  // Future<void> signInWithEmailAndPassword(String email, String password) {
  //   return _auth.signInWithEmailAndPassword(email: email, password: password);
  // }

  Future<void> createUserWithEmailAndPassword(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
      ref.watch(firebaseAuthProvider), FirebaseFirestore.instance);
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});
