import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class ArmarViaje extends StatefulWidget {
  const ArmarViaje({super.key});

  @override
  State<ArmarViaje> createState() => _ArmarViajeState();
}

class _ArmarViajeState extends State<ArmarViaje> {

  final _ecoTextController = TextEditingController();
  final _nombreOpTextController = TextEditingController();
  final _origenTextController = TextEditingController();
  final _destinoTextController = TextEditingController();

  var listaVinsViaje = [];
  String? vinEscaneado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Armar Viaje',
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

            _titulo('Numero Eco.'),
            _inputs(_ecoTextController, 'Escriba Numero Economico', TextInputType.number),
            const SizedBox(height: 10),

            _titulo('Nombre Operador'),
            _inputs(_nombreOpTextController, 'Escriba Nombre del Operador', TextInputType.text),
            const SizedBox(height: 10),

            _titulo('Origen'),
            _inputs(_origenTextController, 'Escriba el Origen del Viaje', TextInputType.text),
            const SizedBox(height: 10),

            _titulo('Destino '),
            _inputs(_destinoTextController, 'Escriba el Destino del Viaje', TextInputType.text),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () => scanQR(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(15)),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  )
                ),
                child: const Text(
                  'Seleccionar Vin',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  )
                )
              )
            ),
            const SizedBox(height: 30),
            // vinEscaneado != null ? Expanded(child: vinsSeleccionados(vinEscaneado)) : const SizedBox(),
            const SizedBox(height: 30)
          ]
        )
      )
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", true, ScanMode.QR);
      vinEscaneado = barcodeScanRes;

      checarVinParaViaje(vinEscaneado);
    } 
    catch (e) {
      log('Error al escanear: $e');
    }
  }
  
  Future checarVinParaViaje(v) async {
    try{
      await DatabaseProvider.db.checarVinParaViaje(v).then((value) {
        setState(() {
          var vinvalido = value.length;
          
          if(vinvalido > 0) {
            listaVinsViaje.add(value[0]['vin']);
          }
          else {
            Fluttertoast.showToast(
              msg: "VIN no comprado o registrado",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
            );
          }

          log(listaVinsViaje.toString());
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }
  }

  Widget _inputs(control, place, tipo) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: control,
        keyboardType: tipo,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: place,
          hintStyle: const TextStyle(
            color: Colors.grey
          )
        )
      ),
    );
  }

  Widget _titulo(tit) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        tit,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        )
      )
    );
  }

  Widget vinsSeleccionados(listav) {
    return ListView.builder(
      itemCount: listav.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Card(
            child: ListTile(
              title: Text('Vin: ${listav[index]}'),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: []
              )
            )
          )
        );
      }
    );
  }
}
