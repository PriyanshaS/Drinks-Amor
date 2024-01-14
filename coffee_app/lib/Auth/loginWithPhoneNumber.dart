import 'package:coffee_app/Auth/verify.dart';
import 'package:coffee_app/Widget/myButton.dart';
import 'package:coffee_app/Widget/toast.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginWithPhone extends StatefulWidget {
  const loginWithPhone({super.key});

  @override
  State<loginWithPhone> createState() => _loginWithPhoneState();
}

class _loginWithPhoneState extends State<loginWithPhone> {
  bool loading=false;
  final _auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  
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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                 Expanded(
                  flex :1,
                   child: TextFormField(
                    onTap: () {
                      showCountryPicker(context: context, onSelect: (value) {
                        print(value.phoneCode);
                        countryCodeController.text = '+'+ value.phoneCode;
                      },);
                    },
                     controller: countryCodeController,
                     decoration:InputDecoration(
                       hintText: '+1',
                       hintStyle: TextStyle(color: Colors.grey[500] , ),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))) ,
                       
                   ),
                 ),
                 SizedBox(width: 10,),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    
                    controller: phoneNumberController,
                    decoration:InputDecoration(
                      suffixIcon: Icon(Icons.phone),
                      hintText: 'Enter Phone Number',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))) ,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter phone number';
                        }
                        else 
                        return null;
                      },
                  ),
                ),
              ],
            ),
          ), 
        SizedBox(height: 30,),
        myButton(title: 'SEND OTP',loading: loading, onTap : (){
          setState(() {
            loading= true;
          }); 
            
          _auth.verifyPhoneNumber(
            phoneNumber: countryCodeController.text + phoneNumberController.text,
            verificationCompleted: (_) {
              setState(() {
                loading=false;
                print(countryCodeController.text + phoneNumberController.text);
              });
            }, 
          verificationFailed:(error) {
            setState(() {
                loading=false;
              });
            Utils().flutterToast(error.toString());},
          codeSent: (verificationId, forceResendingToken) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(verificationId: verificationId,),));},
          codeAutoRetrievalTimeout:(error){
            setState(() {
                loading=false;
              });
            },);
          })],
      ),
    );
  }
}