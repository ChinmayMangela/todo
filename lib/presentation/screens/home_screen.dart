import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/providers/task_provider.dart';
import 'package:todo/presentation/widgets/app_bar.dart';
import 'package:todo/presentation/widgets/task_list.dart';
import 'package:todo/presentation/widgets/text.dart';
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
    return Scaffold(
      appBar: const MyAppBar(),
      body: _buildBody(isDarkMode),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody(bool isDarkMode) {
    final taskListProvider = Provider.of<TaskProvider>(context);
    return taskListProvider.tasks.isEmpty ? _showEmptyTodoListMessage() : const TaskList();
  }

  Widget _showEmptyTodoListMessage() {
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

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        await HelperFunctions.openModalBottomSheet(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.add),
    );
  }

}
