import 'package:flutter/material.dart';

import 'package:projeto_karla/src/shared/core/app_text_theme.dart';

class LoginFormWidget extends StatefulWidget {
  VoidCallback onConfirmButtonPresset;
  VoidCallback onBottomButtomPresset;
  TextEditingController txtLogin;
  TextEditingController txtPassword;

  LoginFormWidget({
    Key? key,
    required this.onConfirmButtonPresset,
    required this.onBottomButtomPresset,
    required this.txtLogin,
    required this.txtPassword,
  }) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  AppTextTheme _textTheme = AppTextTheme();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: _formLogin(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLogin() => Form(
        key: _formKeyLogin,
        child: Column(
          children: [
            Text(
              'Login',
              style: _textTheme.titleStyle,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: widget.txtLogin,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Digite o seu nome de usuário',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: widget.txtPassword,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite a sua senha',
              ),
            ),
            SizedBox(height: 16.0),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onConfirmButtonPresset,
                  child: Text('Entrar'),
                ),
              ),
            ]),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: widget.onBottomButtomPresset,
              child: Text(
                'Ainda não possui cadastro?\nClique aqui e cadastre-se',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
