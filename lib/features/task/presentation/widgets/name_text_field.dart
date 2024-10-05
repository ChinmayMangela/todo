import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: TextField(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: isDarkMode ? Colors.white : Colors.black
        ),
          maxLength: 30,
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white : Colors.black,
              )
            ),
            hintText: 'Enter task name',

            border: const OutlineInputBorder(
            ),
          )),
    );
  }
}
