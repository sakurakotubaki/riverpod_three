/// 時間計測の状態を表すsealed class
/// Dart 3.0のパターンマッチングを活用してswitch式で状態を処理
sealed class TimeMeasurementState {
  const TimeMeasurementState();
}

/// 計測開始前の状態
final class NotStarted extends TimeMeasurementState {
  const NotStarted();
}

/// 計測中の状態
final class Measuring extends TimeMeasurementState {
  final DateTime startTime;
  const Measuring(this.startTime);
}

/// 計測完了の状態
final class Completed extends TimeMeasurementState {
  final DateTime startTime;
  final DateTime endTime;
  final Duration elapsed;
  const Completed(this.startTime, this.endTime, this.elapsed);
}
