import 'package:openems/infrastructure/web_redirect_uri_factory.dart';

class WebRedirectUriFactoryImpl extends WebRedirectUriFactory {
  @override
  Uri getRedirectUri() {
    throw UnsupportedError(
        'This method is only supported on the web platform.');
  }
}
