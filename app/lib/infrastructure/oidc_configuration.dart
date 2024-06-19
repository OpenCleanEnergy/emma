class OidcConfiguration {
  const OidcConfiguration({
    required this.baseUri,
    required this.clientId,
    required this.webRedirectUri,
  });

  final Uri baseUri;
  final String clientId;
  final Uri? webRedirectUri;
}
