
import 'package:flutter/material.dart';

class Task {
  final String name;
  final DateTime dueDate;
  final TimeOfDay dueTime;
  bool isCompleted;

  Task({
    required this.name,
    required this.dueDate,
    required this.dueTime,
    this.isCompleted = false,
  });
}
