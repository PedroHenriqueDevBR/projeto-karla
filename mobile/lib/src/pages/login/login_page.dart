import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/login/login_controller.dart';
import 'package:projeto_karla/src/pages/login/stores/login_store.dart';
import 'package:projeto_karla/src/pages/login/widgets/login_form_widget.dart';
import 'package:projeto_karla/src/pages/login/widgets/register_user_widget.dart';
import 'package:projeto_karla/src/pages/login/widgets/video_background_widget.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:projeto_karla/src/shared/services/app_preferences_service.dart';
import 'package:projeto_karla/src/shared/services/dio_client_service.dart';
import 'package:projeto_karla/src/shared/services/http_client_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStore _store = LoginStore();
  late LoginController _controller;

  @override
  void initState() {
    _controller = LoginController(
      repository: UserRepository(client: HttpClientService(), appData: AppPreferenceService()),
      store: _store,
    );
    super.initState();
  }

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
              child: PageView(
                controller: _controller.pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  LoginFormWidget(
                    txtLogin: _controller.txtLogin,
                    txtPassword: _controller.txtPassword,
                    onConfirmButtonPresset: () {
                      _controller.loginUser(context: context);
                    },
                    onBottomButtomPresset: _controller.goRegisterUserPage,
                  ),
                  RegisterUserFormWidget(onBottomButtomPresset: _controller.goLoginPage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
