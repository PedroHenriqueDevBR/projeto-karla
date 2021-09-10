import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/exceptions/http_response_exception.dart';
import '../../../shared/exceptions/invalid_data_exception.dart';
import '../../../shared/interfaces/user_store_interface.dart';
import '../../../shared/models/user_model.dart';

part 'login_store.g.dart';

class LoginStore extends _LoginStore with _$LoginStore {
  LoginStore({required IUserStorage repository}) {
    super.repository = repository;
  }
}

abstract class _LoginStore with Store {
  late IUserStorage repository;

  @observable
  String txtLogin = '';

  @observable
  String txtPassword = '';

  @observable
  bool hidePassword = true;

  @observable
  bool isLoading = false;

  @action
  void setLogin(value) => txtLogin = value;

  @action
  void setPassword(value) => txtPassword = value;

  @action
  void toggleShowPasswrd() => hidePassword = !hidePassword;

  @action
  void setLoading(bool value) => isLoading = value;

  Future<void> loginUser({required BuildContext context}) async {
    setLoading(true);
    UserModel user = UserModel(name: '', username: txtLogin, password: txtPassword);
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
      } else if (error.response.statusCode == 415) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('415 - Erro no servidor'));
      } else {
        print(error.response.statusCode);
        asuka.showSnackBar(asuka.AsukaSnackbar.message('Username ou senha incorreto'));
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> verifyLoggedUser(BuildContext context) async {
    setLoading(true);
    try {
      bool response = await repository.userIsLogged();
      if (response) {
        goToHomePage(context);
      }
    } on InvalidDataException catch (_) {
      print('Usuário não logado');
    } finally {
      setLoading(false);
    }
  }

  @computed
  bool get formIsValid => txtLogin.length >= 5 && txtPassword.length >= 8;

  void goRegisterUserPage(BuildContext context) {
    Navigator.pushNamed(context, 'register_user');
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}
