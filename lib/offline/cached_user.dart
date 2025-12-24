import 'package:freezed_annotation/freezed_annotation.dart';

part 'cached_user.freezed.dart';
part 'cached_user.g.dart';

/// キャッシュ用のユーザーモデル
/// APIから取得したデータをオフライン時にも使用可能にする
@freezed
abstract class CachedUser with _$CachedUser {
  const factory CachedUser({
    required int id,
    required String name,
    required String email,
    /// キャッシュされた日時
    required DateTime cachedAt,
  }) = _CachedUser;

  factory CachedUser.fromJson(Map<String, dynamic> json) =>
      _$CachedUserFromJson(json);
}

/// キャッシュデータの状態を表すsealed class
/// Dart 3.0のパターンマッチングを活用
sealed class CacheState<T> {
  const CacheState();
}

/// 新鮮なデータ（APIから取得）
final class FreshData<T> extends CacheState<T> {
  final T data;
  const FreshData(this.data);
}

/// キャッシュされたデータ（オフライン時）
final class CachedData<T> extends CacheState<T> {
  final T data;
  final DateTime cachedAt;
  const CachedData(this.data, this.cachedAt);
}

/// データ読み込み中
final class LoadingData<T> extends CacheState<T> {
  const LoadingData();
}

/// エラー状態
final class ErrorData<T> extends CacheState<T> {
  final Object error;
  final StackTrace? stackTrace;
  const ErrorData(this.error, [this.stackTrace]);
}
