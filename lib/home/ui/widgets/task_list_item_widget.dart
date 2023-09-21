import 'package:dns_test/home/data/task_dto.dart';
import 'package:dns_test/home/ui/widgets/task_card_buttons.dart';
import 'package:dns_test/home/ui/widgets/task_status_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskListItemWidget extends StatelessWidget {
  final Task task;
  const TaskListItemWidget(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TaskStatusLabel(task.taskStatus),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Created on: ${DateFormat(
                            'dd.MM.yy - hh:mm',
                          ).format(task.creationDate.toLocal())}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        TaskCardButtons(task),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
