import 'package:isar/isar.dart';

part 'task.g.dart';
@Collection()
class Task {
  Id id = Isar.autoIncrement;
  final String name;
  final DateTime dueDate;
  final DateTime dueTime;
  bool isCompleted;

  Task({
    required this.name,
    required this.dueDate,
    required this.dueTime,
    this.isCompleted = false,
  });
}
