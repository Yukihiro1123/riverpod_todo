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
String _$tasksQueryHash() => r'd9a4dc9344e6baae0d8ac423bd8bf765c342bba0';

/// See also [tasksQuery].
@ProviderFor(tasksQuery)
final tasksQueryProvider = AutoDisposeProvider<Query<Task>>.internal(
  tasksQuery,
  name: r'tasksQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tasksQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TasksQueryRef = AutoDisposeProviderRef<Query<Task>>;
String _$taskStreamHash() => r'90b8caa97a0cd8559f2e3028d5b83fc24f56be9b';

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
    String taskId,
  ) {
    return TaskStreamProvider(
      taskId,
    );
  }

  @override
  TaskStreamProvider getProviderOverride(
    covariant TaskStreamProvider provider,
  ) {
    return call(
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
    this.taskId,
  ) : super.internal(
          (ref) => taskStream(
            ref,
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

  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is TaskStreamProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
