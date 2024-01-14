import 'package:coffee_app/Auth/forgotPasswordScreen.dart';
import 'package:coffee_app/Auth/loginWithPhoneNumber.dart';
import 'package:coffee_app/Auth/signup.dart';
import 'package:coffee_app/Widget/myButton.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:coffee_app/Screen/myHomepage.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading =false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('LOG IN' ,style: TextStyle(color: Colors.white),),
          backgroundColor:Colors.purple[100],
        ),
        body: SingleChildScrollView(
          child: Form(
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
                Center(child: myButton(title:"LOG IN",loading: loading, onTap: () {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                       loading=true;
                    });
                    _auth.signInWithEmailAndPassword(email:emailController.text, 
                    password: passwordController.text.toString()).then((value) {
                      setState(() {
                       loading=false;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
                    }).onError((error, stackTrace)
                     {Utils().flutterToast(error.toString());
                      setState(() {
                       loading=false;
                    });});
                    
                  }
                },)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    
                    child:Padding(
                      padding: const EdgeInsets.only(right : 12.0),
                      child: Text('Forgot Password' , style: TextStyle(color:Colors.blue),),
                    ) , onPressed:() =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>ForgotPasswordScreen() ,))),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Don\'t have an account? '),
                  InkWell(child: Text('Sign Up',style: TextStyle(color: Colors.blue),), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),)),)
                ],)
                , 
                SizedBox(height: 20,)
                , Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(height: 1 ,width: double.infinity,child: Container(color: Colors.grey,)),
                ),              SizedBox(height: 20,)
          ,
                
                myButton(title:'Login with Phone Number' , onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => loginWithPhone(),));
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}