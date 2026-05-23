import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationService {
  GoRouter get router;

  void init({
    required List<RouteBase> routes,
    required String initialLocation,
    Widget? errorWidget,
  });

  Future<T?> push<T>({
    required String route,
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? arguments,
  });

  void pushReplacement({
    required String route,
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? arguments,
  });

  void go({
    required String route,
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? arguments,
  });

  void pop<T>([T? result]);
}
