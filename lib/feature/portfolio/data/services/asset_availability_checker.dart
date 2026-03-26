import 'package:flutter/services.dart';

/// Checks whether optional portfolio assets are bundled.
abstract class AssetAvailabilityChecker {
  /// Returns `true` when the asset exists in the bundle manifest.
  Future<bool> exists(String assetPath);
}

/// Reads the Flutter asset manifest to resolve optional files.
class BundleAssetAvailabilityChecker implements AssetAvailabilityChecker {
  /// Creates an asset checker.
  const BundleAssetAvailabilityChecker();

  @override
  Future<bool> exists(String assetPath) async {
    if (assetPath.isEmpty) {
      return false;
    }

    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);

      return manifest.listAssets().contains(assetPath);
    } catch (_) {
      return false;
    }
  }
}
