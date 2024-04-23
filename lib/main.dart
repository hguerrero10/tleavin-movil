import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/startup/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inicio',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(242, 211, 0, 1),
      ),
      home: inicio()
    );
  }

  Widget inicio() {
    Widget page;
    if(itemP.usuario?.numeroEmpleado != null) {
      page = const InicioScreen();
    } 
    else {
      page = const LoginScreen();
    }
    return page;
  }
}