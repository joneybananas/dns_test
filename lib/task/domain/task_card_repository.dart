
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns_test/home/data/task_dto.dart';

class TaskCardRepository {
  final FirebaseFirestore firestore;

  TaskCardRepository(this.firestore);

  Future<void> updateTask(Task task) async {
    try {
      await firestore.collection('task').doc(task.id).update(task.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await firestore.collection('task').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<Task?> getTask(String id) async {
    final doc = await firestore.collection('task').doc(id).get();
    if (doc.exists) {
      return Task.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
  }
}
