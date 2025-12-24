// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ネットワーク接続状態を監視するプロバイダー
/// 定期的にネットワーク接続を確認し、状態を更新する

@ProviderFor(NetworkStatusNotifier)
const networkStatusProvider = NetworkStatusNotifierProvider._();

/// ネットワーク接続状態を監視するプロバイダー
/// 定期的にネットワーク接続を確認し、状態を更新する
final class NetworkStatusNotifierProvider
    extends $NotifierProvider<NetworkStatusNotifier, NetworkStatus> {
  /// ネットワーク接続状態を監視するプロバイダー
  /// 定期的にネットワーク接続を確認し、状態を更新する
  const NetworkStatusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkStatusNotifierHash();

  @$internal
  @override
  NetworkStatusNotifier create() => NetworkStatusNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkStatus>(value),
    );
  }
}

String _$networkStatusNotifierHash() =>
    r'afec6b27b6bd53ffb9492edab0f40107a0ff5f78';

/// ネットワーク接続状態を監視するプロバイダー
/// 定期的にネットワーク接続を確認し、状態を更新する

abstract class _$NetworkStatusNotifier extends $Notifier<NetworkStatus> {
  NetworkStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NetworkStatus, NetworkStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NetworkStatus, NetworkStatus>,
              NetworkStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
