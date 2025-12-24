/// ネットワーク接続状態を表すenum
/// Dart 3.0のsealed classとswitch式を活用
enum NetworkStatus {
  /// オンライン状態
  online,

  /// オフライン状態
  offline,

  /// 接続状態を確認中
  checking;

  /// オンラインかどうか
  bool get isOnline => this == NetworkStatus.online;

  /// オフラインかどうか
  bool get isOffline => this == NetworkStatus.offline;

  /// 確認中かどうか
  bool get isChecking => this == NetworkStatus.checking;

  /// ステータスに応じたメッセージを返す
  String get message => switch (this) {
        NetworkStatus.online => 'オンライン',
        NetworkStatus.offline => 'オフライン',
        NetworkStatus.checking => '接続確認中...',
      };
}
