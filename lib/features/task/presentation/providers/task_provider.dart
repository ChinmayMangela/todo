import 'package:flutter/material.dart';

import 'package:todo/domain/models/task.dart';

class TaskProvider extends ChangeNotifier  {

  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) {
    final oldTaskIndex = _tasks.indexOf(oldTask);
    if(oldTaskIndex != -1) {
      _tasks[oldTaskIndex] = newTask;
    }
    notifyListeners();
  }
// void addTask(Task task) async {
//   await IsarLocalDatabase().addTask(task);
//   notifyListeners();
// }
//
// void removeTask(Task task) async {
//   await IsarLocalDatabase().removeTask(task.id);
//   notifyListeners();
// }
//
// void updateTask(Task oldTask, Task updatedTask) async {
//   await IsarLocalDatabase().updateTask(oldTask, updatedTask);
//   notifyListeners();
// }
//
// Future<List<Task>> fetchAllTasks() async {
//   final tasks = await IsarLocalDatabase().fetchTasks();
//   notifyListeners();
//   return tasks;
// }
}