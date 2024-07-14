
import 'package:flutter/material.dart';
import 'package:todo/data/datasources/isar_localdatabase.dart';

import 'package:todo/domain/models/task.dart';

class TaskProvider extends ChangeNotifier  {

  void addTask(Task task) async {
    await IsarLocalDatabase().addTask(task);
    notifyListeners();
  }

  void removeTask(Task task) async {
    await IsarLocalDatabase().removeTask(task.id);
    notifyListeners();
  }

  void updateTask(Task oldTask, Task updatedTask) async {
    await IsarLocalDatabase().updateTask(oldTask, updatedTask);
    notifyListeners();
  }

  Future<List<Task>> fetchAllTasks() async {
    final tasks = await IsarLocalDatabase().fetchTasks();
    notifyListeners();
    return tasks;
  }
}