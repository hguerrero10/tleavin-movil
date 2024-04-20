import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/src/widgets/search.dart';

class VinsParaViaje extends StatefulWidget {
  const VinsParaViaje({super.key});

  @override
  VinsParaViajeState createState() => VinsParaViajeState();
}

class VinsParaViajeState extends State<VinsParaViaje> {
  final _qrTextController = TextEditingController();
  var vins =[];
  var vinsComprados = [];
  String query = '';

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
    var data = await DatabaseProvider.db.obtenerListaVins();

    for(var d in data) {
      var vi = (
        idv: d.idv,
        viaje: d.viaje ?? 0,
        cartaporte: d.cartaporte ?? '',
        vin: d.vin,
        distrib_clave: d.distrib_clave ?? '',
        dest_nombre: d.dest_nombre ?? '',
        ruta_clave: d.ruta_clave ?? '',
        ruta_nombre: d.ruta_nombre ?? '',
        origen: d.origen ?? '',
        destino: d.destino ?? '',
        modelo: d.modelo ?? '',
        marca: d.marca ?? '',
        posicion: d.posicion ?? '',
        orientacion: d.orientacion ?? '',
        compra: d.compra ?? '',
        fecha_carga: d.fecha_carga ?? '',
        fecha_creacion: d.fecha_creacion ?? '',
        fecha_sync: d.fecha_sync ?? '',
        seleccionado: false
      );

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
        'Lista de VINs',
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
        Expanded(
          child: ListView.builder(
            itemCount: vins.length,
            itemBuilder: (context, index) {
              final vi = vins[index];
              return Card(
                child: ListTile(
                  title: Row(
                    children: [
                      const Text(
                        'VIN: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text('${vi.vin}')
                    ]
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${vi.fecha_creacion}'),
                      Text('${vi.seleccionado}')
                    ]
                  ),
                  trailing: vi.seleccionado == true ? const Icon(Icons.check_box, color: Colors.green) : const Icon(Icons.add_box, color: Colors.grey),
                  onTap: () {
                      final tile = vins.firstWhere((item) => item.vin == vi.vin);

                      log(tile.toString());
                      log(tile.seleccionado.toString());
                      setState(() {
                          tile.seleccionado = true;
                      });
                  }
                )
              );
            }
          )
        )
      ]
    )
  );

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'VIN',
    onChanged: searchVIN
  );

  searchVIN(String query) {
    final vins = vinsComprados.where((v) {
      final titleLower = v.vin.toLowerCase();

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
      this.vins = vins;
    });
  }
}
