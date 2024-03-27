import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/startup/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginForm()
    );
  }
}