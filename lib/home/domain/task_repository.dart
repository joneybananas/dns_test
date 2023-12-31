import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns_test/home/data/task_dto.dart';
import 'package:home_widget/home_widget.dart';

class TaskRepository {
  final FirebaseFirestore firestore;
  final String androidWidgetName = 'NewAppWidget';

  TaskRepository(this.firestore);

  Future<Task> createTask(Task task) async {
    final docRef = firestore.collection('task').doc();
    final newTask = Task(
      id: docRef.id,
      name: task.name,
      description: task.description,
      taskStatus: task.taskStatus,
      creationDate: task.creationDate,
    );
    await docRef.set(task.toMap());
    return newTask;
  }

  Future<void> updateTask(Task task) async {
    try {
      await firestore.collection('task').doc(task.id).update(task.toMap());
    } catch (_) {}
  }

  Future<void> deleteTask(String id) async {
    try {
      await firestore.collection('task').doc(id).delete();
    } catch (_) {}
  }

  Future<Task?> getTask(String id) async {
    final doc = await firestore.collection('task').doc(id).get();
    if (doc.exists) {
      return Task.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
  }

  Future<List<Task>> getTasks() async {
    final querySnapshot = await firestore.collection('task').get();
    return querySnapshot.docs.map((doc) {
      return Task.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Stream<List<Task>> getTaskStream() {
    return firestore
        .collection('task')
        .orderBy('creationDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromMap(doc.data(), doc.id);
      }).toList();
    })
      ..listen((event) {
        HomeWidget.saveWidgetData<String>('task_list', jsonEncode(tasksToJson(event)))
            .then((value) => HomeWidget.updateWidget(androidName: androidWidgetName));
      });
  }
}
