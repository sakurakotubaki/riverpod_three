// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// オフラインキャッシュ用のストレージプロバイダー

@ProviderFor(offlineStorage)
const offlineStorageProvider = OfflineStorageProvider._();

/// オフラインキャッシュ用のストレージプロバイダー

final class OfflineStorageProvider
    extends
        $FunctionalProvider<
          AsyncValue<JsonSqFliteStorage>,
          JsonSqFliteStorage,
          FutureOr<JsonSqFliteStorage>
        >
    with
        $FutureModifier<JsonSqFliteStorage>,
        $FutureProvider<JsonSqFliteStorage> {
  /// オフラインキャッシュ用のストレージプロバイダー
  const OfflineStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineStorageHash();

  @$internal
  @override
  $FutureProviderElement<JsonSqFliteStorage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JsonSqFliteStorage> create(Ref ref) {
    return offlineStorage(ref);
  }
}

String _$offlineStorageHash() => r'2304447ad66e5baf3fabc0cadf3c17f835d7c7ec';

/// オフラインキャッシュ対応のユーザープロバイダー
/// - オンライン時: APIからデータを取得してキャッシュに保存
/// - オフライン時: キャッシュからデータを読み込み

@ProviderFor(CachedUsersNotifier)
@JsonPersist()
const cachedUsersProvider = CachedUsersNotifierProvider._();

/// オフラインキャッシュ対応のユーザープロバイダー
/// - オンライン時: APIからデータを取得してキャッシュに保存
/// - オフライン時: キャッシュからデータを読み込み
@JsonPersist()
final class CachedUsersNotifierProvider
    extends $AsyncNotifierProvider<CachedUsersNotifier, List<CachedUser>> {
  /// オフラインキャッシュ対応のユーザープロバイダー
  /// - オンライン時: APIからデータを取得してキャッシュに保存
  /// - オフライン時: キャッシュからデータを読み込み
  const CachedUsersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cachedUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cachedUsersNotifierHash();

  @$internal
  @override
  CachedUsersNotifier create() => CachedUsersNotifier();
}

String _$cachedUsersNotifierHash() =>
    r'43c283d78d4877ef5747ebd01263970e0811e455';

/// オフラインキャッシュ対応のユーザープロバイダー
/// - オンライン時: APIからデータを取得してキャッシュに保存
/// - オフライン時: キャッシュからデータを読み込み

@JsonPersist()
abstract class _$CachedUsersNotifierBase
    extends $AsyncNotifier<List<CachedUser>> {
  FutureOr<List<CachedUser>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<CachedUser>>, List<CachedUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CachedUser>>, List<CachedUser>>,
              AsyncValue<List<CachedUser>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// キャッシュデータの状態を提供するプロバイダー
/// Dart 3.0のsealed classを活用した型安全な状態管理

@ProviderFor(userCacheState)
const userCacheStateProvider = UserCacheStateProvider._();

/// キャッシュデータの状態を提供するプロバイダー
/// Dart 3.0のsealed classを活用した型安全な状態管理

final class UserCacheStateProvider
    extends
        $FunctionalProvider<
          CacheState<List<CachedUser>>,
          CacheState<List<CachedUser>>,
          CacheState<List<CachedUser>>
        >
    with $Provider<CacheState<List<CachedUser>>> {
  /// キャッシュデータの状態を提供するプロバイダー
  /// Dart 3.0のsealed classを活用した型安全な状態管理
  const UserCacheStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCacheStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCacheStateHash();

  @$internal
  @override
  $ProviderElement<CacheState<List<CachedUser>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CacheState<List<CachedUser>> create(Ref ref) {
    return userCacheState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheState<List<CachedUser>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheState<List<CachedUser>>>(value),
    );
  }
}

String _$userCacheStateHash() => r'2729c1ba6fde8a103ca2740b751fd0a93b004f28';

// **************************************************************************
// JsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
abstract class _$CachedUsersNotifier extends _$CachedUsersNotifierBase {
  /// The default key used by [persist].
  String get key {
    const resolvedKey = "CachedUsersNotifier";
    return resolvedKey;
  }

  /// A variant of [persist], for JSON-specific encoding.
  ///
  /// You can override [key] to customize the key used for storage.
  PersistResult persist(
    FutureOr<Storage<String, String>> storage, {
    String? key,
    String Function(List<CachedUser> state)? encode,
    List<CachedUser> Function(String encoded)? decode,
    StorageOptions options = const StorageOptions(),
  }) {
    return NotifierPersistX(this).persist<String, String>(
      storage,
      key: key ?? this.key,
      encode: encode ?? $jsonCodex.encode,
      decode:
          decode ??
          (encoded) {
            final e = $jsonCodex.decode(encoded);
            return (e as List)
                .map((e) => CachedUser.fromJson(e as Map<String, Object?>))
                .toList();
          },
      options: options,
    );
  }
}
