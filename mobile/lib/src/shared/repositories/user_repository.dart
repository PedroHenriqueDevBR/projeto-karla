import 'dart:io';
import '../interfaces/user_store_interface.dart';
import '../interfaces/app_data_interface.dart';
import '../interfaces/client_http_interface.dart';
import '../services/http_response_model.dart';
import '../exceptions/http_response_exception.dart';
import '../exceptions/invalid_data_exception.dart';
import '../models/user_model.dart';

class UserRepository implements IUserStorage {
  IClientHTTP _client;
  IAppData _appData;

  UserRepository({required IClientHTTP client, required IAppData appData})
      : this._client = client,
        this._appData = appData;

  Future<bool> userIsLogged() async {
    try {
      String jwt = await _appData.getJWT();
      if (jwt.isNotEmpty) return true;
    } on InvalidDataException catch (_) {
      return false;
    }
    return false;
  }

  Future<bool> loginUser(UserModel user) async {
    final errors = _validToLoginOrErrors(user);
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'token/';
    try {
      final response = await _client.post(url, user.toLoginMap());
      if (response.statusCode == 200) {
        _appData.setJWT(response.data['access']);
        return true;
      }
      throw HttpResponseException(response: response);
    } on SocketException catch (error) {
      if (error.osError!.message.contains('Connection refused')) {
        return throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: 503,
            data: {},
            headers: {},
          ),
        );
      }
      return throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: 400,
          data: {},
          headers: {},
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _appData.setJWT('');
    } catch (error) {
      print('Logout error');
    }
  }

  Future<void> registerUser(UserModel user) async {
    final errors = _validToRegisterOrErrors(user);
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'v1/register';
    try {
      final response = await _client.post(url, user.toMap());
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpResponseException(response: response);
      }
      return;
    } on SocketException catch (error) {
      if (error.osError!.message.contains('Connection refused')) {
        throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: 503,
            data: {},
            headers: {},
          ),
        );
      }
      throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: 400,
          data: {},
          headers: {},
        ),
      );
    }
  }

  List<String> _validToLoginOrErrors(UserModel user) {
    List<String> errors = [];
    if (user.username.isEmpty)
      errors.add('username não ser vazio');
    else if (user.username.length < 5) errors.add('username deve ter pelo menos 5 caracteres');
    if (user.password.isEmpty)
      errors.add('senha não ser vazio');
    else if (user.password.length < 8) errors.add('senha deve ter pelo menos 8 caracteres');
    return errors;
  }

  List<String> _validToRegisterOrErrors(UserModel user) {
    List<String> errors = [];
    if (user.name.isEmpty)
      errors.add('nome não pode ser vazio');
    else if (user.name.length < 3) errors.add('nome deve possuir pelo menos 3 caracteres');
    if (user.username.isEmpty)
      errors.add('username não pode ser vazio');
    else if (user.username.length < 5) errors.add('username deve ter pelo menos 5 caracteres');
    if (user.password.isEmpty)
      errors.add('senha não pode ser vazio');
    else if (user.password.length < 8) errors.add('senha deve ter pelo menos 8 caracteres');
    return errors;
  }
}
