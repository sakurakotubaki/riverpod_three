import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_three/secure_storage/secure_storage_repository.dart';

part 'time_measurement_repository.g.dart';

/// SecureStorageに保存する際のキー
const _startTimeKey = 'time_measurement_start_time';

/// 時間計測リポジトリのインターフェース
/// テスト時にモックと差し替え可能にするための抽象クラス
abstract interface class TimeMeasurementRepositoryInterface {
  /// 開始時刻を保存
  Future<void> saveStartTime(DateTime startTime);

  /// 開始時刻を取得（保存されていない場合はnull）
  Future<DateTime?> getStartTime();

  /// 開始時刻をクリア
  Future<void> clearStartTime();
}

/// 時間計測リポジトリのプロバイダー
/// keepAlive: trueでアプリ全体で状態を保持
/// 戻り値をインターフェース型にすることで、テスト時にモックと差し替え可能
@Riverpod(keepAlive: true)
TimeMeasurementRepositoryInterface timeMeasurementRepository(Ref ref) {
  final secureStorage = ref.read(secureStorageRepositoryProviderProvider);
  return TimeMeasurementRepository(secureStorage);
}

/// 時間計測リポジトリの実装
/// SecureStorageRepositoryをラップして時間計測専用のメソッドを提供
class TimeMeasurementRepository implements TimeMeasurementRepositoryInterface {
  final SecureStorageRepository _secureStorage;

  TimeMeasurementRepository(this._secureStorage);

  @override
  Future<void> saveStartTime(DateTime startTime) async {
    await _secureStorage.write(_startTimeKey, startTime.toIso8601String());
  }

  @override
  Future<DateTime?> getStartTime() async {
    final stored = await _secureStorage.read(_startTimeKey);
    if (stored == null) return null;
    return DateTime.tryParse(stored);
  }

  @override
  Future<void> clearStartTime() async {
    await _secureStorage.delete(_startTimeKey);
  }
}
