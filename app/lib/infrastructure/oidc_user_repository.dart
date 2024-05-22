import 'package:emma/domain/i_user_repository.dart';
import 'package:emma/domain/user_status.dart';
import 'package:emma/infrastructure/oidc_configuration.dart';
import 'package:logging/logging.dart';
import 'package:oidc/oidc.dart';
import 'package:oidc_default_store/oidc_default_store.dart';
import 'package:signals/signals.dart';

class OidcUserRepository implements IUserRepository {
  final _logger = Logger("OidcUserRepository");
  final OidcUserManager _manager;
  final Signal<UserStatus> _status = signal(UserStatus.unknown);

  OidcUserRepository._(OidcConfiguration configuration)
      : _manager = OidcUserManager.lazy(
          discoveryDocumentUri: OidcUtils.getOpenIdConfigWellKnownUri(
            configuration.baseUri,
          ),
          clientCredentials:
              OidcClientAuthentication.none(clientId: configuration.clientId),
          store: OidcDefaultStore(),
          settings: OidcUserManagerSettings(
            redirectUri: Uri.parse('http://localhost:0'),
            postLogoutRedirectUri: Uri.parse('http://localhost:0'),
          ),
        );

  static Future<OidcUserRepository> create(
      OidcConfiguration configuration) async {
    final repository = OidcUserRepository._(configuration);
    await repository._init();
    return repository;
  }

  @override
  ReadonlySignal<UserStatus> get status => _status;

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

    _status.value = switch (user) {
      null => UserStatus.unauthenticated,
      _ => UserStatus.authenticated
    };
  }
}
