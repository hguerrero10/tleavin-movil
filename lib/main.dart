import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/startup/login/login_screen.dart';
// import 'package:tleavin_mobil/src/startup/splash.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inicio',
      theme: ThemeData(
        colorSchemeSeed: Color.fromRGBO(242, 211, 0, 1),
      ),
      home: LoginScreen(),
      // home: SplashScreen(),
    );
  }
}