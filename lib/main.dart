import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:hustle/Screen/main_screen.dart';
import 'package:hustle/Themeprovider/theme_provider.dart';
import 'package:hustle/Screen/registration_screen.dart';
import 'package:hustle/Screen/registration_screen2.dart';
import 'package:hustle/Screen/login_screen.dart';
import 'package:hustle/Splashscreen/splash_screen.dart';




// void main() {
//   runApp(const MyApp());
//
// }


Future <void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hustle',
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      debugShowCheckedModeBanner: false,

         //home: RegistrationScreen2(),
      // home: RegistrationScreen(),
      //home: MainScreen(),
         //home: LoginScreen (),
      home : SplashScreen(),
    );
  }
}
