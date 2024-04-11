import 'dart:developer';

import 'package:flutter/material.dart';

class DetalleDeViaje extends StatefulWidget {
  final viaje;
  const DetalleDeViaje({super.key, this.viaje});

  @override
  State<DetalleDeViaje> createState() => _DetalleDeViajeState();
}


class _DetalleDeViajeState extends State<DetalleDeViaje> {
  @override
  void initState() {
    // log(widget.viaje.toString());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Detalle del Viaje',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: [

                // Expanded(child: viajes(listaViajes))
              ]
            )
          )
        ]
      )
    );
  }
}