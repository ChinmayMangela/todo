import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.isPasswordField,
    this.onTogglePasswordVisibility,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool isPasswordField;
  final void Function()? onTogglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ));
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: isDarkMode ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hintText,

        suffixIcon: isPasswordField
            ? IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
        fillColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        filled: true,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
