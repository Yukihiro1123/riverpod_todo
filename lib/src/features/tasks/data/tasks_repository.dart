import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/tasks/domain/task/task.dart';

part 'tasks_repository.g.dart';

class TasksRepository {
  const TasksRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String taskPath(String uid, String taskId) =>
      'users/$uid/tasks/$taskId';
  static String tasksPath(String uid) => 'users/$uid/tasks';

  // create
  Future<void> addTask({required String uid, required Task task}) {
    return _firestore.collection(tasksPath(uid)).add(task.toJson());
  }

  // update
  Future<void> updateTask({required String uid, required Task task}) {
    return _firestore.doc(taskPath(uid, task.taskId)).update(task.toJson());
  }

  // delete
  Future<void> deleteTask({required String uid, required String taskId}) async {
    // delete task
    final taskRef = _firestore.doc(taskPath(uid, taskId));
    await taskRef.delete();
  }

  // read
  Stream<Task> watchTask({required String uid, required String taskId}) =>
      _firestore
          .doc(taskPath(uid, taskId))
          .withConverter<Task>(
            fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
            toFirestore: (task, _) => task.toJson(),
          )
          .snapshots()
          .map((snapshot) => snapshot.data()!);

  Stream<List<Task>> watchTasks({required String uid}) => queryTasks(uid: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Task> queryTasks({required String uid}) =>
      _firestore.collection(tasksPath(uid)).withConverter(
            fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
            toFirestore: (task, _) => task.toJson(),
          );

  Future<List<Task>> fetchTasks({required String uid}) async {
    final tasks = await queryTasks(uid: uid).get();
    return tasks.docs.map((doc) => doc.data()).toList();
  }
}

@Riverpod(keepAlive: true)
TasksRepository tasksRepository(TasksRepositoryRef ref) {
  return TasksRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Task> tasksQuery(TasksQueryRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(tasksRepositoryProvider);
  return repository.queryTasks(uid: user.uid);
}

@riverpod
Stream<Task> taskStream(TaskStreamRef ref, String taskId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(tasksRepositoryProvider);
  return repository.watchTask(uid: user.uid, taskId: taskId);
}
