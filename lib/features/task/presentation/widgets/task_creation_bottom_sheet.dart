import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/api/notification_api.dart';
import 'package:todo/features/task/domain/models/task.dart';
import 'package:todo/features/task/presentation/providers/task_provider.dart';
import 'package:todo/features/task/presentation/widgets/name_text_field.dart';
import 'package:todo/features/task/presentation/widgets/text.dart';
import 'package:todo/features/task/presentation/widgets/text_field.dart';
import 'package:todo/services/task_service.dart';
import 'package:todo/utils/date_formatter.dart';
import 'package:todo/utils/helper_functions.dart';

class TaskCreationBottomSheet extends StatefulWidget {
  const TaskCreationBottomSheet({super.key});

  @override
  State<TaskCreationBottomSheet> createState() =>
      _TaskCreationBottomSheetState();
}

class _TaskCreationBottomSheetState extends State<TaskCreationBottomSheet> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  final _dateFormat = DateFormat('yMd');
  final _timeFormat = DateFormat('jm');

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

  bool _isValidInput() {
    return [_nameController.text, _dateController.text, _timeController.text]
        .every((field) => field.isNotEmpty);
  }

  void _clearInputFields() {
    _nameController.clear();
    _dateController.clear();
    _timeController.clear();
  }

  void _addNewTask() async {
    if (_isValidInput()) {
      final newTask = Task(
        id: '',
        name: _nameController.text,
        dueDate: _dateFormat.parse(_dateController.text),
        // Parse using DateFormat
        dueTime: _timeFormat.parse(_timeController.text),
      );
      NotificationApi.scheduleNotification(task: newTask);
      final taskService = TaskService();
      print(FirebaseAuth.instance.currentUser!.uid);
      await taskService.addTask(newTask, FirebaseAuth.instance.currentUser!.uid);
      _clearInputFields();
      Navigator.pop(context);
    } else {
      Utils.showSnackBar('Please fill all fields');
    }
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
    final screenWidth = Utils.getScreenWidth(context);
    final screenHeight = Utils.getScreenWidth(context);
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
              TextWidget(
                text: 'Add a task',
                textSize: 42,
                isBoldFont: true,
                textColor: isDarkMode ? Colors.white : Colors.black,
              ),
              SizedBox(height: screenHeight * 0.05),
              _buildInputCard(_nameOfTaskComponent(screenWidth, isDarkMode)),
              SizedBox(height: screenHeight * 0.04),
              _buildInputCard(_dateComponent(screenWidth, isDarkMode)),
              SizedBox(height: screenHeight * 0.04),
              _buildInputCard(_timeComponent(screenWidth, isDarkMode)),
              SizedBox(height: screenHeight * 0.08),
              _buildDoneButton(isDarkMode),
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

  Widget _nameOfTaskComponent(double screenWidth, bool isDarkMode) {
    return Row(
      children: [
        TextWidget(
          text: 'Name',
          textSize: 20,
          isBoldFont: true,
          textColor: isDarkMode ? Colors.white : Colors.black,
        ),
        SizedBox(width: screenWidth * 0.08),
        NameTextField(controller: _nameController)
      ],
    );
  }

  Widget _dateComponent(double screenWidth, bool isDarkMode) {
    return Row(
      children: [
        TextWidget(
          text: 'Date',
          textSize: 20,
          isBoldFont: true,
          textColor: isDarkMode ? Colors.white : Colors.black,
        ),
        SizedBox(width: screenWidth * 0.08),
        TextFieldWidget(
          controller: _dateController,
          isDateField: true,
          onIconPress: _selectDate,
        )
      ],
    );
  }

  Widget _timeComponent(double screenWidth, bool isDarkMode) {
    return Row(
      children: [
        TextWidget(
          text: 'Time',
          textSize: 20,
          isBoldFont: true,
          textColor: isDarkMode ? Colors.white : Colors.black,
        ),
        SizedBox(width: screenWidth * 0.08),
        TextFieldWidget(
          controller: _timeController,
          isDateField: false,
          onIconPress: _selectTime,
        )
      ],
    );
  }

  Widget _buildDoneButton(bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      height: Utils.getScreenHeight(context) * 0.07,
      child: ElevatedButton(
        onPressed: _addNewTask,
        child: TextWidget(
          textColor: isDarkMode ? Colors.black : Colors.white,
          text: 'Done',
          textSize: 20,
          isBoldFont: true,
        ),
      ),
    );
  }
}

