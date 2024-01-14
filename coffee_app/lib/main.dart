import 'dart:async';

import 'package:coffee_app/Auth/login.dart';
import 'package:coffee_app/Providers/cart_provider.dart';
import 'package:coffee_app/Screen/myHomepage.dart';
import 'package:coffee_app/Widget/myTab.dart';
import 'package:coffee_app/Screen/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/splash_services.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';




Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(create: (_) => CartProvider(),
   child:Builder(builder: (BuildContext context) {
       return 
   MaterialApp(
      home:MyMain(),
      title: 'Drinks Amor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink ,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 241, 125, 164)),
        useMaterial3: true,
      ),
      
       );
   },)
 ,);
  }
  
}

class MyMain extends StatefulWidget {
   

  MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {
   final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context) =>  (_auth.currentUser==null)?
        LoginScreen():
        MyHomePage()))); }


  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
