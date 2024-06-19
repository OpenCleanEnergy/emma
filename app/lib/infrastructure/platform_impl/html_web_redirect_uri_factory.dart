import 'package:emma/infrastructure/web_redirect_uri_factory.dart';
import 'package:web/web.dart';

class WebRedirectUriFactoryImpl extends WebRedirectUriFactory {
  @override
  Uri getRedirectUri() {
    final origin = Uri.parse(_getOrigin());
    final href = _getBaseHref();

    return origin.replace(pathSegments: [
      ...origin.pathSegments,
      if (href != null) href,
      'oidc',
      'redirect.html'
    ]);
  }

  static String _getOrigin() {
    return _trim(window.location.origin);
  }

  static String? _getBaseHref() {
    final baseTag = document.querySelector('base');
    final href = baseTag?.getAttribute('href');
    return href != null ? _trim(href) : null;
  }

  static String _trim(String path) {
    var trimmed = path;
    if (trimmed.startsWith('/')) {
      trimmed = trimmed.substring(1);
    }

    if (trimmed.endsWith('/')) {
      trimmed = trimmed.substring(0, trimmed.length - 1);
    }

    return trimmed;
  }
}
