import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/task/presentation/widgets/over_due_tasks_list.dart';
import 'package:todo/features/task/presentation/widgets/task_list.dart';
import 'package:todo/services/task_service.dart';

class OverDueTasksPage extends StatelessWidget {
  const OverDueTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(isDarkMode),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('OverDue Tasks'),
    );
  }

  Widget _buildBody(bool isDarkMode) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(stream: TaskService().fetchOverDueTasks(userId), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator(),);
      }

      if(snapshot.data == null || snapshot.data!.isEmpty) {
        return Center(child: Text('There are no overdue tasks', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: isDarkMode ? Colors.white : Colors.black,
        ),));
      }

      if(snapshot.hasError) {
        return Center(child: Text(snapshot.error.toString()));
      } else {
        return OverDueTasksList(overdueTasks: snapshot.data!);
      }
    });
  }
}
