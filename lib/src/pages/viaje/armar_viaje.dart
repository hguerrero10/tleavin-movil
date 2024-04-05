import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class ArmarViaje extends StatefulWidget {
  const ArmarViaje({super.key});

  @override
  State<ArmarViaje> createState() => _ArmarViajeState();
}

class _ArmarViajeState extends State<ArmarViaje> {

  final _viajeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Viaje',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),




           
          ],
        ),
      ),
    );
  }
}
