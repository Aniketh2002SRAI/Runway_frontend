import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:runway/core/network/enums/http_request_type_enums.dart';
import 'package:runway/core/network/exceptions/api_exception.dart';
import 'package:runway/core/network/interceptor/auth_interceptor.dart';
import 'package:runway/core/network/interceptor/error_interceptor.dart';
import 'package:runway/core/network/model/api_config.dart';
import 'package:runway/core/network/model/api_request.dart';
import 'package:runway/core/network/model/refresh_config.dart';
import 'package:runway/core/network/service/api_abstract.dart';
import 'package:runway/core/network/service/token_store.dart';

class ApiRequestHandlerImpl extends ApiRequestHandlerAbstract {
  final Dio dio;
  final Dio refreshDio;
  final TokenStore tokenStore;
  final ApiConfig timeoutConfig;
  final RefreshConfig refreshConfig;
  final Future<void> Function()? onUnauthorized;

  ApiRequestHandlerImpl({
    required this.tokenStore,
    required this.timeoutConfig,
    this.onUnauthorized,
    required this.refreshConfig,
  }) : dio = Dio(
         BaseOptions(
           connectTimeout: timeoutConfig.connectTimeout,
           receiveTimeout: timeoutConfig.receiveTimeout,
           sendTimeout: timeoutConfig.sendTimeout,
         ),
       ),
       refreshDio = Dio(
         BaseOptions(
           connectTimeout: timeoutConfig.connectTimeout,
           receiveTimeout: timeoutConfig.receiveTimeout,
           sendTimeout: timeoutConfig.sendTimeout,
         ),
       ) {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        tokenStore: tokenStore,
        refreshDio: refreshDio,
        onUnauthorized: onUnauthorized,
        refreshConfig: refreshConfig,
      ),
    );
    dio.interceptors.add(ExceptionInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        logPrint: (obj) => print("📢 DIO LOG → $obj"),
      ),
    );
  }

  Map<String, dynamic> customHeaders = {};

  @override
  Future<Either<ApiException, Response>> request({
    required ApiRequest requestModel,
  }) async {
    try {
      final headers = _buildHeaders(requestModel);
      final body = await _buildBody(requestModel);
      final options = _buildOptions(headers, requestModel);

      final response = await _executeRequest(requestModel, body, options);

      return Right(response);
    } on DioException catch (e, st) {
      print("api core st $st");
      print("error $e");
      print("error Type ${(e.error as ApiException).errorType}");
      return Left(e.error as ApiException);
    }
  }

  Map<String, dynamic> _buildHeaders(ApiRequest requestModel) {
    final headers = {...customHeaders, ...?requestModel.headers};

    if (requestModel.files?.isNotEmpty == true) {
      headers.remove("Content-Type");
    }

    return headers;
  }

  Future<dynamic> _buildBody(ApiRequest requestModel) async {
    if (requestModel.files == null || requestModel.files!.isEmpty) {
      return requestModel.body ?? {};
    }

    final map = <String, dynamic>{};

    if (requestModel.body != null) {
      map.addAll(requestModel.body!);
    }

    for (final fileMap in requestModel.files!) {
      for (final entry in fileMap.entries) {
        final file = entry.value;

        if (file is MultipartFile) {
          map[entry.key] = file;
        } else {
          map[entry.key] = await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          );
        }
      }
    }

    return FormData.fromMap(map);
  }

  Options _buildOptions(Map<String, dynamic> headers, ApiRequest requestModel) {
    return Options(
      headers: headers,
      responseType: requestModel.responseType,
      extra: {"requireAccessToken": requestModel.requireAccessToken},
    );
  }

  Future<Response> _executeRequest(
    ApiRequest requestModel,
    dynamic body,
    Options options,
  ) {
    final params = {...?requestModel.queryParameters};
    final url = requestModel.url;

    switch (requestModel.httpRequestType) {
      case HttpRequestType.getRequest:
        return dio.get(url, options: options, queryParameters: params);

      case HttpRequestType.postRequest:
        return dio.post(
          url,
          data: body,
          options: options,
          queryParameters: params,
        );

      case HttpRequestType.putRequest:
        return dio.put(
          url,
          data: body,
          options: options,
          queryParameters: params,
        );

      case HttpRequestType.deleteRequest:
        return dio.delete(url, data: body, options: options);

      case HttpRequestType.patchRequest:
        return dio.patch(url, data: body, options: options);
    }
  }
}
