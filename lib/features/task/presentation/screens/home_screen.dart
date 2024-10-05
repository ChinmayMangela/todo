import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/task/presentation/providers/task_provider.dart';
import 'package:todo/features/task/presentation/widgets/TabWidgets/all_task_list.dart';
import 'package:todo/features/task/presentation/widgets/TabWidgets/completed_task_list.dart';
import 'package:todo/features/task/presentation/widgets/TabWidgets/pending_task_list.dart';
import 'package:todo/features/task/presentation/widgets/task_creation_bottom_sheet.dart';
import 'package:todo/services/authentication_service.dart';
import 'package:todo/utils/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authenticationService = AuthenticationService();

  Future<void> _onLogOutClick() async {
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
            content: _buildLogOutContent(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(isDarkMode),
        body: _buildTabBarView(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  AppBar _buildAppBar(bool isDarkMode) {
    return AppBar(
      title: const Text('Your Task\'s'),
      actions: [
        IconButton(onPressed: _onLogOutClick, icon: const Icon(Icons.logout)),
        IconButton(
          onPressed: Utils.navigateToMyGithubAccount,
          icon: FaIcon(
            size: 30,
            FontAwesomeIcons.github,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
      bottom: const TabBar(
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
    );
  }

  Widget _buildTabBarView() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return const TabBarView(
          children: [
            AllTaskList(),
            PendingTaskList(),
            CompletedTaskList(),
          ],
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        await Utils.openModalBottomSheet(
          context: context,
          child: const TaskCreationBottomSheet(),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.add),
    );
  }

  Widget _buildLogOutContent() {
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Do you want to log out ??',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Utils.showCircularProgressIndicator(context);
                  Navigator.of(context).pop();
                  await _authenticationService.signOut();
                },
                child: Text(
                  'ok',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                ))
          ],
        )
      ],
    );
  }
}
