import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class Pantalla10 extends StatefulWidget {
  const Pantalla10({super.key});

  @override
  State<Pantalla10> createState() => _Pantalla10State();
}

class _Pantalla10State extends State<Pantalla10> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Compra VIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Cuerpo(),
            Row(
              children: [
                Text(
                  'VIN: ',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                 'widget.vin',
                  style: TextStyle(
                    fontSize: 17
                  ),
                )
              ]
            )
          ]
        )
      )
    );
  }
}