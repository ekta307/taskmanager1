import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasksmanagement/model/task_model.dart';
import 'package:tasksmanagement/services/database_services.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({super.key});

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
  final User? user = FirebaseAuth.instance.currentUser;
  late String uid;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    uid = user?.uid ?? ""; // Ensure safe handling of user
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tasks>>(
      stream: _databaseService.tasks, // Stream of pending tasks
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (snapshot.hasData) {
          final List<Tasks> tasks = snapshot.data!;
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                'No pending tasks.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final Tasks task = tasks[index];
              final DateTime dt = task.timestamp.toDate();

              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  key: ValueKey(task.id),
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        icon: Icons.done,
                        label: "Mark",
                        onPressed: (context) {
                          _databaseService.updateTaskStatus(task.id, true);
                        },
                      ),
                      SlidableAction(
                        icon: Icons.edit,
                        label: "Edit",
                        onPressed: (context) {
                          _showTaskDialog(context, task: task);
                        },
                      ),
                      SlidableAction(
                        icon: Icons.delete,
                        label: "Delete",
                        onPressed: (context) {
                          _databaseService.deleteTaskStatus(task.id);
                        },
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(task.description),
                    trailing: Text(
                      '${dt.day}/${dt.month}/${dt.year}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: Text(
            'No data available.',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void _showTaskDialog(BuildContext context, {Tasks? task}) {
    final TextEditingController _titleController =
    TextEditingController(text: task?.title);
    final TextEditingController _descriptionController =
    TextEditingController(text: task?.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            task == null ? "Add Task" : "Edit Task",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final String title = _titleController.text.trim();
                final String description = _descriptionController.text.trim();

                if (title.isEmpty || description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Title and description cannot be empty")),
                  );
                  return;
                }

                if (task == null) {
                  // Add new task
                  await _databaseService.addTaskItem(title, description);
                } else {
                  // Update existing task
                  await _databaseService.updateTask(task.id, title, description);
                }

                Navigator.pop(context);
              },
              child: Text(task == null ? "Add" : "Update"),
            ),
          ],
        );
      },
    );
  }
}
