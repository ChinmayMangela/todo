import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_button.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:todo/services/authentication_service.dart';
import 'package:todo/utils/helper_functions.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _authenticationService = AuthenticationService();
  final _emailController = TextEditingController();

  Future<void> _onForgotPasswordTap() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      Utils.showSnackBar('Please enter your email');
      return;
    }

    await _authenticationService.sendResetPasswordEmail(email: email);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              CustomButton(
                onTap: _onForgotPasswordTap,
                child: const Text('Forgot Password'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
