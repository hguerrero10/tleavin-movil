import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/startup/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm()
    );
  }
}