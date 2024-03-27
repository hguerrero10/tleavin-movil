import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/startup/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inicio',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(242, 211, 0, 1),
      ),
      home: const LoginScreen()
    );
  }
}