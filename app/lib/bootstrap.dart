import 'package:emma/application/backend_api/backend_api_configuration.dart';
import 'package:emma/application/backend_api/swagger_generated_code/client_index.dart';
import 'package:emma/application/user_service.dart';
import 'package:emma/domain/i_user_repository.dart';
import 'package:emma/infrastructure/app_info.dart';
import 'package:emma/application/backend_api/backend_api_factory.dart';
import 'package:emma/infrastructure/oidc_configuration.dart';
import 'package:emma/infrastructure/oidc_user_repository.dart';
import 'package:emma/infrastructure/window_size_writer.dart';
import 'package:emma/ui/app_messenger.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:emma/ui/devices/add/add_consumer_view_model.dart';
import 'package:emma/ui/devices/add/add_electricity_meter_view_model.dart';
import 'package:emma/ui/devices/add/add_producer_view_model.dart';
import 'package:emma/ui/devices/add/integrations/shelly_view_model.dart';
import 'package:emma/ui/devices/add/select_integration_view_model.dart';
import 'package:emma/ui/devices/devices_view_model.dart';
import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/user_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

Future<void> bootstrap() async {
  if (WindowSizeWriter.isSupported) {
    await WindowSizeWriter.setSize();
  }

  final di = GetIt.instance;

  // infrastructure
  final appInfo = await AppInfo.create();
  di.registerSingleton(appInfo);

  // - user
  final oidcConfiguration = OidcConfiguration(
      baseUri: Uri.parse("http://localhost:5001/realms/emma"),
      clientId: "emma_app");

  final oidcUserRepository = await OidcUserRepository.create(oidcConfiguration);
  di.registerSingleton<IUserRepository>(oidcUserRepository);

  // application
  // - backend api
  final backendApiConfiguration =
      BackendApiConfiguration(baseUrl: Uri.parse("http://localhost:5000"));
  di.registerLazySingleton(() => BackendApiFactory(
      configuration: backendApiConfiguration,
      userRepository: di<IUserRepository>()));

  di.registerFactory<BackendApi>(() => di<BackendApiFactory>().create());

  // ui
  // - commands
  Command.onError.listen((error) => AppMessenger.error());
  Command.onError.listen(
      (error) => Logger("command").warning("Error executing command.", error));

  // - user
  di.registerLazySingleton(() => UserService(di<IUserRepository>()));
  di.registerLazySingleton(() => UserViewModel(di<UserService>()));

  // - devices
  di.registerFactory(() => DevicesViewModel(api: di<BackendApi>()));
  di.registerFactory(() => SelectIntegrationViewModel(api: di<BackendApi>()));
  di.registerFactory(() => AddConsumerViewModel(api: di<BackendApi>()));
  di.registerFactory(() => AddProducerViewModel(api: di<BackendApi>()));
  di.registerFactory(() => AddElectricityMeterViewModel(api: di<BackendApi>()));

  di.registerFactory(() => ShellyViewModel(api: di<BackendApi>()));

  // - home
  di.registerFactory(() => HomeViewModel(api: di<BackendApi>()));
}
