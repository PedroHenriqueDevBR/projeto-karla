import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import './client_http_interface.dart';
import './http_response_model.dart';

class DioClientService implements IClientHTTP {
  String _getBaseUrl(String path) => 'http://127.0.0.1:8000/api/$path';

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
    final uri = _getBaseUrl(url);
    try {
      Response response = await Dio().get(uri, options: Options(headers: headers));
      return HttpResponseModel(
        statusCode: response.statusCode ?? 500,
        data: response.data,
        headers: response.headers.map,
      );
    } catch (error) {
      print(error);
      throw HttpException('GET: execute error');
    }
  }

  @override
  Future<HttpResponseModel> post(String url, Map<String, dynamic> data, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response = await Dio().post(uri, data: data, options: Options(headers: headers));
      return HttpResponseModel(
        statusCode: response.statusCode ?? 500,
        data: response.data,
        headers: response.headers.map,
      );
    } catch (error) {
      print(error);
      throw HttpException('POST: Execute error');
    }
  }

  @override
  Future<HttpResponseModel> put(String url, Map<String, dynamic> data, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response = await Dio().put(uri, data: data, options: Options(headers: headers));
      return HttpResponseModel(
        statusCode: response.statusCode ?? 500,
        data: response.data,
        headers: response.headers.map,
      );
    } catch (error) {
      throw HttpException('PUT: Execute error');
    }
  }

  @override
  Future<HttpResponseModel> delete(String url, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response = await Dio().delete(uri, options: Options(headers: headers));
      return HttpResponseModel(
        statusCode: response.statusCode ?? 500,
        data: response.data,
        headers: response.headers.map,
      );
    } catch (error) {
      print(error);
      throw HttpException('DELETE: Execute error');
    }
  }
}
