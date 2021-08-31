import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:projeto_karla/src/shared/exceptions/http_response_exception.dart';
import 'package:projeto_karla/src/shared/exceptions/invalid_data_exception.dart';
import 'package:projeto_karla/src/shared/models/user_model.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';

class LoginController {
  UserRepository repository;
  final txtLogin = TextEditingController();
  final txtPassword = TextEditingController();

  LoginController({required this.repository});

  Future<void> loginUser({
    required BuildContext context,
  }) async {
    UserModel user = UserModel(name: '', username: txtLogin.text, password: txtPassword.text);
    try {
      bool logged = await repository.loginUser(user);
      if (logged) {
        goToHomePage(context);
        return;
      }
      asuka.showSnackBar(asuka.AsukaSnackbar.message('Username ou senha incorreto'));
    } on InvalidDataException catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(error.errors.toString()));
    } on HttpResponseException catch (error) {
      if (error.response.statusCode == 503) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro 503 - Servidor indisponível'));
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.message('Username ou senha incorreto'));
      }
    }
  }

  void goRegisterUserPage(BuildContext context) {
    Navigator.pushNamed(context, 'register_user');
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}
