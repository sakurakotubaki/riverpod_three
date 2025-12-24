import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cached_user.dart';
import 'cached_user_provider.dart';
import 'connectivity_provider.dart';
import 'network_status.dart';

/// オフラインキャッシュ対応のユーザーリスト画面
class CachedUserListView extends ConsumerWidget {
  const CachedUserListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus = ref.watch(networkStatusProvider);
    final cacheState = ref.watch(userCacheStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached Users'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // ネットワーク状態インジケーター
          _NetworkStatusIndicator(status: networkStatus),
          // 更新ボタン
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(cachedUsersProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ネットワーク状態バナー
          _NetworkStatusBanner(status: networkStatus),
          // ユーザーリスト
          Expanded(
            child: _buildContent(context, cacheState),
          ),
        ],
      ),
    );
  }

  /// Dart 3.0 switch式を使ったコンテンツビルダー
  Widget _buildContent(BuildContext context, CacheState<List<CachedUser>> cacheState) {
    return switch (cacheState) {
      LoadingData() => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('データを読み込み中...'),
            ],
          ),
        ),
      ErrorData(error: final error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('エラー: $error'),
            ],
          ),
        ),
      FreshData(data: final users) => _UserList(
          users: users,
          isCached: false,
        ),
      CachedData(data: final users, cachedAt: final cachedAt) => _UserList(
          users: users,
          isCached: true,
          cachedAt: cachedAt,
        ),
    };
  }
}

/// ネットワーク状態インジケーター
class _NetworkStatusIndicator extends StatelessWidget {
  final NetworkStatus status;

  const _NetworkStatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    // Dart 3.0 switch式でアイコンと色を決定
    final (icon, color) = switch (status) {
      NetworkStatus.online => (Icons.wifi, Colors.green),
      NetworkStatus.offline => (Icons.wifi_off, Colors.red),
      NetworkStatus.checking => (Icons.sync, Colors.orange),
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(icon, color: color),
    );
  }
}

/// ネットワーク状態バナー
class _NetworkStatusBanner extends StatelessWidget {
  final NetworkStatus status;

  const _NetworkStatusBanner({required this.status});

  @override
  Widget build(BuildContext context) {
    // オンライン時はバナーを表示しない
    if (status == NetworkStatus.online) {
      return const SizedBox.shrink();
    }

    final (backgroundColor, text) = switch (status) {
      NetworkStatus.offline => (Colors.orange.shade100, 'オフラインモード - キャッシュデータを表示中'),
      NetworkStatus.checking => (Colors.blue.shade100, '接続確認中...'),
      NetworkStatus.online => (Colors.transparent, ''),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: backgroundColor,
      child: Row(
        children: [
          Icon(
            status == NetworkStatus.offline ? Icons.cloud_off : Icons.sync,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

/// ユーザーリストウィジェット
class _UserList extends StatelessWidget {
  final List<CachedUser> users;
  final bool isCached;
  final DateTime? cachedAt;

  const _UserList({
    required this.users,
    required this.isCached,
    this.cachedAt,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('ユーザーがいません'),
          ],
        ),
      );
    }

    return Column(
      children: [
        // キャッシュ情報ヘッダー
        if (isCached && cachedAt != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.grey.shade200,
            child: Text(
              'キャッシュ日時: ${_formatDateTime(cachedAt!)}',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        // ユーザーリスト
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return _UserListTile(user: user, isCached: isCached);
            },
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day} '
        '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// ユーザーリストタイル
class _UserListTile extends StatelessWidget {
  final CachedUser user;
  final bool isCached;

  const _UserListTile({
    required this.user,
    required this.isCached,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isCached ? Colors.orange : Colors.blue,
        child: Text(
          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: isCached
          ? const Tooltip(
              message: 'キャッシュデータ',
              child: Icon(Icons.cached, color: Colors.orange),
            )
          : const Tooltip(
              message: '最新データ',
              child: Icon(Icons.cloud_done, color: Colors.green),
            ),
    );
  }
}
