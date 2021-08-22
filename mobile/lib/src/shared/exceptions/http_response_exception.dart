import 'package:projeto_karla/src/shared/services/http_response_model.dart';

class HttpResponseException implements Exception {
  HttpResponseModel response;
  HttpResponseException({
    required this.response,
  });
}
