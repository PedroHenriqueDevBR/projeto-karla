import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_karla/src/shared/exceptions/http_response_exception.dart';
import 'package:projeto_karla/src/shared/exceptions/invalid_data_exception.dart';
import 'package:projeto_karla/src/shared/models/user_model.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'register_user_store.g.dart';

class RegisterUserStore extends _RegisterUserStore with _$RegisterUserStore {
  RegisterUserStore({required UserRepository repository}) {
    super.repository = repository;
  }
}

abstract class _RegisterUserStore with Store {
  late UserRepository repository;

  @observable
  String txtName = '';

  @observable
  String txtUsername = '';

  @observable
  String txtPassword = '';

  @observable
  String txtRepeatPassword = '';

  @action
  void setName(String value) => txtName = value;

  @action
  void setUsername(String value) => txtUsername = value;

  @action
  void setPassword(String value) => txtPassword = value;

  @action
  void setRepeatPassword(String value) => txtRepeatPassword = value;

  Future<void> onSave(BuildContext context) async {
    if (userIsValidToRegister()) {
      final user = UserModel(
        name: txtName,
        username: txtUsername,
        password: txtPassword,
      );
      try {
        await repository.registerUser(user);
        asuka.showSnackBar(asuka.AsukaSnackbar.success('Usuário registrado com sucesso!'));
        Navigator.pop(context);
      } on InvalidDataException catch (error) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert(error.errors.toString()));
      } on HttpResponseException catch (error) {
        if (error.response.statusCode == 503) {
          asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro 503 - Servidor indisponível'));
        } else {
          asuka.showSnackBar(asuka.AsukaSnackbar.message('Username já registrado'));
        }
      }
    }
  }

  bool userIsValidToRegister() {
    List<String> errors = [];
    if (txtName.length < 3) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('O nome precisa ter pelo menos 3 caracteres'));
      return false;
    } else if (txtUsername.length < 5) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('O username precisa ter pelo menos 5 caracteres'));
      return false;
    } else if (txtPassword.length < 8) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('A senha precisa ter pelo menos 8 caracteres'));
      return false;
    }
    return true;
  }

  bool get formIsValid {
    return txtName.length >= 3 &&
        txtUsername.length >= 5 &&
        txtPassword.length >= 8 &&
        txtRepeatPassword == txtPassword;
  }
}
