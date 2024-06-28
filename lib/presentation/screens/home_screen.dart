import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/providers/task_provider.dart';
import 'package:todo/presentation/widgets/app_bar.dart';
import 'package:todo/presentation/widgets/bottom_sheet_content.dart';
import 'package:todo/presentation/widgets/task_list.dart';
import 'package:todo/presentation/widgets/text.dart';

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
      onPressed: _openModalBottomSheet,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.add),
    );
  }

  Future<void> _openModalBottomSheet() async {
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
