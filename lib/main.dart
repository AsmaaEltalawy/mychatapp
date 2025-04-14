import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mychatapp/screens/auth_screen.dart';
import 'package:mychatapp/screens/login_screen.dart';
import 'package:mychatapp/screens/register_screen.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          backgroundColor: Color(0xFF264131),
          splashTransition: SplashTransition.fadeTransition,
          splash: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Go',
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
                Text(
                  'GREEN',
                  style: TextStyle(fontSize: 60, color: Color(0xFF99DAB3)),
                )
              ],
            ),
          ),
          nextScreen: AuthScreen()),
      routes: {'/registerScreen': (context) => RegisterScreen()},
    );
  }
}
