import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/task/domain/models/task.dart';
import 'package:todo/features/task/presentation/providers/task_provider.dart';
import 'package:todo/features/task/presentation/widgets/task_list.dart';

class FilteredTaskList extends StatelessWidget {
  const FilteredTaskList({super.key, required this.filter});

  final bool Function(Task task) filter;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return StreamBuilder(stream: taskProvider.tasksStream, builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if(!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Tasks Available', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: isDarkTheme ? Colors.white : Colors.black
            ),));
          }

          final tasks = snapshot.data!.where(filter).toList();
          return TaskList(tasks: tasks);
        });
      },
    );
  }
}
