import 'package:openems/application/backend_api/backend_api_configuration.dart';
import 'package:openems/application/backend_api/swagger_generated_code/client_index.dart';
import 'package:openems/domain/i_user_repository.dart';
import 'package:openems/application/backend_api/backend_api_factory.dart';
import 'package:openems/infrastructure/oidc_configuration.dart';
import 'package:openems/infrastructure/oidc_user_repository.dart';
import 'package:openems/infrastructure/window_size_writer.dart';
import 'package:openems/ui/home/profile/version_info_view_model.dart';
import 'package:openems/ui/app_messenger.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:openems/ui/devices/add/add_consumer_view_model.dart';
import 'package:openems/ui/devices/add/add_electricity_meter_view_model.dart';
import 'package:openems/ui/devices/add/add_producer_view_model.dart';
import 'package:openems/ui/devices/add/integrations/development_view_model.dart';
import 'package:openems/ui/devices/add/integrations/shelly_view_model.dart';
import 'package:openems/ui/devices/add/select_integration_view_model.dart';
import 'package:openems/ui/devices/devices_view_model.dart';
import 'package:openems/ui/home/home_view_model.dart';
import 'package:openems/ui/user_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

Future<void> bootstrap() async {
  if (WindowSizeWriter.isSupported) {
    await WindowSizeWriter.setSize();
  }

  final di = GetIt.instance;

  // - user
  final oidcConfiguration = OidcConfiguration(
    baseUri: Uri.parse(const String.fromEnvironment("AUTH_URL")),
    clientId: "openems-app",
  );

  final oidcUserRepository = await OidcUserRepository.create(oidcConfiguration);
  di.registerSingleton<IUserRepository>(oidcUserRepository);

  // application
  // - backend api
  final backendApiConfiguration = BackendApiConfiguration(
    baseUrl: Uri.parse(const String.fromEnvironment("API_URL")),
  );

  di.registerLazySingleton(() => BackendApiFactory(
      configuration: backendApiConfiguration,
      userRepository: di<IUserRepository>()));

  di.registerFactory<BackendApi>(() => di<BackendApiFactory>().create());

  // ui
  // - commands
  Command.onError.listen((_) => AppMessenger.error());
  Command.onError
      .listen((error) => Logger("command.${error.debugLabel}").warning(
            "Error executing command.",
            error.error,
            error.stackTrace,
          ));

  // - user
  di.registerLazySingleton(() => UserViewModel(di<IUserRepository>()));
  di.registerLazySingleton(() => VersionInfoViewModel(api: di<BackendApi>()));

  // - devices
  di.registerFactory(() => DevicesViewModel(api: di<BackendApi>()));
  di.registerFactory(() => SelectIntegrationViewModel(api: di<BackendApi>()));
  di.registerFactory(() => AddConsumerViewModel(api: di<BackendApi>()));
  di.registerFactory(() => AddProducerViewModel(api: di<BackendApi>()));
  di.registerFactory(() => AddElectricityMeterViewModel(api: di<BackendApi>()));

  di.registerFactory(() => DevelopmentViewModel(api: di<BackendApi>()));
  di.registerFactory(() => ShellyViewModel(api: di<BackendApi>()));

  // - home
  di.registerFactory(() => HomeViewModel(api: di<BackendApi>()));
}
