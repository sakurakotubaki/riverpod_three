// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timeDatasource)
const timeDatasourceProvider = TimeDatasourceProvider._();

final class TimeDatasourceProvider
    extends $FunctionalProvider<TimeDatasource, TimeDatasource, TimeDatasource>
    with $Provider<TimeDatasource> {
  const TimeDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeDatasourceHash();

  @$internal
  @override
  $ProviderElement<TimeDatasource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimeDatasource create(Ref ref) {
    return timeDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimeDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimeDatasource>(value),
    );
  }
}

String _$timeDatasourceHash() => r'367df38d1181460f60c1281c68f2793d74de9b42';
