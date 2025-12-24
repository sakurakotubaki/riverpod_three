// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timeRepository)
const timeRepositoryProvider = TimeRepositoryProvider._();

final class TimeRepositoryProvider
    extends $FunctionalProvider<TimeRepository, TimeRepository, TimeRepository>
    with $Provider<TimeRepository> {
  const TimeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeRepositoryHash();

  @$internal
  @override
  $ProviderElement<TimeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimeRepository create(Ref ref) {
    return timeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimeRepository>(value),
    );
  }
}

String _$timeRepositoryHash() => r'8fc7e817bf47b3eda0f80cd3e2a38076a00f69ee';
