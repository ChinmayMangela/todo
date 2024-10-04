import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/models/task.dart';
import 'package:todo/features/task/presentation/widgets/text.dart';
import 'package:todo/utils/date_formatter.dart';
import 'package:todo/utils/helper_functions.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: _buildTaskTile(),
    );
  }

  Widget _buildTaskTile() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.maxFinite,
      height: HelperFunctions.getScreenHeight(context) * 0.094,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        color: isDarkMode ? Colors.grey.shade900 : Colors.white
      ),
      child: ListTile(
        leading: Checkbox(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
          ),
          activeColor: isDarkMode ? Colors.white : Colors.black,
          onChanged: (value) {
            setState(() {
              widget.task.isCompleted = value!;
            });
          },
          value: widget.task.isCompleted,
        ),
        title: TextWidget(
          text: widget.task.name,
          textSize: 17,
          isBoldFont: true,
          isTaskCompleted: widget.task.isCompleted,
        ),
        subtitle: Row(
          children: [
            TextWidget(
              text: _getDay(widget.task.dueDate),
              textSize: 11,
              isBoldFont: false,
              isTaskCompleted: widget.task.isCompleted,
            ),
            const SizedBox(width: 10),
            TextWidget(
              text: _getTime(widget.task.dueTime),
              textSize: 11,
              isBoldFont: false,
              isTaskCompleted: widget.task.isCompleted,
            ),
          ],
        ),
      ),
    );
  }

  String _getDay(DateTime date) {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final dueDate = date;
    bool isTomorrowDay = dueDate == tomorrow;
    if (dueDate == now) {
      return 'Today';
    } else if (isTomorrowDay) {
      return 'Tomorrow';
    } else {
      return DateFormatter.formatDate(dueDate);
    }
  }

  String _getTime(DateTime time) {
    return DateFormat('jm').format(time);
  }
}

