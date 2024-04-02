import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/src/pages/vin/registro_vin.dart';
import 'package:tleavin_mobil/src/pages/dano/registro_unidad_ss.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'dano/registro_dano.dart';

class InspeccionVin extends StatefulWidget {

  final vin;
  const InspeccionVin({super.key, this.vin});

  @override
  State<InspeccionVin> createState() => _InspeccionVinState();
}

class _InspeccionVinState extends State<InspeccionVin> {

  @override
  void initState() {
    getVins();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Inspeccion VIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const CompraVin()), (Route<dynamic> route) => false)
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
             Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Registro de Daños',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'VIN: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.vin,
                        style: const TextStyle(
                          fontSize: 17
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 360,
                height: 440,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/inspeccion_vehiculo.jpg'),
                    fit: BoxFit.fill
                  )
                ),
                child: Stack(
                  children: [
                    _boton(30, 115, 'Frente', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'Frente')),
                      )
                    }),
                    _boton(140, 115, 'Interior', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'Interior')),
                      )
                    }),
                    _botonVertical(160, 40, 1, 'Izquierda', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'Izquierda')),
                      )
                    }),
                    _boton(230, 115, 'Arriba', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'Arriba')),
                      )
                    }),
                    _botonVertical(160, 290, 3, 'Derecha', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'Derecha')),
                      )
                    }),
                    _boton(390, 115, 'Tracera', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'Tracera')),
                      )
                    }),
                    _boton(330, 205, 'Accesorios', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'Accesorios')),
                      )
                    })
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroUnidadSS(vin: widget.vin, tipo: 'Unidad Sucia')),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                    ),
                  ),
                  child: const Text(
                    'Unidad Sucia',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroUnidadSS(vin: widget.vin, tipo: 'Unidad Sin Daños')),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                    ),
                  ),
                  child: const Text(
                    'Sin Daños',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ]
        )
      )
    );
  }

  Future getVins() async {
    try{
      await DatabaseProvider.db.obtenerListaVins().then((value) {
        setState(() {
          log('vins => $value');
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }
  }

  Widget _boton(double top, double left, String text, onTap) {
    return Positioned(
      top: top,
      left: left,
      child:  SizedBox(
        height: 30,
        width: 130,
        child: ElevatedButton(
          style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonVertical(double top, double left, int rote, String text, onTap) {
    return Positioned(
      top: top,
      left: left,
      child: RotatedBox(
        quarterTurns: rote,
        child: SizedBox(
          height: 30,
          width: 130,
          child: ElevatedButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
            onPressed: onTap,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
          ),
        ),
      )
    );
  }
}