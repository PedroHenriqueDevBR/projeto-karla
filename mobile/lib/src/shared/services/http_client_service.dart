import 'dart:convert';

import 'package:http/http.dart';
import 'package:projeto_karla/src/shared/exceptions/http_response_exception.dart';
import 'package:projeto_karla/src/shared/services/client_http_interface.dart';
import 'package:projeto_karla/src/shared/services/http_response_model.dart';
import 'package:http/http.dart' as http;

class HttpClientService implements IClientHTTP {
  Uri _getBaseUrl(String path) => Uri.parse('http://192.168.2.3:8000/api/$path');

  Map<String, String> _setAuthorization({String? key}) {
    Map<String, String> map = {};
    if (key != null) {
      map['Authorization'] = 'Bearer $key';
      map['Content-Type'] = 'application/json';
    }
    return map;
  }

  @override
  Future<HttpResponseModel> get(String url, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response = await http.get(uri, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body),
        headers: response.headers,
      );
    } catch (error) {
      print(error);
      throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: 500,
          data: {},
          headers: {},
        ),
      );
    }
  }

  @override
  Future<HttpResponseModel> post(String url, Map<String, dynamic> data, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response = await http.post(uri, body: data, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body),
        headers: response.headers,
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }

  @override
  Future<HttpResponseModel> put(String url, Map<String, dynamic> data, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      // Response response = await Dio().put(uri, data: data, options: Options(headers: headers));
      Response response = await http.put(uri, body: data, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body),
        headers: response.headers,
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }

  @override
  Future<HttpResponseModel> delete(String url, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      // Response response = await Dio().delete(uri, options: Options(headers: headers));
      Response response = await http.delete(uri, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: response.body,
        headers: response.headers,
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
