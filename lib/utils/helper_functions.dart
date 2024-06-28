import 'package:flutter/material.dart';

import '../presentation/widgets/bottom_sheet_content.dart';

class HelperFunctions {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static void showSnackBar(BuildContext context, String message,
      [void Function()? onTap]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: onTap != null
            ? SnackBarAction(label: 'Undo', onPressed: onTap)
            : null,
      ),
    );
  }

  static Future<void> openModalBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      ),
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: const BottomSheetContent(),
        );
      },
    );
  }
}
