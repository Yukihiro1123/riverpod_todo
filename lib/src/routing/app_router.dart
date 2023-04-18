// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:riverpod_todo/src/features/account/presentation/account_screen.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/presentation/auth_screen.dart';
import 'package:riverpod_todo/src/features/feed/presentation/feed_screen.dart';
import 'package:riverpod_todo/src/features/projects/data/projects_repository.dart';

import 'package:riverpod_todo/src/features/projects/presentation/add_project/add_project_screen.dart';
import 'package:riverpod_todo/src/features/projects/presentation/edit_project/edit_project_screen.dart';
import 'package:riverpod_todo/src/features/projects/presentation/projects/projects_screen.dart';
import 'package:riverpod_todo/src/features/projects/tasks/presentation/add_task/add_task_screen.dart';
import 'package:riverpod_todo/src/features/projects/tasks/presentation/edit_task_screen/edit_task_screen.dart';
import 'package:riverpod_todo/src/features/projects/tasks/presentation/tasks_screen/tasks_screen.dart';

import 'package:riverpod_todo/src/routing/go_router_refresh_stream.dart';
import 'package:riverpod_todo/src/routing/scaffold_with_bottom_nav_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  auth,
  projects,
  project,
  addProject,
  editProject,
  tasks,
  task,
  addTask,
  editTask,
  feed,
  account,
}

@riverpod
// ignore: unsupported_provider_value
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/auth',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.subloc.startsWith('/auth')) {
          return '/projects';
        }
      } else {
        if (state.subloc.startsWith('/tasks') ||
            state.subloc.startsWith('/feeds') ||
            state.subloc.startsWith('/account')) {
          return '/auth';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/auth',
        name: AppRoute.auth.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const AuthScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: "/projects",
            name: AppRoute.projects.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProjectsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add_project',
                name: AppRoute.addProject.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const AddProjectScreen(),
                  );
                },
              ),
              GoRoute(
                path: ':projectId',
                name: AppRoute.project.name,
                pageBuilder: (context, state) {
                  final projectId = state.params['projectId'];
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: TasksScreen(projectId: projectId!),
                  );
                },
                redirect: ((context, state) async {
                  final projectId = state.params['projectId'];
                  final bool isProjectExists = await ref
                      .read(projectsRepositoryProvider)
                      .checkIfProjectExists(projectId!);
                  if (!isProjectExists) {
                    return "/projects";
                  }
                  return null;
                }),
                routes: [
                  GoRoute(
                    path: 'edit_project',
                    name: AppRoute.editProject.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final projectId = state.params['projectId'];
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: EditProjectScreen(projectId: projectId!),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'add_task',
                    name: AppRoute.addTask.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final projectId = state.params['projectId'];
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: AddTaskScreen(projectId: projectId!),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'task/:taskId/edit_task',
                    name: AppRoute.editTask.name,
                    pageBuilder: (context, state) {
                      final projectId = state.params['projectId'];
                      final taskId = state.params['taskId'];
                      return NoTransitionPage(
                        key: state.pageKey,
                        child: EditTaskScreen(
                            projectId: projectId!, taskId: taskId!),
                      );
                    },
                    redirect: ((context, state) async {
                      final projectId = state.params['projectId'];
                      final taskId = state.params['taskId'];
                      final bool isTaskExists = await ref
                          .read(projectsRepositoryProvider)
                          .checkIfTaskExists(projectId!, taskId!);
                      if (!isTaskExists) {
                        return "/projects";
                      }
                      return null;
                    }),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/feed',
            name: AppRoute.feed.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const FeedScreen(),
            ),
          ),
          GoRoute(
            path: '/account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const AccountScreen(),
            ),
          ),
        ],
      ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
