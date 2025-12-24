import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_three/secure_storage/time_measurement_repository.dart';
import 'package:riverpod_three/secure_storage/time_measurement_state.dart';
import 'package:riverpod_three/secure_storage/time_measurement_usecase.dart';

// Mockitoでモッククラスを生成
@GenerateMocks([TimeMeasurementRepositoryInterface])
import 'time_measurement_test.mocks.dart';

void main() {
  late MockTimeMeasurementRepositoryInterface mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockTimeMeasurementRepositoryInterface();
  });

  tearDown(() {
    container.dispose();
  });

  group('TimeMeasurementUsecase', () {
    test('初期状態: 保存データがない場合はNotStarted', () async {
      // Arrange（準備）
      // 期待値: repository.getStartTime()がnullを返す
      when(mockRepository.getStartTime()).thenAnswer((_) async => null);

      container = ProviderContainer(
        overrides: [
          timeMeasurementRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // Act（実行）
      final state = await container.read(timeMeasurementUsecaseProvider.future);

      // Assert（検証）
      // 期待値: NotStarted状態
      // 実際の値: stateがNotStartedのインスタンス
      expect(state, isA<NotStarted>());

      // getStartTimeが1回だけ呼ばれたことを確認
      verify(mockRepository.getStartTime()).called(1);
    });

    test('初期状態: 保存データがある場合はMeasuring', () async {
      // Arrange（準備）
      final storedTime = DateTime(2025, 1, 1, 10, 0, 0);
      // 期待値: repository.getStartTime()がstoredTimeを返す
      when(mockRepository.getStartTime()).thenAnswer((_) async => storedTime);

      container = ProviderContainer(
        overrides: [
          timeMeasurementRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // Act（実行）
      final state = await container.read(timeMeasurementUsecaseProvider.future);

      // Assert（検証）
      // 期待値: Measuring状態、startTimeがstoredTimeと一致
      // 実際の値: stateがMeasuringのインスタンス
      expect(state, isA<Measuring>());
      expect((state as Measuring).startTime, storedTime);

      // getStartTimeが1回だけ呼ばれたことを確認
      verify(mockRepository.getStartTime()).called(1);
    });

    test('startMeasurement: 開始時刻を保存してMeasuring状態に遷移', () async {
      // Arrange（準備）
      when(mockRepository.getStartTime()).thenAnswer((_) async => null);
      when(mockRepository.saveStartTime(any)).thenAnswer((_) async {});

      container = ProviderContainer(
        overrides: [
          timeMeasurementRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // 初期化を待つ
      await container.read(timeMeasurementUsecaseProvider.future);

      // Act（実行）
      await container.read(timeMeasurementUsecaseProvider.notifier).startMeasurement();

      // Assert（検証）
      final state = await container.read(timeMeasurementUsecaseProvider.future);

      // 期待値: Measuring状態
      // 実際の値: stateがMeasuringのインスタンス
      expect(state, isA<Measuring>());

      // 期待値: saveStartTimeが1回だけ呼ばれる
      // 実際の値: verify()で確認
      verify(mockRepository.saveStartTime(any)).called(1);
    });

    test('completeMeasurement: 経過時間を計算してCompleted状態に遷移', () async {
      // Arrange（準備）
      final startTime = DateTime.now().subtract(const Duration(seconds: 5));
      when(mockRepository.getStartTime()).thenAnswer((_) async => startTime);
      when(mockRepository.clearStartTime()).thenAnswer((_) async {});

      container = ProviderContainer(
        overrides: [
          timeMeasurementRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // 初期化を待つ（Measuring状態になる）
      await container.read(timeMeasurementUsecaseProvider.future);

      // Act（実行）
      final elapsed = await container
          .read(timeMeasurementUsecaseProvider.notifier)
          .completeMeasurement();

      // Assert（検証）
      final state = await container.read(timeMeasurementUsecaseProvider.future);

      // 期待値: 経過時間が5秒以上
      // 実際の値: elapsedのinSecondsが5以上
      expect(elapsed.inSeconds, greaterThanOrEqualTo(5));

      // 期待値: Completed状態
      // 実際の値: stateがCompletedのインスタンス
      expect(state, isA<Completed>());

      // 期待値: clearStartTimeが1回だけ呼ばれる
      // 実際の値: verify()で確認
      verify(mockRepository.clearStartTime()).called(1);
    });

    test('completeMeasurement: Measuring状態でない場合はStateErrorをスロー', () async {
      // Arrange（準備）
      when(mockRepository.getStartTime()).thenAnswer((_) async => null);

      container = ProviderContainer(
        overrides: [
          timeMeasurementRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // 初期化を待つ（NotStarted状態）
      await container.read(timeMeasurementUsecaseProvider.future);

      // Act & Assert（実行と検証）
      // 期待値: StateErrorがスローされる
      // 実際の値: throwsA()で確認
      expect(
        () => container
            .read(timeMeasurementUsecaseProvider.notifier)
            .completeMeasurement(),
        throwsA(isA<StateError>()),
      );

      // 期待値: clearStartTimeが呼ばれない
      // 実際の値: verifyNever()で確認
      verifyNever(mockRepository.clearStartTime());
    });

    test('reset: ストレージをクリアしてNotStarted状態に戻る', () async {
      // Arrange（準備）
      final startTime = DateTime.now();
      when(mockRepository.getStartTime()).thenAnswer((_) async => startTime);
      when(mockRepository.clearStartTime()).thenAnswer((_) async {});

      container = ProviderContainer(
        overrides: [
          timeMeasurementRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // 初期化を待つ
      await container.read(timeMeasurementUsecaseProvider.future);

      // Act（実行）
      await container.read(timeMeasurementUsecaseProvider.notifier).reset();

      // Assert（検証）
      final state = await container.read(timeMeasurementUsecaseProvider.future);

      // 期待値: NotStarted状態
      // 実際の値: stateがNotStartedのインスタンス
      expect(state, isA<NotStarted>());

      // 期待値: clearStartTimeが1回だけ呼ばれる
      // 実際の値: verify()で確認
      verify(mockRepository.clearStartTime()).called(1);
    });
  });

  group('AsyncValue handling with switch', () {
    test('AsyncValueをswitch式で処理（プロジェクト規約）', () async {
      // Arrange（準備）
      when(mockRepository.getStartTime()).thenAnswer((_) async => null);

      container = ProviderContainer(
        overrides: [
          timeMeasurementRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // 初期化を待つ
      await container.read(timeMeasurementUsecaseProvider.future);

      // Act（実行）
      // AsyncValueを直接取得（.futureではなく）
      final asyncValue = container.read(timeMeasurementUsecaseProvider);

      // Assert（検証）
      // switch式でAsyncValueを処理（.whenは非推奨）
      final message = switch (asyncValue) {
        AsyncLoading() => 'Loading...',
        AsyncError(:final error) => 'Error: $error',
        AsyncData(:final value) => switch (value) {
          NotStarted() => 'Ready to start',
          Measuring(:final startTime) => 'Started at: $startTime',
          Completed(:final elapsed) => 'Elapsed: ${elapsed.inSeconds}s',
        },
      };

      // 期待値: 'Ready to start'（NotStarted状態のため）
      // 実際の値: messageがReady to start
      expect(message, 'Ready to start');
    });
  });
}
