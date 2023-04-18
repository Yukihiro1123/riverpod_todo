import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
part 'projects_repository.g.dart';

class ProjectsRepository {
  const ProjectsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String projectPath(String projectId) => 'projects/$projectId';
  static String projectsPath() => 'projects/';

  // create
  Future<void> addProject({required String uid, required Project project}) {
    return _firestore.doc(projectPath(project.projectId)).set(project.toJson());
  }

  // update
  Future<void> updateProject({required Project project}) {
    return _firestore
        .doc(projectPath(project.projectId))
        .update(project.toJson());
  }

  // delete
  Future<void> deleteProject(
      {required String uid, required String projectId}) async {
    // delete project
    final projectRef = _firestore.doc(projectPath(projectId));
    await projectRef.delete();
  }

  // read
  Stream<Project> watchProject({
    required String uid,
    required String projectId,
  }) {
    return _firestore
        .doc(projectPath(projectId))
        .snapshots()
        .map((snapshot) => Project.fromJson(snapshot.data()!));
  }

  // read
  Future<Project> fetchProject({
    required String projectId,
  }) async {
    final query = await _firestore.doc(projectPath(projectId)).get();
    final Project project = Project.fromJson(query.data()!);
    return project;
  }

  Stream<List<Project>> watchProjects() =>
      _firestore.collection(projectsPath()).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Project.fromJson(doc.data())).toList());

  Stream<List<Project>> watchMyProjects({required String userId}) => _firestore
      .collection(projectsPath())
      .where("members", arrayContains: userId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Project.fromJson(doc.data())).toList());

  // Future<List<project>> fetchprojects({required String uid}) async {
  //   final query = await queryprojects(uid: uid).get();
  //   return query.docs.map((doc) => doc.data()).toList();
  // }
}

@Riverpod(keepAlive: true)
ProjectsRepository projectsRepository(ProjectsRepositoryRef ref) {
  return ProjectsRepository(FirebaseFirestore.instance);
}

@Riverpod(keepAlive: false)
Stream<List<Project>> projectsStream(ProjectsStreamRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(projectsRepositoryProvider);
  return repository.watchProjects();
}

@Riverpod(keepAlive: false)
Stream<List<Project>> myProjectsStream(MyProjectsStreamRef ref, String userId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(projectsRepositoryProvider);
  return repository.watchMyProjects(userId: userId);
}

@riverpod
Stream<Project> projectStream(ProjectStreamRef ref, String projectId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(projectsRepositoryProvider);
  return repository.watchProject(uid: user.uid, projectId: projectId);
}
