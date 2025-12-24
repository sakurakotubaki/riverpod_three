import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_three/secure_storage/time_measurement_repository.dart';
import 'package:riverpod_three/secure_storage/time_measurement_state.dart';

part 'time_measurement_usecase.g.dart';

/// 時間計測のユースケース
/// AsyncNotifierで状態を管理し、SecureStorageに永続化
@riverpod
class TimeMeasurementUsecase extends _$TimeMeasurementUsecase {
  @override
  Future<TimeMeasurementState> build() async {
    // SecureStorageから開始時刻を読み込み、状態を復元
    final repository = ref.read(timeMeasurementRepositoryProvider);
    final storedStartTime = await repository.getStartTime();

    if (storedStartTime == null) {
      return const NotStarted();
    }
    return Measuring(storedStartTime);
  }

  /// 計測を開始する
  /// 現在時刻をSecureStorageに保存し、Measuring状態に遷移
  Future<void> startMeasurement() async {
    final repository = ref.read(timeMeasurementRepositoryProvider);
    final now = DateTime.now();

    await repository.saveStartTime(now);
    state = AsyncData(Measuring(now));
  }

  /// 計測を完了する
  /// 経過時間を計算し、Completed状態に遷移
  /// 戻り値: 経過時間（Duration）
  Future<Duration> completeMeasurement() async {
    final currentState = state.value;
    if (currentState is! Measuring) {
      throw StateError('Cannot complete measurement: not in measuring state');
    }

    final repository = ref.read(timeMeasurementRepositoryProvider);
    final endTime = DateTime.now();
    final elapsed = endTime.difference(currentState.startTime);

    await repository.clearStartTime();
    state = AsyncData(Completed(currentState.startTime, endTime, elapsed));

    return elapsed;
  }

  /// 計測をリセットする
  /// SecureStorageをクリアし、NotStarted状態に遷移
  Future<void> reset() async {
    final repository = ref.read(timeMeasurementRepositoryProvider);
    await repository.clearStartTime();
    state = const AsyncData(NotStarted());
  }
}
