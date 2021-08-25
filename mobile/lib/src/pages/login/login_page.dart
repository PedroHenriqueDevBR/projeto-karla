import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/login/widgets/login_form_widget.dart';
import 'package:projeto_karla/src/pages/login/widgets/register_user_widget.dart';
import 'package:projeto_karla/src/pages/login/widgets/video_background_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PageController _pageController = PageController(initialPage: 0);

  void goRegisterUserPage() {
    _pageController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.easeIn);
  }

  void goLoginPage() {
    _pageController.previousPage(duration: Duration(milliseconds: 750), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoBackgroundWidget(),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  LoginFormWidget(onBottomButtomPresset: goRegisterUserPage),
                  RegisterUserFormWidget(onBottomButtomPresset: goLoginPage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
