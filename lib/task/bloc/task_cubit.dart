import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns_test/home/data/task_dto.dart';
import 'package:dns_test/task/domain/task_card_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final String _taskId;
  final TaskCardRepository _taskRep;
  TaskCubit(this._taskId, this._taskRep) : super(TaskState());

  Future<void> init() async {
    emit(state.copy(isLoading: true));
    try {
      final task = await _taskRep.getTask(_taskId);
      emit(state.copy(isLoading: false, task: task));
    } on FirebaseException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      emit(state.copy(errorMessage: ''));
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _taskRep.deleteTask(task.id);
      emit(state.copy(task: null));
    } on FirebaseException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      emit(state.copy(errorMessage: ''));
    }
  }

  Future<void> nextTaskStatus(Task task) async {
    TaskStatus nextStatus;
    switch (task.taskStatus) {
      case TaskStatus.open:
        nextStatus = TaskStatus.inProgress;
        break;
      case TaskStatus.inProgress:
        nextStatus = TaskStatus.done;
        break;
      case TaskStatus.done:
        nextStatus = TaskStatus.done;
        break;
    }
    final newTask = Task.fromTaskWithNewStatus(task, nextStatus);
    try {
      await _taskRep.updateTask(newTask);
      emit(state.copy(task: newTask));
    } on FirebaseException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      emit(state.copy(errorMessage: ''));
    }
  }
}
