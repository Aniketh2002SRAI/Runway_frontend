import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:runway/core/network/exceptions/api_exception.dart';
import 'package:runway/core/network/model/api_request.dart';

abstract class ApiRequestHandlerAbstract {
  Future<Either<ApiException, Response>> request({
    required ApiRequest requestModel,
  });
}
