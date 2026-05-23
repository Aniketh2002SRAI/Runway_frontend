import 'package:dio/dio.dart';
import 'package:runway/core/network/enums/http_request_type_enums.dart';

class ApiRequest {
  final String url;
  final HttpRequestType httpRequestType;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;
  final List<Map<String, dynamic>>? files;
  final bool? requireAccessToken;
  final ResponseType? responseType;
  final Map<String, dynamic>? headers;

  ApiRequest({
    required this.url,
    required this.httpRequestType,
    this.body,
    this.queryParameters,
    this.files,
    this.requireAccessToken = false,
    this.responseType,
    this.headers,
  });
}
