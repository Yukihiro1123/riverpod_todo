// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/src/features/auth/presentation/account_screen.dart';
import 'package:riverpod_todo/src/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_todo/src/features/auth/presentation/auth_screen.dart';
import 'package:riverpod_todo/src/features/feed/presentation/feed_screen.dart';
import 'package:riverpod_todo/src/features/tasks/presentation/edit_task_screen.dart';
import 'package:riverpod_todo/src/features/tasks/presentation/tasks_screen.dart';
import 'package:riverpod_todo/src/routing/go_router_refresh_stream.dart';
import 'package:riverpod_todo/src/routing/scaffold_with_bottom_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  auth,
  tasks,
  task,
  addTask,
  editTask,
  feed,
  account,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/auth',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.subloc.startsWith('/auth')) {
          return '/tasks';
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
            path: '/tasks',
            name: AppRoute.tasks.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const TasksScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.addTask.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const EditTaskScreen(),
                  );
                },
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
});
