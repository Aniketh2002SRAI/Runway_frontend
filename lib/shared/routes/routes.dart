import 'package:go_router/go_router.dart';
import 'package:runway/features/splash/splash.dart';

class Routes {
  static const splash = '/';

  static List<RouteBase> routes = [
    GoRoute(path: splash, builder: (context, state) => Splash()),
  ];
}
