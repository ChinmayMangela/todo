import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/providers/task_provider.dart';
import 'package:todo/presentation/widgets/TabWidgets/all_task_list.dart';
import 'package:todo/presentation/widgets/TabWidgets/completed_task_list.dart';
import 'package:todo/presentation/widgets/TabWidgets/pending_task_list.dart';
import 'package:todo/presentation/widgets/task_creation_bottom_sheet.dart';
import 'package:todo/utils/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        IconButton(
          onPressed: HelperFunctions.navigateToMyGithubAccount,
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
            CompletedTaskList(),
            PendingTaskList(),
          ],
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        await HelperFunctions.openModalBottomSheet(
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
}
