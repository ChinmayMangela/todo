import 'package:flutter/material.dart';
import 'package:todo/features/authentication/presentation/screens/forgot_password_page.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_button.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:todo/services/authentication_service.dart';
import 'package:todo/utils/helper_functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onSignUpTap});

  final void Function() onSignUpTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authenticationService = AuthenticationService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _logInButtonTap() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Utils.showSnackBar('Please enter your credentials');
      return;
    }

    Utils.showCircularProgressIndicator(context);
    await _authenticationService.logInWithEmail(
        email: email, password: password);
    Navigator.pop(context);
  }

  void _onTogglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final screenHeight = Utils.getScreenHeight(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTopIcon(),
              SizedBox(height: screenHeight * 0.1),
              _buildLogInForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopIcon() {
    return const Icon(Icons.android, size: 150);
  }

  Widget _buildLogInForm() {
    final height = Utils.getScreenHeight(context);
    return Column(
      children: [
        _buildEmailField(),
        SizedBox(height: height * 0.012),
        _buildPasswordField(),
        SizedBox(height: height * 0.01),
        _buildForgotPasswordField(),
        SizedBox(height: height * 0.012),
        _buildLoginButton(),
        SizedBox(height: height * 0.012),
        _buildBottomMessage(),
      ],
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      hintText: 'Email',
      isPasswordField: false,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      hintText: 'Password',
      isPasswordField: true,
      obscureText: _obscurePassword,
      onTogglePasswordVisibility: _onTogglePasswordVisibility,
    );
  }

  Widget _buildForgotPasswordField() {
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ForgotPasswordPage()));
          },
          child: Text(
            'Forgot Password',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return CustomButton(
      onTap: _logInButtonTap,
      child: Text(
        'LOG IN',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: isDarkMode ? Colors.black : Colors.white,
            ),
      ),
    );
  }

  Widget _buildBottomMessage() {
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: isDarkMode ? Colors.white : Colors.black),
        ),
        TextButton(
          onPressed: widget.onSignUpTap,
          child: Text(
            'Register here',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
