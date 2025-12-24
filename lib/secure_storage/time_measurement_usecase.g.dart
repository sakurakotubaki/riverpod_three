// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_measurement_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 時間計測のユースケース
/// AsyncNotifierで状態を管理し、SecureStorageに永続化

@ProviderFor(TimeMeasurementUsecase)
const timeMeasurementUsecaseProvider = TimeMeasurementUsecaseProvider._();

/// 時間計測のユースケース
/// AsyncNotifierで状態を管理し、SecureStorageに永続化
final class TimeMeasurementUsecaseProvider
    extends
        $AsyncNotifierProvider<TimeMeasurementUsecase, TimeMeasurementState> {
  /// 時間計測のユースケース
  /// AsyncNotifierで状態を管理し、SecureStorageに永続化
  const TimeMeasurementUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeMeasurementUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeMeasurementUsecaseHash();

  @$internal
  @override
  TimeMeasurementUsecase create() => TimeMeasurementUsecase();
}

String _$timeMeasurementUsecaseHash() =>
    r'248efa21ca9f9e12d900237029b885db74082879';

/// 時間計測のユースケース
/// AsyncNotifierで状態を管理し、SecureStorageに永続化

abstract class _$TimeMeasurementUsecase
    extends $AsyncNotifier<TimeMeasurementState> {
  FutureOr<TimeMeasurementState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<TimeMeasurementState>, TimeMeasurementState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TimeMeasurementState>,
                TimeMeasurementState
              >,
              AsyncValue<TimeMeasurementState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
