import 'package:runway/core/network/enums/error_enums.dart';

class ApiException {
  ErrorType errorType;
  String? message;

  ApiException({required this.errorType, required this.message});
}
