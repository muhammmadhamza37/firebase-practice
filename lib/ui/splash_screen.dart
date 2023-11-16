import 'package:firebase_practice/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


   SplashServices  SplashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Firebase Practice',style: TextStyle(fontSize: 30),),
      ),
    );
  }
}


