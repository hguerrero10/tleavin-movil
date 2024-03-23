import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/bodycontent.dart';

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
             padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                //border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Cuerpo(),
              SizedBox(height: 60),
              Center(
                child: Image.asset(
                  'assets/img/logistica.png',
                  width: 250,
                  height: 250,
                ),
              ),
               SizedBox(height: 30),
              Text(
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