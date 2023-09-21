import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { open, inProgress, done }

class Task {
  final String id;
  final String name;
  final String description;

  final TaskStatus taskStatus;
  final DateTime creationDate;

  const Task({
    required this.id,
    required this.name,
    required this.description,
    required this.taskStatus,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'taskStatus': taskStatus.index,
      'creationDate': Timestamp.fromDate(creationDate),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      name: map['name'],
      description: map['description'],
      taskStatus: TaskStatus.values[map['taskStatus']],
      creationDate: (map['creationDate'] as Timestamp).toDate(),
    );
  }
  factory Task.fromTaskWithNewStatus(Task task, TaskStatus newStatus) {
    return Task(
      id: task.id,
      description: task.description,
      name: task.name,
      creationDate: task.creationDate,
      taskStatus: newStatus,
    );
  }
}
