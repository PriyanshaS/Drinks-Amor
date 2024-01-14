import 'package:coffee_app/Widget/myButton.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/Screen/myHomepage.dart';

class Verify extends StatefulWidget {
   final verificationId ;
  const Verify({super.key,this.verificationId});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
 bool loading=false;
  final _auth = FirebaseAuth.instance;
  final verifyCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple[100], title: Text('VERIFY'),) ,
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            decoration: InputDecoration(hintText: 'Enter Verify Code' , hintStyle: TextStyle(color: Colors.grey[300] , fontSize: 15)),
            controller: verifyCodeController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if(value==null){
                Utils().flutterToast("Enter verify code");
              }
            },
          ),
        ), 
        SizedBox(height: 30,),
        myButton(title: 'VERIFY',loading: loading, onTap : ()async{
          setState(() {
            loading=true;
          });
          final credential = PhoneAuthProvider.credential(
            verificationId: widget.verificationId,
            smsCode: verifyCodeController.text.toString()
          );
          try{

            await _auth.signInWithCredential(credential);
            setState(() {
              loading=true;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          }
          catch(e){
            setState(() {
              loading=false;
            });
            Utils().flutterToast(e.toString());
          }
          })],
      ),
    );
  }
}