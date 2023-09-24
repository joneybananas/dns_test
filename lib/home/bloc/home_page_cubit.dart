import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns_test/home/data/task_dto.dart';
import 'package:dns_test/home/domain/task_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final TaskRepository _taskRep;

  HomePageCubit(this._taskRep) : super(HomePageState());

  Future<void> init() async {
    emit(state.copy(isLoading: true));
    try {
      final taskSteam = _taskRep.getTaskStream();
      log(taskSteam.toString());
      emit(state.copy(taskStream: taskSteam, isLoading: false));
      log('WTF2');
    } on FirebaseException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      log('ERROR');
      emit(state.copy(errorMessage: ''));
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
          creationDate: DateTime.now(),
        ),
      );
    } on FirebaseException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      emit(state.copy(errorMessage: ''));
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _taskRep.deleteTask(task.id);
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
    } on FirebaseException catch (ex) {
      emit(state.copy(errorMessage: ex.message));
      emit(state.copy(errorMessage: ''));
    }
  }
}
