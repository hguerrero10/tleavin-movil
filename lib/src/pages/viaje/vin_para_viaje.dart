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
  String query = '';
  var vinesseleccionados = []; // Lista de mapas [{vin: '...', idv: '...'}]
  var vins = []; // Lista de mapas [{vin: '...', idv: '...'}]
  var vinsComprados = []; // Lista de mapas [{vin: '...', idv: '...'}]

  Future<void> scanQR() async {
    String codeQrBar;
    try {
      codeQrBar = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", true, ScanMode.QR);
      setState(() {
        query = codeQrBar;
        searchVIN(query);
      });
    } catch (e) {
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
    var vc = [];

    for (var d in data) {
      vc.add({'vin': d.vin, 'idv': d.idv}); // Guardar tanto vin como idv
    }

    setState(() {
      vinsComprados = vc;
      vins = vinsComprados;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
            title: const Text('Lista de VINES',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
        body: Column(children: <Widget>[
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => scanQR(),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
              child: const SizedBox(
                  width: 200,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.qr_code_2_outlined, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text('Escanear VIN',
                        style: TextStyle(fontSize: 18.0, color: Colors.white))
                  ]))),
          buildSearch(),
          vinesseleccionados.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: vinesseleccionados.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                            title: Text("VIN: ${vinesseleccionados[index]['vin']}"),
                            value: true,
                            onChanged: (value) {
                              setState(() {
                                var vi = vinesseleccionados[index];
                                vins.add(vi);
                                vinesseleccionados.remove(vi);
                              });
                            });
                      }))
              : const SizedBox(),
          Expanded(
              child: ListView.builder(
                  itemCount: vins.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                        title: Text("VIN: ${vins[index]['vin']}"),
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            var vi = vins[index];
                            vinesseleccionados.add(vi);
                            vins.remove(vi);
                          });
                        });
                  })),
          ElevatedButton(
              onPressed: () {
                itemP.addVSPV(vinesseleccionados); // Guardar lista seleccionada
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
              child: const SizedBox(
                  width: 200,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.add, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text('Agregar al Viaje',
                        style: TextStyle(fontSize: 18.0, color: Colors.white))
                  ]))),
          const SizedBox(height: 40)
        ]),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'VIN',
        onChanged: searchVIN,
      );

  searchVIN(String query) {
    final vinsf = vinsComprados.where((v) {
      final titleLower = v['vin'].toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      vins = vinsf;
    });
  }
}
