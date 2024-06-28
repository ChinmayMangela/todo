import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/providers/task_provider.dart';
import 'package:todo/presentation/widgets/task_tile.dart';

import '../../utils/helper_functions.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final taskListProvider = Provider.of<TaskProvider>(context);
    return ListView.builder(
      itemCount: taskListProvider.tasks.length,
      itemBuilder: (context, index) {
        final currentTask = taskListProvider.tasks[index];
        return Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    taskListProvider.removeTask(currentTask);
                    HelperFunctions.showSnackBar(
                        context, '${currentTask.name} task removed',
                      () => taskListProvider.addTask(currentTask),
                    );
                  },
                  backgroundColor:
                  isDarkMode ? Colors.red.shade900 : Colors.red.shade700,
                  foregroundColor: isDarkMode ? Colors.black : Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: TaskTile(
              task: currentTask,
            ));
      },
    );
  }
}
