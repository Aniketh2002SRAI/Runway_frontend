import 'dart:io';
import 'package:dio/dio.dart';
import 'package:runway/core/network/enums/error_enums.dart';
import 'package:runway/core/network/exceptions/api_exception.dart';

class ExceptionInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String? message;

    ErrorType errorType = ErrorType.server;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorType = ErrorType.timedOut;
        break;

      case DioExceptionType.connectionError:
        if (err.error is SocketException) {
          errorType = ErrorType.noNetwork;
        }
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        message = _handleStatusCode(
          err.response?.statusCode,
          err.response?.data,
        );
        if (statusCode == 401) {
          errorType = ErrorType.unauthorized;
        }
        if (statusCode != null && statusCode >= 500) {
          errorType = ErrorType.server;
        } else {
          errorType = ErrorType.badResponse;
        }
        break;

      default:
        errorType = ErrorType.unexpected;
        message = err.message ?? message;
        break;
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        error: ApiException(errorType: errorType, message: message),
      ),
    );
  }

  String? _handleStatusCode(int? statusCode, dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      return (data['message'] ?? data['error'] ?? data['detail'] ?? null)
          .toString()
          .trim();
    }

    if (data is String) {
      final value = data.trim();

      if (value.contains("<html") || value.contains("<!DOCTYPE")) {
        return null;
      }

      if (value.length > 200) {
        return null;
      }

      return value.isNotEmpty ? value : null;
    }

    return null;
  }
}
