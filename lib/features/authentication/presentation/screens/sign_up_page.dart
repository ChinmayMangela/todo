import 'package:flutter/material.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_button.dart';
import 'package:todo/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:todo/services/authentication_service.dart';
import 'package:todo/utils/helper_functions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    required this.onLoginTap,
  });

  final void Function() onLoginTap;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _authenticationService = AuthenticationService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _signUpButtonTap() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Utils.showSnackBar('Please enter all the credentials');
      return;
    }

    if(password != confirmPassword) {
      Utils.showSnackBar('Passwords does not match');
      return;
    }

    Utils.showCircularProgressIndicator(context);
    await _authenticationService.signUpWithEmail(email: email, password: password);
    Navigator.of(context).pop();

  }

  void _onTogglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onToggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
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
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTopIcon(),
              SizedBox(height: screenHeight * 0.1),
              _buildSignUpForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopIcon() {
    return const Icon(Icons.android, size: 150);
  }

  Widget _buildSignUpForm() {
    final height = Utils.getScreenHeight(context);
    return Column(
      children: [
        _buildEmailField(),
        SizedBox(height: height * 0.015),
        _buildPasswordField(),
        SizedBox(height: height * 0.015),
        _buildConfirmPasswordField(),
        SizedBox(height: height * 0.03),
        _buildSignUpButton(),
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

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: _confirmPasswordController,
      hintText: 'Confirm Password',
      isPasswordField: true,
      obscureText: _obscureConfirmPassword,
      onTogglePasswordVisibility: _onToggleConfirmPasswordVisibility,
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

  Widget _buildSignUpButton() {
    bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return CustomButton(
      onTap: _signUpButtonTap,
      child: Text(
        'Sign Up',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: isDarkMode ? Colors.black : Colors.white,
          fontWeight: FontWeight.w900,
            ),
      ),
    );
  }

  Widget _buildBottomMessage() {
    final isDarkMode = Theme.of(context).colorScheme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?', style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: isDarkMode ? Colors.white : Colors.black
        ),),
        TextButton(
          onPressed: widget.onLoginTap,
          child: Text('Log in here', style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold,
          ),),
        ),
      ],
    );
  }
}
