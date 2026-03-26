import 'package:url_launcher/url_launcher.dart';

/// Launches external portfolio links.
abstract class PortfolioLinkLauncher {
  /// Opens the provided URL.
  Future<bool> openExternal(String url);
}

/// Default launcher backed by `url_launcher`.
class UrlLauncherService implements PortfolioLinkLauncher {
  /// Creates a launcher service.
  const UrlLauncherService();

  @override
  Future<bool> openExternal(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) {
      return false;
    }

    return launchUrl(uri);
  }
}
