import 'package:flutter/material.dart';
import 'package:todo/features/task/presentation/widgets/TabWidgets/filtered_task_list.dart';

class PendingTaskList extends StatelessWidget {
  const PendingTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return FilteredTaskList(filter: (task) => !task.isCompleted);
  }
}
