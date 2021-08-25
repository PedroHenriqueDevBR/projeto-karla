import 'package:flutter/material.dart';
import 'package:projeto_karla/src/shared/core/images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppImages _appImages = AppImages();
  final _formKey = GlobalKey<FormState>();

  List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.purple,
            image: DecorationImage(
              image: AssetImage(_appImages.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Wrap(
              children: [
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Container(
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

  Widget _formLogin() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Acesso'),
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
          Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Entrar'),
              ),
            ),
          ]),
          SizedBox(height: 16.0),
          TextButton(onPressed: () {}, child: Text('Ainda não possui cadastro?\nClique aqui e cadastre-se')),
        ],
      ),
    );
  }
}
