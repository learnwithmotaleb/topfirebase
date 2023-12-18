import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:topfirebase/Dashboard_Screen.dart';
import 'package:topfirebase/Loging_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
   goToLogin();
    super.initState();
  }

  goToLogin(){
    final auth = FirebaseAuth.instance;
    final user =auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 2),()=>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen())));
    }else{
      Timer(const Duration(seconds: 2),()=>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Screen())));
    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("FLUTTER FIREBASE",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.blue
          ),),
        ),)
    );
  }
}
