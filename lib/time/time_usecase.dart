import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_three/time/time_repository.dart';
part 'time_usecase.g.dart';

@riverpod
class TimeUsecase extends _$TimeUsecase {
  @override
  Future<String?> build() {
    return getTime();
  }

  Future<void> saveTime(DateTime dateTime) async {
    final repository = ref.read(timeRepositoryProvider);
    await repository.saveTime(dateTime);
  }

  Future<String?> getTime() async {
    final repository = ref.read(timeRepositoryProvider);
    return await repository.getTime();
  }

  Future<void> deleteTime() async {
    final repository = ref.read(timeRepositoryProvider);
    await repository.deleteTime();
  }
}