import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/widgets/search.dart';

class VinsParaViaje extends StatefulWidget {
  const VinsParaViaje({super.key});

  @override
  VinsParaViajeState createState() => VinsParaViajeState();
}

class VinsParaViajeState extends State<VinsParaViaje> {
  final _qrTextController = TextEditingController();
  String query = '';
  var vins = [];

  var vinesseleccionados = [];

  var isChecked = false;

  Future<void> scanQR() async {
    String codeQrBar;
    try {
      codeQrBar = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", true, ScanMode.QR);
      setState(() {
        _qrTextController.text = codeQrBar;

        searchVIN;
      });
    } 
    catch (e) {
      log('Error al escanear: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    obtenerListaVINSComprados();
  }

  obtenerListaVINSComprados() async {
    var data = await DatabaseProvider.db.obtenerListaVinsComprados();
    var vinsComprados = [];

    for(var d in data) {
      var vi = d.vin;

      vinsComprados.add(vi);
    }

    setState(() {
      // vinsComprados = data;
      vins = vinsComprados;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
      title: const Text(
        'Lista de VINES',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        )
      )
    ),
    body: Column(
      children: <Widget>[
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => scanQR(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              )
            )
          ),
          child: const SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_2_outlined,
                  color: Colors.white,
                  size: 30
                ),
                SizedBox(width: 10),
                Text(
                  'Escanear VIN',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white
                  )
                )
              ]
            )
          )
        ),
        buildSearch(),
        vinesseleccionados.isNotEmpty ? Expanded(
          child: ListView.builder(
            itemCount: vinesseleccionados.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text("VIN: ${vinesseleccionados[index]}"),
                value: true,
                onChanged: (value) {
                  setState(() {
                    vins.add(vins[index]);
                    vinesseleccionados.remove(vinesseleccionados[index]);
                  });
                }
              );
            }
          )
        ) : const SizedBox(),
        Expanded(
          child: ListView.builder(
            itemCount: vins.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text("VIN: ${vins[index].toString()}"),
                value: false,
                onChanged: (value) {
                  setState(() {
                    vinesseleccionados.add(vins[index]);
                    vins.remove(vins[index]);
                  });
                }
              );
            }
          )
        ),
        ElevatedButton(
          // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ArmarViaje(vinesqueseleccionaron: vinesseleccionados))),
          onPressed: () {
            itemP.addVSPV(vinesseleccionados);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              )
            )
          ),
          child: const SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30
                ),
                SizedBox(width: 10),
                Text(
                  'Agregar al Viaje',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white
                  )
                )
              ]
            )
          )
        ),
        const SizedBox(height: 40)
      ]
    )
  );

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'VIN',
    onChanged: searchVIN
  );

  searchVIN(String query) {
    final vinsf = vins.where((v) {
      final titleLower = v.toLowerCase();

      if(_qrTextController.text != '') {
        final searchLower = _qrTextController.text.toLowerCase();
        return titleLower.contains(searchLower);
      }
      else {
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }
    }).toList();

    setState(() {
      this.query = query;
      vins = vinsf;
    });
  }
}
