import 'package:dns_test/home/bloc/home_page_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/task_list_item_widget.dart';

class HomePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = HomePageCubit(context.read())..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showMyModalBottomSheet(context, _cubit);
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<HomePageCubit, HomePageState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return StreamBuilder(
              stream: state.taskStream,
              builder: (context, snapshot) {
                final tasks = snapshot.data;
                if (tasks != null) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskListItemWidget(tasks[index]);
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            );
          },
        ),
      ),
    );
  }
}

void _showMyModalBottomSheet(BuildContext context, HomePageCubit cubit) {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(minHeight: 700),
      builder: (builderContext) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Название',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                    cubit
                        .createTask(nameController.text, descriptionController.text)
                        .then((value) => Navigator.of(builderContext).pop());
                  }
                },
                child: const Text('Создать'),
              ),
            ],
          ),
        );
      });
}
