import 'package:flutter/material.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';

class RegisterUserFormWidget extends StatefulWidget {
  VoidCallback onBottomButtomPresset;

  RegisterUserFormWidget({
    required this.onBottomButtomPresset,
  });

  @override
  _RegisterUserFormWidgetState createState() => _RegisterUserFormWidgetState();
}

class _RegisterUserFormWidgetState extends State<RegisterUserFormWidget> {
  GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
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
              child: _formRegisterUser(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formRegisterUser() => Form(
        key: _formKeyRegister,
        child: Column(
          children: [
            Text(
              'Novo usuário',
              style: _textTheme.titleStyle,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite o seu nome',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Digite o seu nome de usuário',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite a sua senha',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Repetir a senha',
                hintText: 'Repita senha digitada acima',
              ),
            ),
            SizedBox(height: 16.0),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Cadastrar'),
                ),
              ),
            ]),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: widget.onBottomButtomPresset,
              child: Text(
                'Já possui cadastro?\nfazer login',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
