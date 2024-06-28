import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    required this.textSize,
    this.textColor,
    required this.isBoldFont,
    this.isTaskCompleted = false,
  });

  final String text;
  final double textSize;
  final Color? textColor;
  final bool isBoldFont;
  final bool isTaskCompleted;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: textSize,
        color: textColor,
        fontWeight: isBoldFont ? FontWeight.bold : FontWeight.normal,
        decoration: isTaskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
