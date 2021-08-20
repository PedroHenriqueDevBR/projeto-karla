import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import './client_http_interface.dart';
import './http_response_model.dart';

class HTTPClientService implements IClientHTTP {
  String _getBaseUrl(String path) => 'http://192.168.2.3:8000${path}';

  Map<String, String> _setAuthorization({String? key}) {
    Map<String, String> map = {};
    if (key != null) {
      map['Authorization'] = 'Bearer $key';
    }
    return map;
  }

  @override
  Future<HttpResponseModel> get(String url, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    Uri uri = Uri.parse(_getBaseUrl(url));
    try {
      http.Response response = await http.get(uri, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: json.decode(response.body),
        headers: response.headers,
      );
    } catch (error) {
      throw HttpException('GET: execute error');
    }
  }

  @override
  Future<HttpResponseModel> post(String url, Map<String, dynamic> data, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    Uri uri = Uri.parse(_getBaseUrl(url));
    try {
      http.Response response = await http.post(uri, body: data, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: json.decode(response.body),
        headers: response.headers,
      );
    } catch (error) {
      throw HttpException('POST: Execute error');
    }
  }

  @override
  Future<HttpResponseModel> put(String url, Map<String, dynamic> data, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    Uri uri = Uri.parse(_getBaseUrl(url));
    try {
      http.Response response = await http.put(uri, body: data, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: json.decode(response.body),
        headers: response.headers,
      );
    } catch (error) {
      throw HttpException('PUT: Execute error');
    }
  }

  @override
  Future<HttpResponseModel> delete(String url, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    Uri uri = Uri.parse(_getBaseUrl(url));
    try {
      http.Response response = await http.delete(uri, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: '',
        headers: response.headers,
      );
    } catch (error) {
      throw HttpException('DELETE: Execute error');
    }
  }
}
