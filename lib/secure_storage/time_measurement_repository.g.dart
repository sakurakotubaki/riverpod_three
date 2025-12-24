// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_measurement_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 時間計測リポジトリのプロバイダー
/// keepAlive: trueでアプリ全体で状態を保持
/// 戻り値をインターフェース型にすることで、テスト時にモックと差し替え可能

@ProviderFor(timeMeasurementRepository)
const timeMeasurementRepositoryProvider = TimeMeasurementRepositoryProvider._();

/// 時間計測リポジトリのプロバイダー
/// keepAlive: trueでアプリ全体で状態を保持
/// 戻り値をインターフェース型にすることで、テスト時にモックと差し替え可能

final class TimeMeasurementRepositoryProvider
    extends
        $FunctionalProvider<
          TimeMeasurementRepositoryInterface,
          TimeMeasurementRepositoryInterface,
          TimeMeasurementRepositoryInterface
        >
    with $Provider<TimeMeasurementRepositoryInterface> {
  /// 時間計測リポジトリのプロバイダー
  /// keepAlive: trueでアプリ全体で状態を保持
  /// 戻り値をインターフェース型にすることで、テスト時にモックと差し替え可能
  const TimeMeasurementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeMeasurementRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeMeasurementRepositoryHash();

  @$internal
  @override
  $ProviderElement<TimeMeasurementRepositoryInterface> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TimeMeasurementRepositoryInterface create(Ref ref) {
    return timeMeasurementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimeMeasurementRepositoryInterface value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimeMeasurementRepositoryInterface>(
        value,
      ),
    );
  }
}

String _$timeMeasurementRepositoryHash() =>
    r'6a7dd9e4d0e787238ced7041b4541a0b67ae0996';
