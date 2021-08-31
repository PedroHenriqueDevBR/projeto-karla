// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterUserStore on _RegisterUserStore, Store {
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_RegisterUserStore.formIsValid'))
          .value;

  final _$txtNameAtom = Atom(name: '_RegisterUserStore.txtName');

  @override
  String get txtName {
    _$txtNameAtom.reportRead();
    return super.txtName;
  }

  @override
  set txtName(String value) {
    _$txtNameAtom.reportWrite(value, super.txtName, () {
      super.txtName = value;
    });
  }

  final _$txtUsernameAtom = Atom(name: '_RegisterUserStore.txtUsername');

  @override
  String get txtUsername {
    _$txtUsernameAtom.reportRead();
    return super.txtUsername;
  }

  @override
  set txtUsername(String value) {
    _$txtUsernameAtom.reportWrite(value, super.txtUsername, () {
      super.txtUsername = value;
    });
  }

  final _$txtPasswordAtom = Atom(name: '_RegisterUserStore.txtPassword');

  @override
  String get txtPassword {
    _$txtPasswordAtom.reportRead();
    return super.txtPassword;
  }

  @override
  set txtPassword(String value) {
    _$txtPasswordAtom.reportWrite(value, super.txtPassword, () {
      super.txtPassword = value;
    });
  }

  final _$txtRepeatPasswordAtom =
      Atom(name: '_RegisterUserStore.txtRepeatPassword');

  @override
  String get txtRepeatPassword {
    _$txtRepeatPasswordAtom.reportRead();
    return super.txtRepeatPassword;
  }

  @override
  set txtRepeatPassword(String value) {
    _$txtRepeatPasswordAtom.reportWrite(value, super.txtRepeatPassword, () {
      super.txtRepeatPassword = value;
    });
  }

  final _$hidePasswordAtom = Atom(name: '_RegisterUserStore.hidePassword');

  @override
  bool get hidePassword {
    _$hidePasswordAtom.reportRead();
    return super.hidePassword;
  }

  @override
  set hidePassword(bool value) {
    _$hidePasswordAtom.reportWrite(value, super.hidePassword, () {
      super.hidePassword = value;
    });
  }

  final _$hiderepeatPasswordAtom =
      Atom(name: '_RegisterUserStore.hiderepeatPassword');

  @override
  bool get hiderepeatPassword {
    _$hiderepeatPasswordAtom.reportRead();
    return super.hiderepeatPassword;
  }

  @override
  set hiderepeatPassword(bool value) {
    _$hiderepeatPasswordAtom.reportWrite(value, super.hiderepeatPassword, () {
      super.hiderepeatPassword = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_RegisterUserStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_RegisterUserStoreActionController =
      ActionController(name: '_RegisterUserStore');

  @override
  void setName(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsername(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRepeatPassword(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setRepeatPassword');
    try {
      return super.setRepeatPassword(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleRepeatShowPasswrd() {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.toggleRepeatShowPasswrd');
    try {
      return super.toggleRepeatShowPasswrd();
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
txtName: ${txtName},
txtUsername: ${txtUsername},
txtPassword: ${txtPassword},
txtRepeatPassword: ${txtRepeatPassword},
hidePassword: ${hidePassword},
hiderepeatPassword: ${hiderepeatPassword},
isLoading: ${isLoading},
formIsValid: ${formIsValid}
    ''';
  }
}
