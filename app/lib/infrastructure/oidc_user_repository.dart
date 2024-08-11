import 'dart:io';

import 'package:emma/domain/i_user_repository.dart';
import 'package:emma/domain/user_status.dart';
import 'package:emma/infrastructure/oidc_configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:oidc/oidc.dart';
import 'package:oidc_default_store/oidc_default_store.dart';
import 'package:signals/signals.dart';

class OidcUserRepository implements IUserRepository {
  final _logger = Logger("OidcUserRepository");
  late final OidcUserManager _manager;
  final Signal<UserStatus> _status = signal(UserStatus.unknown);
  final Signal<String> _name = signal("");

  OidcUserRepository._(OidcConfiguration configuration) {
    Uri redirectUri = Uri();
    Uri? postLogoutRedirectUri;
    Uri? frontChannelLogoutUri;

    if (kIsWeb) {
      redirectUri = configuration.getWebRedirectUri();
      postLogoutRedirectUri = redirectUri;
      frontChannelLogoutUri = redirectUri.replace(queryParameters: {
        ...redirectUri.queryParameters,
        'requestType': 'front-channel-logout'
      });
    } else if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      redirectUri = Uri.parse('org.opencleanenergy.openems:/oauth2redirect');
      postLogoutRedirectUri =
          Uri.parse('org.opencleanenergy.openems:/endsessionredirect');
    } else if (Platform.isLinux || Platform.isWindows) {
      redirectUri = Uri.parse('http://localhost:0');
      postLogoutRedirectUri = Uri.parse('http://localhost:0');
    }

    _manager = OidcUserManager.lazy(
      discoveryDocumentUri: OidcUtils.getOpenIdConfigWellKnownUri(
        configuration.baseUri,
      ),
      clientCredentials:
          OidcClientAuthentication.none(clientId: configuration.clientId),
      store: OidcDefaultStore(),
      settings: OidcUserManagerSettings(
        scope: ['openid', 'profile', 'offline_access'],
        redirectUri: redirectUri,
        postLogoutRedirectUri: postLogoutRedirectUri,
        frontChannelLogoutUri: frontChannelLogoutUri,
      ),
    );
  }

  static Future<OidcUserRepository> create(
      OidcConfiguration configuration) async {
    final repository = OidcUserRepository._(configuration);
    await repository._init();
    return repository;
  }

  @override
  ReadonlySignal<UserStatus> get status => _status;

  @override
  ReadonlySignal<String> get name => _name;

  @override
  String? get accessToken => _manager.currentUser?.token.accessToken;

  @override
  Future<void> register() async {
    final endpointSegmentsCopy = [
      ..._manager.discoveryDocument.authorizationEndpoint!.pathSegments
    ];
    endpointSegmentsCopy[endpointSegmentsCopy.length - 1] = "registrations";

    final registrationEndpoint = _manager
        .discoveryDocument.authorizationEndpoint!
        .replace(pathSegments: endpointSegmentsCopy);

    await _manager.loginAuthorizationCodeFlow(
      discoveryDocumentOverride: _manager.discoveryDocument
          .copyWith(authorizationEndpoint: registrationEndpoint),
    );
  }

  @override
  Future<void> login() async {
    await _manager.loginAuthorizationCodeFlow();
  }

  @override
  Future<void> logout() async {
    await _manager.logout();
  }

  @override
  Future<void> refreshAccessTokenIfAboutToExpire(Duration tolerance) async {
    final isAboutToExpire = _manager.currentUser?.token
        .isAccessTokenAboutToExpire(tolerance: tolerance);

    if (isAboutToExpire ?? false) {
      await _manager.refreshToken();
    }
  }

  Future<void> _init() async {
    await _manager.init();
    _logger.info("Initialized");
    _manager.userChanges().listen(_onUserChanged);
  }

  void _onUserChanged(OidcUser? oidcUser) {
    final name = oidcUser?.claims.getTyped<String?>("given_name") ?? "";
    final status = switch (oidcUser) {
      null => UserStatus.unauthenticated,
      _ => UserStatus.authenticated
    };

    _logger.info("user changed: ${{"name": name, "status": status}}");

    batch(() {
      _name.value = name;
      _status.value = status;
    });
  }
}
