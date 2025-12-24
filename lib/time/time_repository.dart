import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_three/time/time_datasource.dart';
part 'time_repository.g.dart';

/// SecureStorageに保存する際のキー
const _startTimeKey = 'time_measurement_start_time';

@Riverpod(keepAlive: true)
TimeRepository timeRepository(Ref ref) {
  final timeDatasource = ref.watch(timeDatasourceProvider);
  return TimeRepository(timeDatasource);
}

abstract interface class TimeInterface {
  Future<void> saveTime(DateTime dateTime);
  Future<String?> getTime();
  Future<void> deleteTime();
}

class TimeRepository implements TimeInterface {
  final TimeDatasource _timeDatasource;

  TimeRepository(this._timeDatasource);

  @override
  Future<void> saveTime(DateTime dateTime) async {
    await _timeDatasource.saveTime(_startTimeKey, dateTime.toIso8601String());
  }

  @override
  Future<String?> getTime() async {
    return await _timeDatasource.getTime(_startTimeKey);
  }

  @override
  Future<void> deleteTime() async {
    await _timeDatasource.deleteTime(_startTimeKey);
  }
}