import 'dart:io';

import 'package:emma/domain/i_user_repository.dart';
import 'package:emma/domain/user_status.dart';
import 'package:emma/infrastructure/oidc_configuration.dart';
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
    late final Uri redirectUri;
    late final Uri? postLogoutRedirectUri;

    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      redirectUri = Uri.parse('org.opence.emma:/oauth2redirect');
      postLogoutRedirectUri = Uri.parse('org.opence.emma:/endsessionredirect');
    } else if (Platform.isLinux || Platform.isWindows) {
      redirectUri = Uri.parse('http://localhost:0');
      postLogoutRedirectUri = Uri.parse('http://localhost:0');
    } else {
      redirectUri = Uri();
      postLogoutRedirectUri = null;
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
  Future<void> login() async {
    await _manager.loginAuthorizationCodeFlow();
  }

  @override
  Future<void> logout() async {
    await _manager.logout();
  }

  Future<void> _init() async {
    await _manager.init();
    _logger.info("Initialized");
    _manager.userChanges().listen(_onUserChanged);
  }

  void _onUserChanged(OidcUser? user) {
    _logger.info("User: ${user?.claims}");
    batch(() {
      _status.value = switch (user) {
        null => UserStatus.unauthenticated,
        _ => UserStatus.authenticated
      };
      _name.value = switch (user) {
        null => "",
        _ => user.claims.getTyped("given_name"),
      };
    });
  }
}
