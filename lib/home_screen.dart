import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasksmanagement/login_screen.dart';
import 'package:tasksmanagement/model/task_model.dart';
import 'package:tasksmanagement/services/auth_services.dart';
import 'package:tasksmanagement/services/database_services.dart';
import 'package:tasksmanagement/widgets/completed_widget.dart';
import 'package:tasksmanagement/widgets/pending_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _buttonIndex= 0;
  final _widgets=[
    PendingWidget(),
    CompletedWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("Task Manager"),
        actions: [
          IconButton(onPressed: () async{
            await AuthServices().signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=> LoginScreen()));
    },
      icon: Icon(Icons.exit_to_app),
      ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      _buttonIndex=0;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex == 0? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text("Pending",
                      style: TextStyle(
                        fontSize: _buttonIndex==1 ? 16: 14,
                        fontWeight: FontWeight.w500,
                        color: _buttonIndex== 0? Colors.white: Colors.black38,
                      ),
                      ),

                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){
                    setState(() {
                      _buttonIndex=1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex ==1? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text("Completed",
                        style: TextStyle(
                          fontSize: _buttonIndex==1 ? 16: 14,
                          fontWeight: FontWeight.w500,
                          color: _buttonIndex== 1? Colors.white: Colors.black38,
                        ),
                      ),

                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            _widgets[_buttonIndex],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          _showTaskDialog(context);
        },
      ),
    );
  }

  void _showTaskDialog(BuildContext context, {Tasks? tasks}){
    final TextEditingController _titleController = TextEditingController(text: tasks ?.title);
    final TextEditingController _descriptionController= TextEditingController(text: tasks ?.description);
    final DatabaseService _databaseService= DatabaseService() ;

    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor:  Colors.white,
        title: Text( tasks == null ? "Add Task" : "Edit Task",
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
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
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          },
            child: Text("Cancel"),
          ),
          ElevatedButton(onPressed: () async{
            if (tasks ==null){
              await _databaseService.addTaskItem(_titleController.text,_descriptionController.text);
            }
            else{
              await _databaseService.updateTaskStatus(tasks.id, _titleController.text as bool);
              }
            Navigator.pop(context);
          },
            child: Text(tasks == null ? "Add" : "Update"),
          )
        ],
      );
    });

  }
}
