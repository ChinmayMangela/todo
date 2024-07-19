import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/providers/task_provider.dart';
import 'package:todo/presentation/widgets/task_list.dart';

class PendingTaskList extends StatelessWidget {
  const PendingTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return TaskList(
          tasks: taskProvider.tasks.where((task) => task.isCompleted).toList(),
        );
      },
    );
  }
}
