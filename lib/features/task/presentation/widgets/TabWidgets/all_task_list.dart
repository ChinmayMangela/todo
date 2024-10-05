import 'package:flutter/material.dart';
import 'package:todo/features/task/presentation/widgets/TabWidgets/filtered_task_list.dart';

class AllTaskList extends StatelessWidget {
  const AllTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return FilteredTaskList(
      filter: (_) => true,
    );
  }
}
