import 'package:flutter/material.dart';

import 'package:todo/domain/models/task.dart';
import 'package:todo/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final _taskService = TaskService();
  final String userId;

  TaskProvider(this.userId);

  Stream<List<Task>> get tasksStream => _taskService.fetchTasks(userId);

  void addTask(Task task) async {
    await _taskService.addTask(task, userId);
    notifyListeners();
  }

  void removeTask(Task task) async {
    await _taskService.removeTask(userId, task.id);
    notifyListeners();
  }

  void updateTask(Task oldTask, Task newTask) async {
    await _taskService.updateTask(userId, oldTask.id, newTask);
    notifyListeners();
  }
}
