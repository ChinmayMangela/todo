import 'package:flutter/material.dart';
import 'package:todo/features/task/presentation/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';


class HelperFunctions {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .height;
  }

  static void navigateToMyGithubAccount() async {
    final url = Uri.parse('https://github.com/ChinmayMangela');
    if (!await launchUrl(url)) {
      return;
    }
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

  static Future<void> openModalBottomSheet({
    required BuildContext context,
    required Widget child,
  }) async {
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
          height: MediaQuery
              .of(context)
              .size
              .height * 0.9,
          child: child,
        );
      },
    );
  }


  static Widget buildEmptyTodoListMessage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(text: 'No todos yet!', textSize: 14, isBoldFont: true),
          SizedBox(height: 10),
          TextWidget(
              text: 'Tap + to add a new todo', textSize: 14, isBoldFont: true),
        ],
      ),
    );
  }

}
