import 'package:dns_test/common_widgets/snacbars.dart';
import 'package:dns_test/home/data/task_dto.dart';
import 'package:dns_test/home/ui/widgets/task_status_label.dart';
import 'package:dns_test/task/bloc/task_cubit.dart';
import 'package:dns_test/task/ui/widgets/bottom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  static Route route(String taskId) => MaterialPageRoute(builder: (_) => TaskPage(taskId));

  final String taskId;

  const TaskPage(this.taskId, {super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TaskCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = TaskCubit(widget.taskId, context.read())..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            showErrorSnackBar(context, state.errorMessage);
          }
        },
        listenWhen: (previous, current) => previous.errorMessage != current.errorMessage,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Детали задачи'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
              builder: (context) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final task = state.task!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.name, style: Theme.of(context).textTheme.headlineMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat(
                            'dd.MM.yy - hh:mm',
                          ).format(task.creationDate.toLocal()),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        TaskStatusLabel(task.taskStatus),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(task.description),
                  ],
                );
              },
            ),
          ),
          persistentFooterButtons: [
            if (state.task?.taskStatus == TaskStatus.open)
              BottomButtonWidget(
                onPress: () =>
                    _cubit.deleteTask(state.task!).then((value) => Navigator.of(context).pop()),
                icon: Icons.delete,
                label: 'Удалить',
              ),
            if (state.task?.taskStatus == TaskStatus.open)
              BottomButtonWidget(
                onPress: () async => _cubit.nextTaskStatus(state.task!),
                icon: Icons.done,
                label: 'Взять в работу',
              ),
            if (state.task?.taskStatus == TaskStatus.inProgress)
              BottomButtonWidget(
                onPress: () async => _cubit.nextTaskStatus(state.task!),
                icon: Icons.done_all,
                label: 'завершить',
              ),
          ],
          persistentFooterAlignment: AlignmentDirectional.center,
        ),
      ),
    );
  }
}
