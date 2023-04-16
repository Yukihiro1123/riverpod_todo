import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_todo/src/features/auth/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_repository.g.dart';

class AccountRepository {
  const AccountRepository(this._firestore, this._storage);
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  static String usersPath(String uid) => 'users/$uid';

  // update
  Future<void> updateProfile({required AppUser user}) {
    return _firestore.doc(usersPath(user.userId)).update(user.toJson());
  }

  Future<void> storeFile({
    required String id,
    required Uint8List file,
  }) async {
    await _storage.ref().child("users/$id").putData(file);
  }

  Future<String> getPhotoUrl(String userId) async {
    String url = await _storage.ref().child("users/$userId").getDownloadURL();
    return url;
  }
}

@Riverpod(keepAlive: true)
AccountRepository accountRepository(AccountRepositoryRef ref) {
  return AccountRepository(
      FirebaseFirestore.instance, FirebaseStorage.instance);
}
