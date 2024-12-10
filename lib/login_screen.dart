import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasksmanagement/home_screen.dart';
import 'package:tasksmanagement/services/auth_services.dart';
import 'package:tasksmanagement/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthServices _auth= AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text("Welcome Back",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),

              Text("Login Here",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),
              SizedBox(height: 20),
              TextField(
                controller:  _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white60)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white60,)),
              ),
              SizedBox(height: 20),
              TextField(
                controller:  _passController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white60)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white60,)),
              ),
              SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                child:  ElevatedButton(onPressed: ()async{
                  User? user = await  _auth.signInWithEmailAndPassword(
                      _emailController.text,
                      _passController.text
                  );
                  if(user!= null){
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context)=>HomeScreen(),
                    ));
                  }
                },
                  child: Text("Register",style: TextStyle(
                      color:  Colors.indigo,
                      fontSize: 18
                  ),
                  ),),
              ),
              SizedBox(height: 30),
              Text("OR", style:
              TextStyle(color: Colors.white)),
              SizedBox(height: 30),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> SignupScreen(),
                ));
              },
                child: Text("Create Account", style: TextStyle(color: Colors.blue,
                    fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

