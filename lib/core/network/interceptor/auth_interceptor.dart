import 'dart:async';
import 'package:dio/dio.dart';
import 'package:runway/core/network/model/refresh_config.dart';
import 'package:runway/core/network/service/token_store.dart';

typedef UnauthorizedCallback = Future<void> Function();

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final Dio refreshDio;
  final TokenStore tokenStore;
  final RefreshConfig refreshConfig;
  final UnauthorizedCallback? onUnauthorized;

  Completer<void>? _refreshCompleter;
  bool _isHandlingUnauthorized = false;

  AuthInterceptor({
    required this.dio,
    required this.refreshDio,
    required this.tokenStore,
    this.onUnauthorized,
    required this.refreshConfig,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requireToken = options.extra["requireAccessToken"] == true;

    if (requireToken) {
      final token = await tokenStore.getAccessToken();

      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    final requireToken = requestOptions.extra["requireAccessToken"] == true;

    if (requestOptions.extra["isRetry"] == true) {
      return handler.next(err);
    }

    if (err.response?.statusCode == 401 && requireToken) {
      try {
        if (_refreshCompleter != null) {
          await _refreshCompleter!.future;
        } else {
          _refreshCompleter = Completer();

          await _refreshToken();

          _refreshCompleter!.complete();
          _refreshCompleter = null;
        }

        final newToken = await tokenStore.getAccessToken();

        if (newToken != null) {
          requestOptions.headers["Authorization"] = "Bearer $newToken";
        }

        requestOptions.extra["isRetry"] = true;

        final response = await dio.fetch(requestOptions);

        return handler.resolve(response);
      } catch (e) {
        if (_refreshCompleter?.isCompleted == false) {
          _refreshCompleter?.completeError(e);
        }

        _refreshCompleter = null;

        await tokenStore.clear();

        if (!_isHandlingUnauthorized) {
          _isHandlingUnauthorized = true;

          try {
            await onUnauthorized?.call();
          } finally {
            _isHandlingUnauthorized = false;
          }
        }

        return handler.next(err);
      }
    }

    handler.next(err);
  }

  Future<void> _refreshToken() async {
    final refreshToken = await tokenStore.getRefreshToken();

    if (refreshToken == null) {
      throw Exception("No refresh token");
    }

    final body = {
      "refresh_token": refreshToken,
      ...?refreshConfig.refreshExtraBody,
    };

    final response = await refreshDio.post(
      refreshConfig.refreshUrl,

      data: body,
      options: Options(headers: refreshConfig.refreshHeaders),
    );

    final data = response.data['data'];

    final newAccess = data["access_token"];
    final newRefresh = data["refresh_token"];

    await tokenStore.saveTokens(newAccess, newRefresh);
  }
}
