part of 'task_cubit.dart';

class TaskState {
  final bool isLoading;
  final Task? task;

  final String errorMessage;

  TaskState({
    this.isLoading = true,
    this.task,
    this.errorMessage = '',
  });

  TaskState copy({
    bool? isLoading,
    Task? task,
    String? errorMessage,
  }) =>
      TaskState(
        errorMessage: errorMessage ?? this.errorMessage,
        isLoading: isLoading ?? this.isLoading,
        task: task ?? this.task,
      );
}
