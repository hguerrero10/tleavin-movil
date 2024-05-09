import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/vin/inspeccion_vin.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:developer';

class CompraVin extends StatefulWidget {
  const CompraVin({super.key});

  @override
  State<CompraVin> createState() => _CompraVinState();
}

class _CompraVinState extends State<CompraVin> {
  var formato;
  var fecha;
  var qrbar = '';
  var vinExistente = 0;
  Vin? vin;

  final _qrTextController = TextEditingController();

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
  void initState() {
    initializeDateFormatting();
    formato = DateFormat('yyyy/MM/dd'); 
    fecha = formato.format(DateTime.now());

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
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _dropDownCliente(),
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      qrbar = _qrTextController.text;

                      if(itemP.clienteSeleccionado != null){
                        if(_qrTextController.text.isNotEmpty && (_qrTextController.text.length >= 17)) {
                          await checarVinExistente(qrbar);

                          if(vinExistente != 0) {
                            Fluttertoast.showToast(
                              msg: "El VIN se Encuentra Registrado",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.yellow,
                              textColor: Colors.white,
                              fontSize: 20
                            );
                          }
                          else {
                            registrarVin(qrbar);
                          }
                        } 
                        else {
                          Fluttertoast.showToast(
                            msg: "Escanea o Escribe el VIN",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 20
                          );
                        }
                      }
                      else {
                        Fluttertoast.showToast(
                          msg: "Seleccione el Cliente",
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
                        )
                      )
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.checklist,
                          size: 30,
                          color: Colors.white
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Realizar Inspeccion',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white
                          )
                        )
                      ]
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
        items: const ['GM','Multimarcas'],
        dropdownDecoratorProps: const  DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "* Selecciona Cliente",
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

  Future checarVinExistente(v) async {
    try{
      await DatabaseProvider.db.checarVinExistente(v).then((value) {
        setState(() {
          vinExistente = value.length;
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }
  }

  registrarVin(valorvin) async {
    vin = Vin(
      idviaje: null,
      cartaporte: null,
      vin: valorvin,
      distrib_clave: null,
      dest_nombre: null,
      ruta_clave: null,
      ruta_nombre: null,
      origen: null,
      destino: null,
      modelo: null,
      marca: null,
      posicion: null,
      orientacion: null,
      compra: 0,
      fecha_carga: null,
      fecha_creacion: fecha,
      fecha_sync: null
    );

    await DatabaseProvider.db.insertarVin(vin!).then((value) async {
      log('vin insertado');
      itemP.addBoton();
      itemP.deleteBoton();
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => InspeccionVin(vin: valorvin)));
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });
  }
}
