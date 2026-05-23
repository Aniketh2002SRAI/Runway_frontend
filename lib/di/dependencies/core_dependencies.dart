import 'package:runway/di/service_locator/service_locator.dart';
import 'package:runway/core/network/infrastructure/api_request_handler.dart';
import 'package:runway/core/network/infrastructure/token_store_impl.dart';
import 'package:runway/core/network/model/api_config.dart';
import 'package:runway/core/network/model/refresh_config.dart';
import 'package:runway/core/network/service/api_abstract.dart';
import 'package:runway/core/network/service/token_store.dart';
import 'package:runway/core/preference/implentation/preference_implementation.dart';
import 'package:runway/core/preference/service/preference_service.dart';
import 'package:runway/core/routing/service/navigation_service.dart';
import 'package:runway/core/routing/service_implementaion/navigation_service_impl.dart';
import 'package:runway/shared/routes/routes.dart';

Future<void> initCoreDependencies() async {
  await _initPreferenceDi();
  await _initApiDi();
  _initNavDi();
}

Future<void> _initPreferenceDi() async {
  final preference = PreferenceImpl();
  await preference.init();
  sl.registerSingleton<PreferenceService>(preference);
}

Future<void> _initApiDi() async {
  sl.registerLazySingleton<TokenStore>(
    () => TokenStoreImpl(sl<PreferenceService>()),
  );

  sl.registerLazySingleton<ApiRequestHandlerAbstract>(
    () => ApiRequestHandlerImpl(
      tokenStore: sl<TokenStore>(),
      timeoutConfig: ApiConfig.defaultConfig(),
      onUnauthorized: () async {},
      refreshConfig: RefreshConfig(refreshUrl: ''),
    ),
  );
}

void _initNavDi() {
  final nav = NavigationServiceImplementation();
  nav.init(routes: Routes.routes, initialLocation: Routes.splash);
  sl.registerLazySingleton<NavigationService>(() => nav);
}
