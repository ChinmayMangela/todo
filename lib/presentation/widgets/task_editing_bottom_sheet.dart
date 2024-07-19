import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/widgets/name_text_field.dart';
import 'package:todo/presentation/widgets/text.dart';
import 'package:todo/presentation/widgets/text_field.dart';
import 'package:todo/utils/date_formatter.dart';
import 'package:todo/utils/helper_functions.dart';

import '../../domain/models/task.dart';
import '../providers/task_provider.dart';

class TaskEditingBottomSheet extends StatefulWidget {
  const TaskEditingBottomSheet({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskEditingBottomSheet> createState() => _TaskEditingBottomSheetState();
}

class _TaskEditingBottomSheetState extends State<TaskEditingBottomSheet> {
  final _dateFormat = DateFormat('yMd');
  final _timeFormat = DateFormat('jm');
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final lastDate = DateTime(2099);

    final pickedDate = await showDatePicker(
        context: context, firstDate: now, lastDate: lastDate);
    if (pickedDate != null) {
      final formattedDate = DateFormatter.formatDate(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final pickedTime =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      final formattedTime = _timeFormat.format(dateTime);
      setState(() {
        _timeController.text = formattedTime;
      });
    }
  }

  void _editTask() {
    try {
      final updatedTask = Task(
        name: _nameController.text,
        dueDate: _dateFormat.parse(_dateController.text),
        dueTime: _timeFormat.parse(_timeController.text),
      );

      Provider.of<TaskProvider>(context, listen: false)
          .updateTask(widget.task, updatedTask);
      Navigator.of(context).pop();
    } catch (e) {
      // Handle the exception, e.g., display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid date or time format')),
      );
    }
  }

  @override
  void initState() {
    _nameController.text = widget.task.name;
    _dateController.text = DateFormatter.formatDate(widget.task.dueDate);
    _timeController.text = DateFormatter.formatTime(widget.task.dueTime);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = HelperFunctions.getScreenWidth(context);
    final screenHeight = HelperFunctions.getScreenWidth(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context, screenWidth, screenHeight),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Task'),
      centerTitle: true,
    );
  }

  Widget _buildBody(
      BuildContext context, double screenWidth, double screenHeight) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
        // Wrap in SingleChildScrollView to prevent overflow
        child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1, vertical: screenHeight * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextWidget(text: 'Edit a task', textSize: 42, isBoldFont: true),
          SizedBox(height: screenHeight * 0.05),
          _buildInputCard(_nameOfTaskComponent(screenWidth)),
          SizedBox(height: screenHeight * 0.04),
          _buildInputCard(_dateComponent(screenWidth)),
          SizedBox(height: screenHeight * 0.04),
          _buildInputCard(_timeComponent(screenWidth)),
          SizedBox(height: screenHeight * 0.08),
          _buildEditTaskButton(isDarkMode),
        ],
      ),
    ));
  }

  Widget _buildInputCard(Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _nameOfTaskComponent(double screenWidth) {
    return Row(
      children: [
        const TextWidget(text: 'Name', textSize: 20, isBoldFont: true),
        SizedBox(width: screenWidth * 0.08),
        NameTextField(controller: _nameController)
      ],
    );
  }

  Widget _dateComponent(double screenWidth) {
    return Row(
      children: [
        const TextWidget(text: 'Date', textSize: 20, isBoldFont: true),
        SizedBox(width: screenWidth * 0.08),
        TextFieldWidget(
          controller: _dateController,
          isDateField: true,
          onIconPress: _selectDate,
        )
      ],
    );
  }

  Widget _timeComponent(double screenWidth) {
    return Row(
      children: [
        const TextWidget(text: 'Time', textSize: 20, isBoldFont: true),
        SizedBox(width: screenWidth * 0.08),
        TextFieldWidget(
          controller: _timeController,
          isDateField: false,
          onIconPress: _selectTime,
        )
      ],
    );
  }

  Widget _buildEditTaskButton(bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      height: HelperFunctions.getScreenHeight(context) * 0.07,
      child: ElevatedButton(
        onPressed: _editTask,
        child: TextWidget(
          text: 'Edit',
          textSize: 20,
          isBoldFont: true,
          textColor: isDarkMode ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
