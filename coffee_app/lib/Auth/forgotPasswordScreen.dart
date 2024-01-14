import 'package:coffee_app/Widget/myButton.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('FORGOT PASSWORD' ,style: TextStyle(color: Colors.white),),
          backgroundColor:Colors.purple[100],
        ),
        body:Column(
          children: [Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller:emailController ,
              decoration: InputDecoration(border: UnderlineInputBorder(),
              hintText: 'Enter Email To Reset Password' , hintStyle: TextStyle(color: Colors.grey[400]),
              ),
              
            ),
          ), 
          SizedBox(height: 30,),
          myButton(title: 'Reset Password', onTap: () {
            _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
              Utils().flutterToast('Sending password reset link through mail.\n Please check you inbox. Also check spam folder');
            }).onError((error, stackTrace){ Utils().flutterToast(error.toString());});

          },)],
        ) ,
    );
  }
}