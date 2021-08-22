import 'dart:io';

import 'package:projeto_karla/src/shared/exceptions/http_response_exception.dart';

import '../exceptions/invalid_data_exception.dart';
import '../models/user_model.dart';
import '../services/client_http_interface.dart';

class UserRepository {
  IClientHTTP _client;

  UserRepository({required IClientHTTP client}) : this._client = client;

  Future<String> loginAndResponseJWTKey(UserModel user) async {
    final errors = _validToLoginOrErrors(user);
    if (errors.isEmpty) {
      String url = 'token/';
      try {
        final response = await _client.post(url, user.toMap());
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return response.data['access'];
        }
        throw HttpException('Status: ${response.statusCode}');
      } catch (error) {
        throw error;
      }
    }
    throw InvalidDataException(errors: errors);
  }

  Future<bool> registerUser(UserModel user) async {
    List<String> errors = _validToRegisterOrErrors(user);
    if (errors.isEmpty) {
      String url = 'v1/register';
      try {
        final response = await _client.post(url, user.toMap());
        if (response.statusCode >= 200 && response.statusCode < 300) return true;
        throw HttpResponseException(response: response);
      } catch (error) {
        throw error;
      }
    }
    throw InvalidDataException(errors: errors);
  }

  List<String> _validToLoginOrErrors(UserModel user) {
    List<String> errors = [];
    if (user.username.isEmpty) {
      errors.add('username não ser vazio');
    } else {
      if (user.username.length < 5) errors.add('username deve ter pelo menos 5 caracteres');
    }
    if (user.password.isEmpty) {
      errors.add('senha não ser vazio');
    } else {
      if (user.password.length < 8) errors.add('senha deve ter pelo menos 8 caracteres');
    }
    return errors;
  }

  List<String> _validToRegisterOrErrors(UserModel user) {
    List<String> errors = [];
    if (user.name.isEmpty) {
      errors.add('nome não pode ser vazio');
    } else {
      if (user.name.length < 3) errors.add('nome deve possuir pelo menos 3 caracteres');
    }
    if (user.username.isEmpty) {
      errors.add('username não pode ser vazio');
    } else {
      if (user.username.length < 5) errors.add('username deve ter pelo menos 5 caracteres');
    }
    if (user.password.isEmpty) {
      errors.add('senha não pode ser vazio');
    } else {
      if (user.password.length < 8) errors.add('senha deve ter pelo menos 8 caracteres');
    }
    return errors;
  }
}
