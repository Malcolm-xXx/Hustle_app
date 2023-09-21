import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hustle/FadeAnimation.dart';
import 'package:hustle/Global/global.dart';
import 'package:hustle/Assistance/assistance_method.dart';
import 'package:hustle/Screen/main_screen.dart';
import 'package:hustle/Screen/login_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // startTimer(){
  //   Timer(Duration(seconds: 3), () async{
  //     if (await firebaseAuth.currentUser != null){
  //       firebaseAuth.currentUser != null ? AssistanceMethods.readCurrentOnlineUserInfo() : null;
  //       Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
  //     }
  //     else{
  //       Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
  //     }
  //   });
  // }


   startTimer() {
    Timer(Duration(seconds: 3), () async {
      if (await firebaseAuth.currentUser != null) {
        firebaseAuth.currentUser != null ? AssistanceMethods.readCurrentOnlineUserInfo() : null;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => LoginScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    //TODO:implement initState
    super.initState();

    startTimer();
  }



  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage( 'asset/images/dspash.jpeg',
            ),
            fit: BoxFit.cover
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.black12, Colors.yellow]
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: FadeAnimation(1, Text("Hustler", style: TextStyle(fontFamily:'font1' , color: Colors.amber.shade400, fontSize: 80),)),

            ),
          ),
        ),

    );
  }
}
