import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.isDateField = false,
    this.onIconPress,
  });

  final TextEditingController controller;
  final bool isDateField;
  final void Function()? onIconPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: getSuffixIcon(),
        ),
      ),
    );
  }

  Widget getSuffixIcon() {
    return GestureDetector(
      onTap: onIconPress,
      child: Icon(
        isDateField ? Icons.calendar_month : Icons.watch_later_outlined,
      ),
    );
  }
}
