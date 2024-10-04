import 'package:flutter/material.dart';
import 'package:todo/utils/helper_functions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.child});

  final void Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Container(
      height: HelperFunctions.getScreenHeight(context) * 0.08,
      width: HelperFunctions.getScreenWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
