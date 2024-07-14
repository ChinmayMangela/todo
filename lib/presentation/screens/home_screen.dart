import 'package:flutter/material.dart';
import 'package:todo/data/datasources/isar_localdatabase.dart';
import 'package:todo/presentation/widgets/task_creation_bottom_sheet.dart';
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
    return FutureBuilder(future: IsarLocalDatabase().fetchTasks(), builder: (context, snapShot) {
      switch(snapShot.connectionState) {
        case ConnectionState.waiting :
          return _buildCircularProgressIndicator();
        default:
          if(snapShot.data!.isEmpty) {
            return _buildEmptyTodoListMessage();
          } else if(snapShot.hasError) {
            return Center(child: Text(snapShot.error.toString()),);
          } else {
            return TaskList(
              taskList: snapShot.data!,
            );
          }
      }
    });
  }


  Widget _buildEmptyTodoListMessage() {
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

  Widget _buildCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
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
