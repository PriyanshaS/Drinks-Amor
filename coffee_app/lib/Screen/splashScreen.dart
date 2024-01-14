import 'package:flutter/material.dart';
import '../Services/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
    void initState() {
      super.initState();
    splashServices.isLogin(context);}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('PREPARING DRINKS FOR YOU...' , style: TextStyle(color:Colors.grey[500],fontSize: 20),)),
    );
  }
}