import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_karla/src/pages/register_user/register_user_style.dart';
import 'stores/register_user_store.dart';
import '../../shared/core/app_text_theme.dart';
import '../../shared/repositories/user_repository.dart';
import '../../shared/services/app_preferences_service.dart';
import '../../shared/services/http_client_service.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
  AppTextTheme _textTheme = AppTextTheme();
  RegisterUserStyle _style = RegisterUserStyle();
  RegisterUserStore _store = RegisterUserStore(
    repository: UserRepository(
      client: HttpClientService(),
      appData: AppPreferenceService(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: _style.backgroundContainer,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Wrap(
                children: [
                  Card(
                    margin: const EdgeInsets.all(32.0),
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
              onChanged: (value) => _store.setName(value),
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
              onChanged: (value) => _store.setUsername(value),
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
            Observer(
              builder: (_) => TextFormField(
                onChanged: (value) => _store.setPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _store.hidePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  value = value.replaceAll(' ', '');
                  if (value.length < 8) return 'Digite pelo menos 8 caracteres';
                },
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite a sua senha',
                  suffixIcon: IconButton(
                    onPressed: () => _store.toggleShowPassword(),
                    icon: Icon(_store.hidePassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Observer(
              builder: (_) => TextFormField(
                onChanged: (value) => _store.setRepeatPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != _store.txtPassword) return 'Senhas diferentes';
                },
                obscureText: _store.hiderepeatPassword,
                decoration: InputDecoration(
                  labelText: 'Repetir a senha',
                  hintText: 'Repita senha digitada acima',
                  suffixIcon: IconButton(
                    onPressed: () => _store.toggleRepeatShowPasswrd(),
                    icon: Icon(_store.hiderepeatPassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(children: [
              Expanded(
                child: Observer(
                  builder: (_) => ElevatedButton(
                    onPressed: _store.formIsValid && !_store.isLoading ? () => _store.onSave(context) : null,
                    child: Text(_store.isLoading ? 'Carregando...' : 'Cadastrar'),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 16.0),
            Observer(
              builder: (_) => TextButton(
                onPressed: !_store.isLoading ? () => Navigator.pop(context) : null,
                child: Text(
                  'Já possui cadastro?\nfazer login',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
}
