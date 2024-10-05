import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/models/task.dart';
import 'package:todo/utils/helper_functions.dart';

class TaskService {
  final _fireStore = FirebaseFirestore.instance;

  Future<void> addTask(Task task, String userId) async {
    try {
      await _fireStore.collection('users').doc(userId).collection('tasks').add(
            task.toJson(),
          );
    } on FirebaseException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future<void> removeTask(String userId, String taskId) async {
    try {
      await _fireStore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } on FirebaseException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future<void> updateTask(String userId, String oldTaskId, Task newTask) async {
    try {
      await _fireStore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(oldTaskId)
          .update(
            newTask.toJson(),
          );
    } on FirebaseException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Stream<List<Task>> fetchTasks(String userId) {
    return _fireStore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (task) => Task.fromJson(task.data(), task.id),
            )
            .toList());
  }

  Future<void> updateCheckBoxState(String userId, String taskId, bool isCompleted) async {
    try {
      await _fireStore.collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update({'isCompleted': isCompleted});
    } on FirebaseException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
