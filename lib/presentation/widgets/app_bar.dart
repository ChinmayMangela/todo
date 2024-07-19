import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 3,
      child: AppBar(
        title: const Text('Your Task\'s'),
        actions: [
          IconButton(
            onPressed: _navigateToMyGithubAccount,
            icon: FaIcon(
              size: 30,
              FontAwesomeIcons.github,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'Todo',
            ),
            Tab(
              text: 'Completed',
            )
          ],
        ),
      ),
    );
  }

  void _navigateToMyGithubAccount() async {
    final url = Uri.parse('https://github.com/ChinmayMangela');
    if (!await launchUrl(url)) {
      return;
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
