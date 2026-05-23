import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:runway/core/routing/service/navigation_service.dart';

class NavigationServiceImplementation implements NavigationService {
  late GoRouter _router;

  @override
  GoRouter get router => _router;

  @override
  void init({
    required List<RouteBase> routes,
    required String initialLocation,
    Widget? errorWidget,
  }) {
    _router = GoRouter(
      initialLocation: initialLocation,
      routes: routes,
      errorBuilder: errorWidget != null
          ? (context, state) => errorWidget
          : null,
    );
  }

  @override
  Future<T?> push<T>({
    required String route,
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? arguments,
  }) {
    return router.push<T>(
      _buildPath(route: route, params: params, queryParams: queryParams),
      extra: arguments,
    );
  }

  @override
  void pushReplacement({
    required String route,
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? arguments,
  }) {
    router.pushReplacement(
      _buildPath(route: route, params: params, queryParams: queryParams),
      extra: arguments,
    );
  }

  @override
  void go({
    required String route,
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? arguments,
  }) {
    router.go(
      _buildPath(route: route, params: params, queryParams: queryParams),
      extra: arguments,
    );
  }

  @override
  void pop<T>([T? result]) {
    router.pop(result);
  }

  String _buildPath({
    required String route,
    Map<String, String>? params,
    Map<String, String>? queryParams,
  }) {
    String path = route;

    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        path += '/$value';
      });
    }

    if (queryParams != null && queryParams.isNotEmpty) {
      final query = queryParams.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');

      path += '?$query';
    }

    return path;
  }
}
