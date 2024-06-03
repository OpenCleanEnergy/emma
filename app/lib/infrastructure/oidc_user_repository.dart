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
    final redirectUri = switch (Platform.operatingSystem) {
      Platform.android || Platform.iOS || Platform.macOS => Uri.parse('org.opence.emma:/oauth2redirect'),
      Platform.linux || Platform.windows => Uri.parse('http://localhost:0'),
      _ => Uri()
    };

    final postLogoutRedirectUri = switch (Platform.operatingSystem) {
      Platform.android || Platform.iOS || Platform.macOS => Uri.parse('org.opence.emma:/endsessionredirect'),
      Platform.linux || Platform.windows => Uri.parse('http://localhost:0'),
      _ => null
    };

    _manager = OidcUserManager.lazy(
          discoveryDocumentUri: OidcUtils.getOpenIdConfigWellKnownUri(
            configuration.baseUri,
          ),
          clientCredentials:
              OidcClientAuthentication.none(clientId: configuration.clientId),
          store: OidcDefaultStore(),
          settings: OidcUserManagerSettings(
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
