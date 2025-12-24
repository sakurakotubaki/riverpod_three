// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureStorageRepositoryProvider)
const secureStorageRepositoryProviderProvider =
    SecureStorageRepositoryProviderProvider._();

final class SecureStorageRepositoryProviderProvider
    extends
        $FunctionalProvider<
          SecureStorageRepository,
          SecureStorageRepository,
          SecureStorageRepository
        >
    with $Provider<SecureStorageRepository> {
  const SecureStorageRepositoryProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageRepositoryProviderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageRepositoryProviderHash();

  @$internal
  @override
  $ProviderElement<SecureStorageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecureStorageRepository create(Ref ref) {
    return secureStorageRepositoryProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureStorageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureStorageRepository>(value),
    );
  }
}

String _$secureStorageRepositoryProviderHash() =>
    r'd9e524217e8a24700ddf5e9e66e6abe93e12605a';
