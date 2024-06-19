abstract class WebRedirectUriFactory {
  Uri getRedirectUri() {
    throw UnsupportedError(
        'This method is only supported on the web platform.');
  }
}
