import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/providers/task_provider.dart';
import 'package:todo/presentation/widgets/name_text_field.dart';
import 'package:todo/presentation/widgets/text.dart';
import 'package:todo/presentation/widgets/text_field.dart';
import 'package:todo/utils/date_formatter.dart';
import 'package:todo/utils/helper_functions.dart';

import '../../domain/models/task.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  final _dateFormat = DateFormat('M/d/yyyy');

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
      final formattedTime = DateFormatter.formatTime(pickedTime);
      setState(() {
        _timeController.text = formattedTime;
      });
    }
  }

  bool _isValidInput() {
    return [_nameController.text, _dateController.text, _timeController.text]
        .every((field) => field.isNotEmpty);
  }

  void _addNewTask() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    if (_isValidInput()) {
      final newTask = Task(
        name: _nameController.text,
        dueDate: _dateFormat.parse(_dateController.text),
        // Parse using DateFormat
        dueTime: TimeOfDay.fromDateTime(
            DateFormat('HH:mm').parse(_timeController.text)),
      );
      taskProvider.addTask(newTask);
      _nameController.clear();
      _dateController.clear();
      _timeController.clear();
      Navigator.pop(context);
    } else {
      HelperFunctions.showSnackBar(context, 'Please fill all fields');
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
          const TextWidget(text: 'Add a task', textSize: 42, isBoldFont: true),
          SizedBox(height: screenHeight * 0.05),
          _buildInputCard(_nameOfTaskComponent(screenWidth)),
          SizedBox(height: screenHeight * 0.04),
          _buildInputCard(_dateComponent(screenWidth)),
          SizedBox(height: screenHeight * 0.04),
          _buildInputCard(_timeComponent(screenWidth)),
          SizedBox(height: screenHeight * 0.08),
          _doneButton(isDarkMode),
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

  Widget _doneButton(bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      height: HelperFunctions.getScreenHeight(context) * 0.07,
      child: ElevatedButton(
        onPressed: _addNewTask,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: TextWidget(
          text: 'Done',
          textSize: 20,
          isBoldFont: true,
          textColor: isDarkMode ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
