import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:todo/domain/models/task.dart';

class IsarLocalDatabase {
  static late Isar _isar;

  static Future<void> initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TaskSchema], directory: directory.path);
  }

  Future<void> addTask(Task task) async {
    await _isar.writeTxn(
      () => _isar.tasks.put(task),
    );
  }

  Future<void> removeTask(int id) async {
    await _isar.writeTxn(
      () => _isar.tasks.delete(id),
    );
  }

  Future<void> updateTask(Task oldTask, Task newTask) async {
    newTask.id = oldTask.id;
    await _isar.writeTxn(
      () => _isar.tasks.put(newTask),
    );
  }

  Future<List<Task>> fetchTasks() async {
    return await _isar.tasks.where().findAll();
  }
}
