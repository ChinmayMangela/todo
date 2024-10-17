import 'package:flutter/material.dart';
import 'package:todo/features/task/domain/models/task.dart';
import 'package:todo/features/task/presentation/widgets/task_tile.dart';

class OverDueTasksList extends StatelessWidget {
  const OverDueTasksList({super.key, required this.overdueTasks});

  final List<Task> overdueTasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final currentTask = overdueTasks[index];
        return TaskTile(task: currentTask);
      },
      itemCount: overdueTasks.length,
    );
  }
}
