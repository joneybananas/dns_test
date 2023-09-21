part of 'home_page_cubit.dart';

class HomePageState {
  final bool isLoading;
  final List<Task> tasks;
  final Stream<List<Task>> taskStream;

  HomePageState(
      {this.isLoading = true, this.tasks = const [], this.taskStream = const Stream.empty()});

  HomePageState copy({
    bool? isLoading,
    List<Task>? tasks,
    Stream<List<Task>>? taskStream,
  }) =>
      HomePageState(
        isLoading: isLoading ?? this.isLoading,
        tasks: tasks ?? this.tasks,
        taskStream: taskStream ?? this.taskStream,
      );
}
