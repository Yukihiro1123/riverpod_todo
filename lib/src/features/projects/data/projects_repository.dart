import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/projects/domain/project.dart';
part 'projects_repository.g.dart';

class ProjectsRepository {
  const ProjectsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String projectPath(String uid, String projectId) =>
      'projects/$projectId';
  static String projectsPath(String uid) => 'projects/';

  // create
  Future<void> addProject({required String uid, required Project project}) {
    return _firestore
        .doc(projectPath(uid, project.projectId))
        .set(project.toJson());
  }

  // update
  Future<void> updateProject({required String uid, required Project project}) {
    return _firestore
        .doc(projectPath(uid, project.projectId))
        .update(project.toJson());
  }

  // delete
  Future<void> deleteProject(
      {required String uid, required String projectId}) async {
    // delete project
    final projectRef = _firestore.doc(projectPath(uid, projectId));
    await projectRef.delete();
  }

  // read
  Stream<Project> watchProject(
      {required String uid, required String projectId}) {
    return _firestore
        .doc(projectPath(uid, projectId))
        .withConverter<Project>(
          fromFirestore: (snapshot, _) => Project.fromJson(snapshot.data()!),
          toFirestore: (project, _) => project.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.data()!);
  }

  Stream<List<Project>> watchProjects({required String uid}) =>
      queryprojects(uid: uid)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Project> queryprojects({required String uid}) =>
      _firestore.collection(projectsPath(uid)).withConverter(
            fromFirestore: (snapshot, _) => Project.fromJson(snapshot.data()!),
            toFirestore: (project, _) => project.toJson(),
          );

  // Future<List<project>> fetchprojects({required String uid}) async {
  //   final query = await queryprojects(uid: uid).get();
  //   return query.docs.map((doc) => doc.data()).toList();
  // }

  Future<Project> fetchproject(
      {required String uid, required String projectId}) async {
    final query =
        await _firestore.collection(projectPath(uid, projectId)).get();
    final Project project = Project.fromJson(query.docs[0].data());
    return project;
  }
}

@Riverpod(keepAlive: true)
ProjectsRepository projectsRepository(ProjectsRepositoryRef ref) {
  return ProjectsRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Project> projectsQuery(ProjectsQueryRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(projectsRepositoryProvider);
  return repository.queryprojects(uid: user.uid);
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
