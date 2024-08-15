import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/ventavin/venta_danos.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class VentaVin extends StatefulWidget {
  const VentaVin({super.key});

  @override
  State<VentaVin> createState() => _VentaVinState();
}

final _qrTextController = TextEditingController();
var qrbar = '';
var vinExistente = 0;

final _posicionTextController = TextEditingController();

Vin? vin;                                


class _VentaVinState extends State<VentaVin> {
  @override
  void initState() {
    initializeDateFormatting();

    _qrTextController.clear();
    _posicionTextController.clear();

    super.initState();
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
          )
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
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
                      )
                    )
                  ),
                  Center(
                    child: ElevatedButton(
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
                              size: 30,
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
                    )
                  ),
                  const SizedBox(height: 20),
                  _dropDownDestino(),
                  _dropDownCliente(),
                  const SizedBox(height: 10),
                  _dropDownOrientacion(),
                  TextFormField(
                    controller: _posicionTextController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Favor de llenar la Posicion';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: '* Escriba La Posicion',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    )
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => guardarVin(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      )
                    ),
                    child: const SizedBox(
                      width: 350,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Registrar Danos',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white
                            )
                          )
                        ]
                      )
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  Widget _dropDownCliente() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true
        ),
        items: const ['GM','AUDI', 'MAZDA', 'MG'],
        dropdownDecoratorProps: const  DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "* Selecciona Marca",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (cl) {
          setState(() {
            itemP.addClienteSeleccionado(cl);
          });
        }
      )
    );
  }

  Widget _dropDownDestino() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true
        ),
        items: const ['Puerto','Silao', 'San Luis Potosi', 'Lazaro'],
        dropdownDecoratorProps: const  DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "* Selecciona Destino",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (cl) {
          setState(() {
            itemP.addDestinoSeleccionado(cl);
          });
        }
      )
    );
  }

  Widget _dropDownOrientacion() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true
        ),
        items: const ['Frente','Reversa'],
        dropdownDecoratorProps: const  DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "* Selecciona Orientacion",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (cl) {
          setState(() {
            itemP.addOrientacionSeleccionado(cl);
          });
        }
      )
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", true, ScanMode.QR);
      _qrTextController.text = barcodeScanRes;
    } 
    catch (e) {
      Fluttertoast.showToast(
        msg: "Error al escanear: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }
  
  guardarVin() async {
    var formato = DateFormat('yyyy-MM-dd hh:mm:ss'); 
    var fecha = formato.format(DateTime.now());
    
    vin = Vin(
      idviaje: null,
      cartaporte: null,
      vin: _qrTextController.text,
      distrib_clave: null,
      dest_nombre: null,
      ruta_clave: null,
      ruta_nombre: null,
      origen: itemP.usuario!.locacion!,
      destino: itemP.destinoSeleccionado,
      modelo: null,
      marca: itemP.clienteSeleccionado,
      posicion: _posicionTextController.text.trim(),
      orientacion: itemP.orientacionSeleccionado,
      compra: 1,
      fecha_carga: null,
      fecha_creacion: fecha,
      fecha_sync: null
    );

    log(vin.toString());

    await DatabaseProvider.db.insertarVin(vin!).then((value) async {
      itemP.addBoton();
      itemP.deleteBoton();

      Fluttertoast.showToast(
        msg: "VIN guardado con Exito!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => VentaDanos(vin: _qrTextController.text)));        

    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });
  }
}