import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasksmanagement/model/task_model.dart';
import 'package:tasksmanagement/services/database_services.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({super.key});

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  final User? user = FirebaseAuth.instance.currentUser;
  final DatabaseService _databaseService = DatabaseService();
  late String uid;

  @override
  void initState() {
    super.initState();
    uid = user?.uid ?? ""; // Handle the case where user might be null
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tasks>>(
      stream: _databaseService.completedTasks, // Ensure this stream is correct
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
                'No completed tasks found.',
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
                        icon: Icons.delete,
                        label: "Delete",
                        onPressed: (context) {
                          _databaseService.deleteTaskStatus(task.id);
                        },
                      ),
                    ],
                  ),
                  startActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [],
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
}
