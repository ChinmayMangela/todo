import 'package:flutter/material.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_button.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:todo/utils/helper_functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }


  void _logInButtonTap() {}

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
    final screenHeight = HelperFunctions.getScreenHeight(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTopIcon(),
            SizedBox(height: screenHeight * 0.1),
            _buildLogInForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopIcon() {
    return const Icon(Icons.android, size: 150);
  }

  Widget _buildLogInForm() {
    final height = HelperFunctions.getScreenHeight(context);
    return Column(
      children: [
        _buildEmailField(),
        SizedBox(height: height * 0.012),
        _buildPasswordField(),
        SizedBox(height: height * 0.01),
        _buildForgotPasswordField(),
        SizedBox(height: height * 0.012),
        _buildLoginButton(),
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
          onPressed: () {},
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
}
