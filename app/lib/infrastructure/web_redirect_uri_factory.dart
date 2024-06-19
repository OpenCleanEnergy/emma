abstract class WebRedirectUriFactory {
  static Uri getRedirectUri() {
    throw UnsupportedError(
        'This method is only supported on the web platform.');
  }
}
