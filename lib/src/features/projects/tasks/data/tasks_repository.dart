import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/tasks/domain/task/task.dart';

part 'tasks_repository.g.dart';

class TasksRepository {
  const TasksRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String taskPath(String projectId, String taskId) =>
      'projects/$projectId/tasks/$taskId';
  static String tasksPath(String projectId) => 'projects/$projectId/tasks/';

  // create
  Future<void> addTask({required String projectId, required Task task}) {
    return _firestore.doc(taskPath(projectId, task.taskId)).set(task.toJson());
  }

  // update
  Future<void> updateTask({required String projectId, required Task task}) {
    return _firestore
        .doc(taskPath(projectId, task.taskId))
        .update(task.toJson());
  }

  // delete
  Future<void> deleteTask(
      {required String projectId, required String taskId}) async {
    // delete task
    final taskRef = _firestore.doc(taskPath(projectId, taskId));
    await taskRef.delete();
  }

  // read
  Stream<Task> watchTask({required String projectId, required String taskId}) {
    return _firestore
        .doc(taskPath(projectId, taskId))
        .snapshots()
        .map((snapshot) => Task.fromJson(snapshot.data()!));
  }

  Stream<List<Task>> watchMyTasks({required String projectId}) =>
      _firestore.collection(tasksPath(projectId)).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());

  Stream<List<Task>> tasksStream({required String projectId}) =>
      _firestore.collection(tasksPath(projectId)).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());

  Stream<List<Task>> feedTasksStream() => _firestore
      .collectionGroup("tasks")
      .where("status", isEqualTo: 2)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());

  Stream<List<Task>> myTasksStream({
    required String uid,
    required int status,
  }) =>
      _firestore
          .collectionGroup("tasks")
          .where("members", arrayContains: uid)
          .where("status", isEqualTo: status)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());

  Future<Task> fetchTask({required String uid, required String taskId}) async {
    final query = await _firestore.collection(taskPath(uid, taskId)).get();
    final Task task = Task.fromJson(query.docs[0].data());
    return task;
  }
}

@Riverpod(keepAlive: true)
TasksRepository tasksRepository(TasksRepositoryRef ref) {
  return TasksRepository(FirebaseFirestore.instance);
}

@Riverpod(keepAlive: false)
Stream<List<Task>> tasksStream(TasksStreamRef ref, String projectId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(tasksRepositoryProvider);
  return repository.tasksStream(projectId: projectId);
}

@riverpod
Stream<List<Task>> myTasksStream(MyTasksStreamRef ref, int status) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(tasksRepositoryProvider);
  return repository.myTasksStream(uid: user.uid, status: status);
}

@Riverpod(keepAlive: false)
Stream<List<Task>> feedTasksStream(FeedTasksStreamRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(tasksRepositoryProvider);
  return repository.feedTasksStream();
}

@riverpod
Stream<Task> taskStream(TaskStreamRef ref, String projectId, String taskId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(tasksRepositoryProvider);
  return repository.watchTask(projectId: projectId, taskId: taskId);
}
