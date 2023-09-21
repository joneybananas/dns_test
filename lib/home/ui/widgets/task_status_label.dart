import 'package:dns_test/home/data/task_dto.dart';
import 'package:flutter/material.dart';

class TaskStatusLabel extends StatelessWidget {
  final TaskStatus taskStatus;
  const TaskStatusLabel(this.taskStatus, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: _getStatusColor(taskStatus, context),
        shape: const StadiumBorder(),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        taskStatus.name,
      ),
    );
  }

  Color _getStatusColor(TaskStatus taskStatus, context) {
    switch (taskStatus) {
      case TaskStatus.open:
        return Theme.of(context).primaryColorLight;
      case TaskStatus.inProgress:
        return Colors.orangeAccent;
      case TaskStatus.done:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
