// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsRepositoryHash() =>
    r'a69e75edeb89ce9c6509675f150bc967a7295759';

/// See also [projectsRepository].
@ProviderFor(projectsRepository)
final projectsRepositoryProvider = Provider<ProjectsRepository>.internal(
  projectsRepository,
  name: r'projectsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$projectsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProjectsRepositoryRef = ProviderRef<ProjectsRepository>;
String _$projectsStreamHash() => r'754e333ddad691831fc5c04e71ecd18497e8a4f5';

/// See also [projectsStream].
@ProviderFor(projectsStream)
final projectsStreamProvider =
    AutoDisposeStreamProvider<List<Project>>.internal(
  projectsStream,
  name: r'projectsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$projectsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProjectsStreamRef = AutoDisposeStreamProviderRef<List<Project>>;
String _$myProjectsStreamHash() => r'0e0f9666cc2c1101c39cb25f680a0e9e637d8a60';

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

typedef MyProjectsStreamRef = AutoDisposeStreamProviderRef<List<Project>>;

/// See also [myProjectsStream].
@ProviderFor(myProjectsStream)
const myProjectsStreamProvider = MyProjectsStreamFamily();

/// See also [myProjectsStream].
class MyProjectsStreamFamily extends Family<AsyncValue<List<Project>>> {
  /// See also [myProjectsStream].
  const MyProjectsStreamFamily();

  /// See also [myProjectsStream].
  MyProjectsStreamProvider call(
    String userId,
  ) {
    return MyProjectsStreamProvider(
      userId,
    );
  }

  @override
  MyProjectsStreamProvider getProviderOverride(
    covariant MyProjectsStreamProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'myProjectsStreamProvider';
}

/// See also [myProjectsStream].
class MyProjectsStreamProvider
    extends AutoDisposeStreamProvider<List<Project>> {
  /// See also [myProjectsStream].
  MyProjectsStreamProvider(
    this.userId,
  ) : super.internal(
          (ref) => myProjectsStream(
            ref,
            userId,
          ),
          from: myProjectsStreamProvider,
          name: r'myProjectsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myProjectsStreamHash,
          dependencies: MyProjectsStreamFamily._dependencies,
          allTransitiveDependencies:
              MyProjectsStreamFamily._allTransitiveDependencies,
        );

  final String userId;

  @override
  bool operator ==(Object other) {
    return other is MyProjectsStreamProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$projectStreamHash() => r'e448c363f09477fbe11f51987859c4489d4c06f7';
typedef ProjectStreamRef = AutoDisposeStreamProviderRef<Project>;

/// See also [projectStream].
@ProviderFor(projectStream)
const projectStreamProvider = ProjectStreamFamily();

/// See also [projectStream].
class ProjectStreamFamily extends Family<AsyncValue<Project>> {
  /// See also [projectStream].
  const ProjectStreamFamily();

  /// See also [projectStream].
  ProjectStreamProvider call(
    String projectId,
  ) {
    return ProjectStreamProvider(
      projectId,
    );
  }

  @override
  ProjectStreamProvider getProviderOverride(
    covariant ProjectStreamProvider provider,
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
  String? get name => r'projectStreamProvider';
}

/// See also [projectStream].
class ProjectStreamProvider extends AutoDisposeStreamProvider<Project> {
  /// See also [projectStream].
  ProjectStreamProvider(
    this.projectId,
  ) : super.internal(
          (ref) => projectStream(
            ref,
            projectId,
          ),
          from: projectStreamProvider,
          name: r'projectStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectStreamHash,
          dependencies: ProjectStreamFamily._dependencies,
          allTransitiveDependencies:
              ProjectStreamFamily._allTransitiveDependencies,
        );

  final String projectId;

  @override
  bool operator ==(Object other) {
    return other is ProjectStreamProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
