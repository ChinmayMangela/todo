import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/task/domain/models/task.dart';
import 'package:todo/features/task/presentation/providers/task_provider.dart';
import 'package:todo/features/task/presentation/widgets/task_editing_bottom_sheet.dart';
import 'package:todo/features/task/presentation/widgets/task_tile.dart';
import 'package:todo/services/task_service.dart';
import 'package:todo/utils/helper_functions.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    final taskListProvider = Provider.of<TaskProvider>(context);
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final currentTask = tasks[index];
          return Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    taskListProvider.removeTask(currentTask);
                    Utils.showSnackBar(
                      '${currentTask.name} task removed',
                          () => taskListProvider.addTask(currentTask),
                    );
                  },
                  backgroundColor:
                  isDarkMode ? Colors.red.shade900 : Colors.black,
                  foregroundColor: isDarkMode ? Colors.black : Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    Utils.openModalBottomSheet(
                      context: context,
                      child: TaskEditingBottomSheet(
                        task: currentTask,
                      ),
                    );
                  },
                  backgroundColor:
                  isDarkMode ? Colors.green.shade900 : Colors.green.shade600,
                  foregroundColor: isDarkMode ? Colors.black : Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: TaskTile(
              task: currentTask,
            ),
          );
      },
    );
  }
}
