
class Task {
  final String id;
  final String name;
  final DateTime dueDate;
  final DateTime dueTime;
  bool isCompleted;

  Task({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.dueTime,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      name: data['name'],
      dueDate: DateTime.parse(data['dueDate']),
      dueTime: DateTime.parse(data['dueTime']),
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate.toIso8601String(),
      'dueTime': dueTime.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
