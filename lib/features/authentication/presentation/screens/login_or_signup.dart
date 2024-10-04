import 'package:flutter/material.dart';
import 'package:todo/features/authentication/presentation/screens/login_page.dart';
import 'package:todo/features/authentication/presentation/screens/sign_up_page.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool _showLogInScreen = true;

  void _onToggleAuthScreens() {
    setState(() {
      _showLogInScreen = !_showLogInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showLogInScreen
        ? LoginPage(onSignUpTap: _onToggleAuthScreens)
        : SignUpPage(onLoginTap: _onToggleAuthScreens);
  }
}
