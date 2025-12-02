// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CounterNotifier)
const counterProvider = CounterNotifierProvider._();

final class CounterNotifierProvider
    extends $NotifierProvider<CounterNotifier, dynamic> {
  const CounterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counterNotifierHash();

  @$internal
  @override
  CounterNotifier create() => CounterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }
}

String _$counterNotifierHash() => r'd648b51b215210ed9fafede503ae23f79a12ac54';

abstract class _$CounterNotifier extends $Notifier<dynamic> {
  dynamic build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<dynamic, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<dynamic, dynamic>,
              dynamic,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
