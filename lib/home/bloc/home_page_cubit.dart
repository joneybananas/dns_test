import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dns_test/home/data/task_dto.dart';
import 'package:dns_test/home/domain/task_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final TaskRepository _taskRep;

  HomePageCubit(this._taskRep) : super(HomePageState());

  void init() async {
    emit(state.copy(isLoading: true));
    try {
      final taskSteam = await _taskRep.getTasksStream();

      emit(state.copy(taskStream: taskSteam, isLoading: false));
    } catch (ex) {
      log(ex.toString());
    }
  }

  Future<void> createTask(String name, String description) async {
    try {
      final task = await _taskRep.createTask(
        Task(
            id: '',
            name: name,
            description: description,
            taskStatus: TaskStatus.open,
            creationDate: DateTime.now()),
      );
      final newList = List<Task>.from(state.tasks)..add(task);
      emit(state.copy(tasks: newList));
    } catch (_) {}
  }

  Future<void> deleteTask(Task task) async {
    await _taskRep.deleteTask(task.id);
    final newList = List<Task>.from(state.tasks)..remove(task);
    emit(state.copy(tasks: newList));
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
    await _taskRep.updateTask(newTask);
    final index = state.tasks.indexWhere((element) => element.id == task.id);
    var newList = List<Task>.from(state.tasks);
    newList[index] = newTask;
    emit(state.copy(tasks: newList));
  }
}
