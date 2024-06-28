import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        maxLength: 30,
        controller: controller,
        decoration: const InputDecoration(

          hintText: 'Enter task name',
          border: OutlineInputBorder(),
        )
      ),
    );
  }

}
