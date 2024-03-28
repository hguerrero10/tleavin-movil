import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/inspeccion_vin.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:developer';
class CompraVin extends StatefulWidget {
  const CompraVin({super.key});

  @override
  State<CompraVin> createState() => _CompraVinState();
}

class _CompraVinState extends State<CompraVin> {
  final _qrTextController = TextEditingController();
  var qrbar = '';

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", true, ScanMode.QR);
      _qrTextController.text = barcodeScanRes;
    } 
    catch (e) {
      log('Error al escanear: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'VIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false)
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //     //border: Border.all(),
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //   child: const Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text('Unidad: TLEA-458', style: TextStyle(fontSize: 18.0)),
            //       Text('Bitacora: 789654', style: TextStyle(fontSize: 18.0)),
            //       Text('Carta Porte: CMTY-745632', style: TextStyle(fontSize: 18.0)),
            //       Text('Cliente: Mazda', style: TextStyle(fontSize: 18.0)),
            //       Text('Origen: ', style: TextStyle(fontSize: 18.0)),
            //       Text('Destino: ', style: TextStyle(fontSize: 18.0)),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 20),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         'Verificado 1 de 8',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            const SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       'assets/img/codeBarras.png',
            //       width: 190,
            //       height: 200,
            //     ),
            //     SizedBox(width: 10),
            //     Image.asset(
            //       'assets/img/codeQR.png',
            //       width: 160,
            //       height: 190,
            //     ),
            //   ],
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                          scanQR();
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
                        'Escanear VIN',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _qrTextController,
                    maxLength: 17,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      hintText: 'VIN',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      qrbar = _qrTextController.text;

                    if(_qrTextController.text.isNotEmpty && (_qrTextController.text.length >= 17)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InspeccionVin(vin: qrbar)),
                      );
                    } 
                    else {
                        Fluttertoast.showToast(
                        msg: "Escanear o Escribir VIN",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 20
                      );
                    }

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
                      'Realizar Inspeccion',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  )
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
}
