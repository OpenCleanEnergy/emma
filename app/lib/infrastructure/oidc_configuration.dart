import 'package:openems/infrastructure/platform_impl/fallback_web_redirect_uri_factory.dart'
    if (dart.library.html) 'package:openems/infrastructure/platform_impl/html_web_redirect_uri_factory.dart';

class OidcConfiguration {
  const OidcConfiguration({
    required this.baseUri,
    required this.clientId,
  });

  final Uri baseUri;
  final String clientId;

  Uri getWebRedirectUri() {
    return WebRedirectUriFactoryImpl().getRedirectUri();
  }
}
