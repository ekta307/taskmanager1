import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasksmanagement/model/task_model.dart';

class DatabaseService {
  final CollectionReference taskCollection =
  FirebaseFirestore.instance.collection("tasks");

  final User? user = FirebaseAuth.instance.currentUser;

  // Add Task Item
  Future<DocumentReference> addTaskItem(String title, String description) async {
    return await taskCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update Task Title and Description
  Future<void> updateTask(String id, String title, String description) async {
    await taskCollection.doc(id).update({
      'title': title,
      'description': description,
    });
  }

  // Update Task Status (Completed or Pending)
  Future<void> updateTaskStatus(String id, bool completed) async {
    await taskCollection.doc(id).update({'completed': completed});
  }

  // Delete Task Item
  Future<void> deleteTaskStatus(String id) async {
    await taskCollection.doc(id).delete();
  }

  // Stream of Pending Tasks
  Stream<List<Tasks>> get tasks {
    return taskCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_taskListFromSnapshot);
  }

  // Stream of Completed Tasks
  Stream<List<Tasks>> get completedTasks {
    return taskCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_taskListFromSnapshot);
  }

  // Convert Firestore Snapshot to Task List
  List<Tasks> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Tasks(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'] ?? false,
        timestamp: doc['createdAt'] ?? '');
    }).toList();
  }
}
