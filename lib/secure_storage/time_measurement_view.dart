import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_three/secure_storage/time_measurement_state.dart';
import 'package:riverpod_three/secure_storage/time_measurement_usecase.dart';

/// 時間計測画面
/// ボタンタップで計測開始、再度タップで経過時間を表示
class TimeMeasurementView extends ConsumerWidget {
  const TimeMeasurementView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(timeMeasurementUsecaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Measurement'),
      ),
      body: Center(
        // switch式でAsyncValueを処理（.whenは非推奨）
        child: switch (asyncState) {
          AsyncLoading() => const CircularProgressIndicator(),
          AsyncError(:final error) => Text('Error: $error'),
          AsyncData(:final value) => _buildContent(context, ref, value),
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    TimeMeasurementState state,
  ) {
    // switch式で状態に応じたUIを表示
    return switch (state) {
      NotStarted() => _buildNotStarted(ref),
      Measuring(:final startTime) => _buildMeasuring(context, ref, startTime),
      Completed(:final startTime, :final endTime, :final elapsed) =>
        _buildCompleted(ref, startTime, endTime, elapsed),
    };
  }

  /// 計測開始前のUI
  Widget _buildNotStarted(WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Press button to start measuring',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            ref.read(timeMeasurementUsecaseProvider.notifier).startMeasurement();
          },
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start'),
        ),
      ],
    );
  }

  /// 計測中のUI
  Widget _buildMeasuring(
    BuildContext context,
    WidgetRef ref,
    DateTime startTime,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Measuring...',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Started at: ${_formatDateTime(startTime)}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () async {
            final elapsed = await ref
                .read(timeMeasurementUsecaseProvider.notifier)
                .completeMeasurement();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Elapsed: ${_formatDuration(elapsed)}'),
                ),
              );
            }
          },
          icon: const Icon(Icons.stop),
          label: const Text('Stop'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  /// 計測完了後のUI
  Widget _buildCompleted(
    WidgetRef ref,
    DateTime startTime,
    DateTime endTime,
    Duration elapsed,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Measurement Complete',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTimeRow('Start', _formatDateTime(startTime)),
                const Divider(),
                _buildTimeRow('End', _formatDateTime(endTime)),
                const Divider(),
                _buildTimeRow('Elapsed', _formatDuration(elapsed)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            ref.read(timeMeasurementUsecaseProvider.notifier).reset();
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Reset'),
        ),
      ],
    );
  }

  Widget _buildTimeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  /// DateTimeを時:分:秒形式にフォーマット
  String _formatDateTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  /// Durationを分:秒.ミリ秒形式にフォーマット
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    final millis = duration.inMilliseconds % 1000;
    return '$minutes:${seconds.toString().padLeft(2, '0')}.'
        '${millis.toString().padLeft(3, '0')}';
  }
}
