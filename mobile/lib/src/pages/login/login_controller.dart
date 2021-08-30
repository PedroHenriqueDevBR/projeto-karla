import 'dart:io';

import 'package:asuka/asuka.dart' as asuka;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/login/stores/login_store.dart';
import 'package:projeto_karla/src/shared/exceptions/http_response_exception.dart';
import 'package:projeto_karla/src/shared/exceptions/invalid_data_exception.dart';
import 'package:projeto_karla/src/shared/models/user_model.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';

class LoginController {
  UserRepository repository;
  PageController pageController = PageController(initialPage: 0);
  LoginStore store;

  final txtLogin = TextEditingController();
  final txtPassword = TextEditingController();

  LoginController({
    required this.repository,
    required this.store,
  });

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
      asuka.showSnackBar(asuka.AsukaSnackbar.message('Username ou senha incorreta'));
    } on InvalidDataException catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(error.errors.toString()));
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro - Servidor indisponível'));
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.message('Username ou senha incorreta'));
      }
    }
  }

  Future<void> registerUser(UserModel user) async {
    if (userIsValidToRegister(user)) {
      try {
        repository.registerUser(user);
      } on InvalidDataException catch (error) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert(error.errors.toString()));
      } on HttpResponseException catch (error) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro: ${error.response.statusCode}'));
      }
    }
  }

  bool userIsValidToRegister(UserModel user) {
    List<String> errors = [];
    if (user.name.length < 3) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('O nome precisa ter pelo menos 3 caracteres'));
      return false;
    } else if (user.username.length < 5) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('O username precisa ter pelo menos 5 caracteres'));
      return false;
    } else if (user.password.length < 8) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('A senha precisa ter pelo menos 8 caracteres'));
      return false;
    }
    return true;
  }

  void goRegisterUserPage() {
    pageController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.easeIn);
  }

  void goLoginPage() {
    pageController.previousPage(duration: Duration(milliseconds: 750), curve: Curves.easeIn);
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}
