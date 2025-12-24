import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'network_status.dart';

part 'connectivity_provider.g.dart';

/// ネットワーク接続状態を監視するプロバイダー
/// 定期的にネットワーク接続を確認し、状態を更新する
@riverpod
class NetworkStatusNotifier extends _$NetworkStatusNotifier {
  Timer? _timer;

  @override
  NetworkStatus build() {
    // 初期状態は確認中
    _startMonitoring();

    // プロバイダーが破棄される際にタイマーをキャンセル
    ref.onDispose(() {
      _timer?.cancel();
    });

    return NetworkStatus.checking;
  }

  /// ネットワーク監視を開始
  void _startMonitoring() {
    // 初回チェック
    _checkConnectivity();

    // 10秒ごとに接続状態を確認
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _checkConnectivity();
    });
  }

  /// ネットワーク接続を確認
  Future<void> _checkConnectivity() async {
    try {
      // Google DNSに接続を試みて接続状態を確認
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _updateStatus(NetworkStatus.online);
      } else {
        _updateStatus(NetworkStatus.offline);
      }
    } on SocketException catch (_) {
      _updateStatus(NetworkStatus.offline);
    } on TimeoutException catch (_) {
      _updateStatus(NetworkStatus.offline);
    } catch (e) {
      debugPrint('Connectivity check error: $e');
      _updateStatus(NetworkStatus.offline);
    }
  }

  /// ステータスを更新（変更があった場合のみ）
  void _updateStatus(NetworkStatus newStatus) {
    if (state != newStatus) {
      debugPrint('NetworkStatus changed: $state -> $newStatus');
      state = newStatus;
    }
  }

  /// 手動で接続状態を再確認
  Future<void> refresh() async {
    state = NetworkStatus.checking;
    await _checkConnectivity();
  }
}
