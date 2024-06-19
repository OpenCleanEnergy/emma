import 'package:emma/infrastructure/web_redirect_uri_factory.dart'
    if (dart.library.html) 'package:emma/infrastructure/platform_impl/html_web_redirect_uri_factory.dart'
    if (dart.library.io) 'package:emma/infrastructure/platform_impl/mobile_web_redirect_uri_factory.dart';

class OidcConfiguration {
  const OidcConfiguration({
    required this.baseUri,
    required this.clientId,
  });

  final Uri baseUri;
  final String clientId;

  Uri getWebRedirectUri() {
    return WebRedirectUriFactory.getRedirectUri();
  }
}
