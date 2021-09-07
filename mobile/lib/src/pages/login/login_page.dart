import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'login_style.dart';
import 'stores/login_store.dart';
import '../../shared/core/app_text_theme.dart';
import '../../shared/repositories/user_repository.dart';
import '../../shared/services/app_preferences_service.dart';
import '../../shared/services/http_client_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginStore _store;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppTextTheme _textTheme = AppTextTheme();
  LoginStyle _style = LoginStyle();

  @override
  void initState() {
    _store = LoginStore(
      repository: UserRepository(client: HttpClientService(), appData: AppPreferenceService()),
    );
    _store.verifyLoggedUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Observer(
        builder: (_) => Stack(
          children: [
            _contentWidget(size),
            _store.isLoading ? _loadingWidget(size) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black.withAlpha(100),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'carregando',
              style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget(Size size) {
    return Container(
      width: size.width,
      height: size.height,
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
                    child: _formLogin(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formLogin() => Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Login',
              style: _textTheme.titleStyle,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => _store.setLogin(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo obrigatório';
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Digite o seu nome de usuário',
              ),
            ),
            SizedBox(height: 16.0),
            Observer(
              builder: (context) => TextFormField(
                onChanged: (value) => _store.setPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                obscureText: _store.hidePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                },
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite a sua senha',
                  suffixIcon: IconButton(
                    onPressed: () => _store.toggleShowPasswrd(),
                    icon: Icon(_store.hidePassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(children: [
              Expanded(
                child: Observer(
                  builder: (_) => ElevatedButton(
                    onPressed:
                        _store.formIsValid && !_store.isLoading ? () => _store.loginUser(context: context) : null,
                    child: Text(_store.isLoading ? 'Carregando...' : 'Entrar'),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 16.0),
            Observer(
              builder: (context) => TextButton(
                onPressed: !_store.isLoading ? () => _store.goRegisterUserPage(context) : null,
                child: Text(
                  'Ainda não possui cadastro?\nClique aqui e cadastre-se',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
}
