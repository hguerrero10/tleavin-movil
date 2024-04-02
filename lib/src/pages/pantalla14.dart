import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class Pantalla14 extends StatefulWidget {
  const Pantalla14({super.key});

  @override
  State<Pantalla14> createState() => _Pantalla14State();
}

class _Pantalla14State extends State<Pantalla14> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 14'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Cuerpo(),
              const SizedBox(height: 60),
              Center(
                child: Image.asset(
                  'assets/img/logistica.png',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Embarque en Camino',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}