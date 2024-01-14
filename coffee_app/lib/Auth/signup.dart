import 'package:coffee_app/Auth/login.dart';
import 'package:coffee_app/Widget/myButton.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text('SIGN UP' ,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple[100],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: emailController,
                decoration:InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))) ,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Email';
                    }
                    else 
                    return null;
                  },
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration:InputDecoration(
                  suffixIcon: Icon(Icons.password),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))) ,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Password';
                    }
                    else
                    return null;
                  },
              ),
            ),
            SizedBox(height: 30,),
            Center(child: myButton(title:"SIGNUP", loading:isLoading,onTap: () {
              if(_formKey.currentState!.validate()){
                setState(() {
                   isLoading=true;
                });
                _auth.createUserWithEmailAndPassword(email: emailController.text.toString(),
                 password: passwordController.text.toString()).then((value){
                   setState(() {
                   isLoading=false;
                });
                 } ).onError((error, stackTrace){
                   setState(() {
                   isLoading=false;
                });
                   Utils().flutterToast(error.toString());});
              }
            },)),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Don\'t have an account? '),
              InkWell(child: Text('Log In' , style: TextStyle(color: Colors.blue),), onTap: () => Navigator.pop(context))
            ],),
          ],
        ),
      ),
    );
  }
}