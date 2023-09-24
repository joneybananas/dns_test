part of 'home_page_cubit.dart';

class HomePageState {
  final bool isLoading;

  final Stream<List<Task>> taskStream;
  final String errorMessage;

  HomePageState(
      {this.isLoading = true, this.taskStream = const Stream.empty(), this.errorMessage = '',});

  HomePageState copy({
    bool? isLoading,
    Stream<List<Task>>? taskStream,
    String? errorMessage,
  }) =>
      HomePageState(
        isLoading: isLoading ?? this.isLoading,
        taskStream: taskStream ?? this.taskStream,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
