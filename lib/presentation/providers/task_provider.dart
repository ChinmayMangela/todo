
import 'package:flutter/material.dart';

import 'package:todo/domain/models/task.dart';

class TaskProvider extends ChangeNotifier  {
  final List<Task> _tasksList = [
    Task(name: 'Study', dueDate: DateTime.now(), dueTime: TimeOfDay.now())
  ];

  List<Task> get tasks => _tasksList;


  void addTask(Task task) {
    _tasksList.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasksList.remove(task);
    notifyListeners();
  }

}