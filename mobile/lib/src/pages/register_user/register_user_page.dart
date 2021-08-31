import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_karla/src/pages/register_user/stores/register_user_store.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:projeto_karla/src/shared/services/app_preferences_service.dart';
import 'package:projeto_karla/src/shared/services/http_client_service.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
  AppTextTheme _textTheme = AppTextTheme();
  RegisterUserStore store = RegisterUserStore(
    repository: UserRepository(
      client: HttpClientService(),
      appData: AppPreferenceService(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Theme.of(context).accentColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
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
              ),
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
              onChanged: (value) => store.setName(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo obrigatório';
                value = value.replaceAll(' ', '');
                if (value.length < 3) return 'Digite pelo menos 3 caracteres';
              },
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite o seu nome',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => store.setUsername(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo obrigatório';
                value = value.replaceAll(' ', '');
                if (value.length < 5) return 'Digite pelo menos 5 caracteres';
              },
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Digite o seu nome de usuário',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => store.setPassword(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo obrigatório';
                value = value.replaceAll(' ', '');
                if (value.length < 8) return 'Digite pelo menos 8 caracteres';
              },
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite a sua senha',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => store.setRepeatPassword(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != store.txtPassword) return 'Senhas diferentes';
              },
              decoration: InputDecoration(
                labelText: 'Repetir a senha',
                hintText: 'Repita senha digitada acima',
              ),
            ),
            SizedBox(height: 16.0),
            Row(children: [
              Expanded(
                child: Observer(
                  builder: (_) => ElevatedButton(
                    onPressed: store.formIsValid ? () => store.onSave(context) : null,
                    child: Text('Cadastrar'),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Já possui cadastro?\nfazer login',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
