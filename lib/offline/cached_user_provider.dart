import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';

import '../dio/dio_provider.dart';
import 'cached_user.dart';
import 'connectivity_provider.dart';
import 'network_status.dart';

part 'cached_user_provider.g.dart';

/// オフラインキャッシュ用のストレージプロバイダー
@riverpod
Future<JsonSqFliteStorage> offlineStorage(Ref ref) async {
  debugPrint('OfflineStorageProvider: Initializing...');
  final path = await getDatabasesPath();
  final dbPath = join(path, 'offline_cache.db');
  debugPrint('OfflineStorageProvider: DB Path: $dbPath');

  final storage = await JsonSqFliteStorage.open(dbPath);
  debugPrint('OfflineStorageProvider: Opened successfully');
  return storage;
}

/// オフラインキャッシュ対応のユーザープロバイダー
/// - オンライン時: APIからデータを取得してキャッシュに保存
/// - オフライン時: キャッシュからデータを読み込み
@riverpod
@JsonPersist()
class CachedUsersNotifier extends _$CachedUsersNotifier {
  @override
  FutureOr<List<CachedUser>> build() async {
    debugPrint('CachedUsersNotifier: build started');

    // ストレージの準備を待機
    final storage = await ref.watch(offlineStorageProvider.future);
    debugPrint('CachedUsersNotifier: Storage received');

    // 永続化を設定（キャッシュは無期限）
    persist(
      storage,
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
    );
    debugPrint('CachedUsersNotifier: persist called');

    // ネットワーク状態を監視
    final networkStatus = ref.watch(networkStatusProvider);
    debugPrint('CachedUsersNotifier: Network status: $networkStatus');

    // Dart 3.0 switch式でネットワーク状態に応じた処理
    return switch (networkStatus) {
      NetworkStatus.online => await _fetchAndCacheUsers(),
      NetworkStatus.offline => _getFromCache(),
      NetworkStatus.checking => _getFromCache(),
    };
  }

  /// APIからユーザーを取得してキャッシュに保存
  Future<List<CachedUser>> _fetchAndCacheUsers() async {
    debugPrint('CachedUsersNotifier: Fetching users from API...');
    try {
      final dio = ref.read(dioProvider);
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/users');

      final List<dynamic> data = response.data;
      final now = DateTime.now();
      final List<CachedUser> users = [];

      for (var item in data) {
        users.add(CachedUser(
          id: item['id'] as int,
          name: item['name'] as String,
          email: item['email'] as String,
          cachedAt: now,
        ));
      }

      debugPrint('CachedUsersNotifier: Fetched ${users.length} users');
      return users;
    } catch (e) {
      debugPrint('CachedUsersNotifier: API error: $e');
      // APIエラー時はキャッシュから取得を試みる
      return _getFromCache();
    }
  }

  /// キャッシュからユーザーを取得
  List<CachedUser> _getFromCache() {
    debugPrint('CachedUsersNotifier: Getting from cache...');
    // persistによって自動的にキャッシュからデータが復元される
    // ここでは空リストを返すが、persistがキャッシュデータで上書きする
    // return state.valueOrNull ?? [];
    return state.value ?? [];
  }

  /// 手動でデータを更新
  Future<void> refresh() async {
    debugPrint('CachedUsersNotifier: Manual refresh requested');
    state = const AsyncLoading();

    final networkStatus = ref.read(networkStatusProvider);

    if (networkStatus.isOnline) {
      try {
        final users = await _fetchAndCacheUsers();
        state = AsyncData(users);
      } catch (e, st) {
        state = AsyncError(e, st);
      }
    } else {
      debugPrint('CachedUsersNotifier: Cannot refresh - offline');
      // オフライン時は現在のキャッシュを維持
      state = AsyncData(_getFromCache());
    }
  }

  /// キャッシュをクリア
  Future<void> clearCache() async {
    debugPrint('CachedUsersNotifier: Clearing cache');
    state = const AsyncData([]);
  }
}

/// キャッシュデータの状態を提供するプロバイダー
/// Dart 3.0のsealed classを活用した型安全な状態管理
@riverpod
CacheState<List<CachedUser>> userCacheState(Ref ref) {
  final asyncUsers = ref.watch(cachedUsersProvider);
  final networkStatus = ref.watch(networkStatusProvider);

  // Riverpod 3.0ではwhenは非推奨。switch式を使用
  return switch (asyncUsers) {
    AsyncLoading() => const LoadingData(),
    AsyncError(:final error, :final stackTrace) => ErrorData(error, stackTrace),
    AsyncData(:final value) => switch (networkStatus) {
        NetworkStatus.online => FreshData(value),
        NetworkStatus.offline when value.isNotEmpty =>
          CachedData(value, value.first.cachedAt),
        NetworkStatus.offline => const ErrorData('オフラインでキャッシュがありません'),
        NetworkStatus.checking when value.isNotEmpty =>
          CachedData(value, value.first.cachedAt),
        NetworkStatus.checking => const LoadingData(),
      },
  };
}
