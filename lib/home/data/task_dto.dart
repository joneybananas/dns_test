import 'package:dns_test/utils.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_dto.g.dart';

enum TaskStatus { open, inProgress, done }

@JsonSerializable()
class Task {
  final String id;
  final String name;
  final String description;
  @JsonKey(fromJson: _intToTaskStatus, toJson: _taskStatusToInt)
  final TaskStatus taskStatus;
  @TimestampConverter()
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
      'creationDate': creationDate.millisecondsSinceEpoch,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  List<Map<String, dynamic>> tasksToJson(List<Task> tasks) {
    return tasks.map((task) => task.toJson()).toList();
  }

  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      name: map['name'],
      description: map['description'],
      taskStatus: TaskStatus.values[map['taskStatus']],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
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

int _taskStatusToInt(TaskStatus status) => status.index;

TaskStatus _intToTaskStatus(int index) => TaskStatus.values[index];

List<Map<String, dynamic>> tasksToJson(List<Task> tasks) {
  return tasks.map((task) => task.toJson()).toList();
}

List<Task> tasksFromJson(List<Map<String, dynamic>> jsonList) {
  return jsonList.map(Task.fromJson).toList();
}
