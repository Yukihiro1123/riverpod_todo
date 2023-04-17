// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksRepositoryHash() => r'03b0f5c7367428c1b919ebfb8eb836381a64d799';

/// See also [tasksRepository].
@ProviderFor(tasksRepository)
final tasksRepositoryProvider = Provider<TasksRepository>.internal(
  tasksRepository,
  name: r'tasksRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tasksRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TasksRepositoryRef = ProviderRef<TasksRepository>;
String _$tasksStreamHash() => r'83cedb83768a048de75bedb3168210f3d13c4a62';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef TasksStreamRef = AutoDisposeStreamProviderRef<List<Task>>;

/// See also [tasksStream].
@ProviderFor(tasksStream)
const tasksStreamProvider = TasksStreamFamily();

/// See also [tasksStream].
class TasksStreamFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [tasksStream].
  const TasksStreamFamily();

  /// See also [tasksStream].
  TasksStreamProvider call(
    String projectId,
  ) {
    return TasksStreamProvider(
      projectId,
    );
  }

  @override
  TasksStreamProvider getProviderOverride(
    covariant TasksStreamProvider provider,
  ) {
    return call(
      provider.projectId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tasksStreamProvider';
}

/// See also [tasksStream].
class TasksStreamProvider extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [tasksStream].
  TasksStreamProvider(
    this.projectId,
  ) : super.internal(
          (ref) => tasksStream(
            ref,
            projectId,
          ),
          from: tasksStreamProvider,
          name: r'tasksStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tasksStreamHash,
          dependencies: TasksStreamFamily._dependencies,
          allTransitiveDependencies:
              TasksStreamFamily._allTransitiveDependencies,
        );

  final String projectId;

  @override
  bool operator ==(Object other) {
    return other is TasksStreamProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$myTasksStreamHash() => r'24a32b5c925843008d4791c3f5c6c2b228275ace';
typedef MyTasksStreamRef = AutoDisposeStreamProviderRef<List<Task>>;

/// See also [myTasksStream].
@ProviderFor(myTasksStream)
const myTasksStreamProvider = MyTasksStreamFamily();

/// See also [myTasksStream].
class MyTasksStreamFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [myTasksStream].
  const MyTasksStreamFamily();

  /// See also [myTasksStream].
  MyTasksStreamProvider call(
    int status,
  ) {
    return MyTasksStreamProvider(
      status,
    );
  }

  @override
  MyTasksStreamProvider getProviderOverride(
    covariant MyTasksStreamProvider provider,
  ) {
    return call(
      provider.status,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'myTasksStreamProvider';
}

/// See also [myTasksStream].
class MyTasksStreamProvider extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [myTasksStream].
  MyTasksStreamProvider(
    this.status,
  ) : super.internal(
          (ref) => myTasksStream(
            ref,
            status,
          ),
          from: myTasksStreamProvider,
          name: r'myTasksStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myTasksStreamHash,
          dependencies: MyTasksStreamFamily._dependencies,
          allTransitiveDependencies:
              MyTasksStreamFamily._allTransitiveDependencies,
        );

  final int status;

  @override
  bool operator ==(Object other) {
    return other is MyTasksStreamProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$feedTasksStreamHash() => r'16ce61ccc8f5875d2d47beab915af8843a915be8';

/// See also [feedTasksStream].
@ProviderFor(feedTasksStream)
final feedTasksStreamProvider = AutoDisposeStreamProvider<List<Task>>.internal(
  feedTasksStream,
  name: r'feedTasksStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedTasksStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FeedTasksStreamRef = AutoDisposeStreamProviderRef<List<Task>>;
String _$taskStreamHash() => r'fe9f14670ff6a9495e5ebdfdc354392347c2c91e';
typedef TaskStreamRef = AutoDisposeStreamProviderRef<Task>;

/// See also [taskStream].
@ProviderFor(taskStream)
const taskStreamProvider = TaskStreamFamily();

/// See also [taskStream].
class TaskStreamFamily extends Family<AsyncValue<Task>> {
  /// See also [taskStream].
  const TaskStreamFamily();

  /// See also [taskStream].
  TaskStreamProvider call(
    String projectId,
    String taskId,
  ) {
    return TaskStreamProvider(
      projectId,
      taskId,
    );
  }

  @override
  TaskStreamProvider getProviderOverride(
    covariant TaskStreamProvider provider,
  ) {
    return call(
      provider.projectId,
      provider.taskId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskStreamProvider';
}

/// See also [taskStream].
class TaskStreamProvider extends AutoDisposeStreamProvider<Task> {
  /// See also [taskStream].
  TaskStreamProvider(
    this.projectId,
    this.taskId,
  ) : super.internal(
          (ref) => taskStream(
            ref,
            projectId,
            taskId,
          ),
          from: taskStreamProvider,
          name: r'taskStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskStreamHash,
          dependencies: TaskStreamFamily._dependencies,
          allTransitiveDependencies:
              TaskStreamFamily._allTransitiveDependencies,
        );

  final String projectId;
  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is TaskStreamProvider &&
        other.projectId == projectId &&
        other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
