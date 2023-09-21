import 'package:dns_test/home/bloc/home_page_cubit.dart';
import 'package:dns_test/home/data/task_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCardButtons extends StatelessWidget {
  final Task task;
  const TaskCardButtons(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    final status = task.taskStatus;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (status == TaskStatus.open) ...[
          IconButton(onPressed: () => _onDeletePress(context), icon: const Icon(Icons.delete)),
          IconButton(
            onPressed: () => context.read<HomePageCubit>().nextTaskStatus(task),
            icon: const Icon(Icons.done),
          )
        ],
        if (status == TaskStatus.inProgress) ...[
          IconButton(
            onPressed: () => context.read<HomePageCubit>().nextTaskStatus(task),
            icon: const Icon(Icons.done_all),
          )
        ],
      ],
    );
  }

  _onDeletePress(BuildContext context) async {
    final q = await showDeleteConfirmationDialog(context);
    if (q ?? false) {
      context.read<HomePageCubit>().deleteTask(task);
    }
  }
}

Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Подтверждение'),
        content: Text('Вы действительно хотите удалить этот элемент?'),
        actions: <Widget>[
          TextButton(
            child: Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('Удалить'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
