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
String _$tasksQueryHash() => r'ffefcc0d1b86440bac22592328bdc2b3777e0392';

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

typedef TasksQueryRef = AutoDisposeProviderRef<Query<Task>>;

/// See also [tasksQuery].
@ProviderFor(tasksQuery)
const tasksQueryProvider = TasksQueryFamily();

/// See also [tasksQuery].
class TasksQueryFamily extends Family<Query<Task>> {
  /// See also [tasksQuery].
  const TasksQueryFamily();

  /// See also [tasksQuery].
  TasksQueryProvider call(
    String projectId,
  ) {
    return TasksQueryProvider(
      projectId,
    );
  }

  @override
  TasksQueryProvider getProviderOverride(
    covariant TasksQueryProvider provider,
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
  String? get name => r'tasksQueryProvider';
}

/// See also [tasksQuery].
class TasksQueryProvider extends AutoDisposeProvider<Query<Task>> {
  /// See also [tasksQuery].
  TasksQueryProvider(
    this.projectId,
  ) : super.internal(
          (ref) => tasksQuery(
            ref,
            projectId,
          ),
          from: tasksQueryProvider,
          name: r'tasksQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tasksQueryHash,
          dependencies: TasksQueryFamily._dependencies,
          allTransitiveDependencies:
              TasksQueryFamily._allTransitiveDependencies,
        );

  final String projectId;

  @override
  bool operator ==(Object other) {
    return other is TasksQueryProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$myTasksQueryHash() => r'88d3ce1252525d804f0d451cb536b0d2df6c3d82';
typedef MyTasksQueryRef = AutoDisposeProviderRef<Query<Task>>;

/// See also [myTasksQuery].
@ProviderFor(myTasksQuery)
const myTasksQueryProvider = MyTasksQueryFamily();

/// See also [myTasksQuery].
class MyTasksQueryFamily extends Family<Query<Task>> {
  /// See also [myTasksQuery].
  const MyTasksQueryFamily();

  /// See also [myTasksQuery].
  MyTasksQueryProvider call(
    int status,
  ) {
    return MyTasksQueryProvider(
      status,
    );
  }

  @override
  MyTasksQueryProvider getProviderOverride(
    covariant MyTasksQueryProvider provider,
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
  String? get name => r'myTasksQueryProvider';
}

/// See also [myTasksQuery].
class MyTasksQueryProvider extends AutoDisposeProvider<Query<Task>> {
  /// See also [myTasksQuery].
  MyTasksQueryProvider(
    this.status,
  ) : super.internal(
          (ref) => myTasksQuery(
            ref,
            status,
          ),
          from: myTasksQueryProvider,
          name: r'myTasksQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myTasksQueryHash,
          dependencies: MyTasksQueryFamily._dependencies,
          allTransitiveDependencies:
              MyTasksQueryFamily._allTransitiveDependencies,
        );

  final int status;

  @override
  bool operator ==(Object other) {
    return other is MyTasksQueryProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$feedTasksQueryHash() => r'942700588a77667fb45a429be0f17c680add0f6e';

/// See also [feedTasksQuery].
@ProviderFor(feedTasksQuery)
final feedTasksQueryProvider = AutoDisposeProvider<Query<Task>>.internal(
  feedTasksQuery,
  name: r'feedTasksQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedTasksQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FeedTasksQueryRef = AutoDisposeProviderRef<Query<Task>>;
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
