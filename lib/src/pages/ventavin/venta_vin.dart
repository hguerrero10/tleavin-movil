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

import '../dano/listas.dart';

class VentaVin extends StatefulWidget {
  const VentaVin({super.key});

  @override
  State<VentaVin> createState() => _VentaVinState();
}

final _formKey = GlobalKey<FormState>();
final _qrTextController = TextEditingController();
final _posicionTextController = TextEditingController();

var qrbar = '';
var vinExistente = 0;  

Vin? vin;         

List<ListasA> listaCliente = [];
List<ListasM> listaModelo = [];
List<ListasD> listaDestino = [];
class _VentaVinState extends State<VentaVin> {
  @override
  void initState() {
    initializeDateFormatting();

    _qrTextController.clear();
    _posicionTextController.clear();

    getListas();

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
        child: Form(
          key: _formKey,
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
                    _dropDownModelo(),
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
                      onPressed: () {
                        if(_qrTextController.text.isNotEmpty && _qrTextController.text.length >= 17 && _qrTextController.text.length <= 17) {
                          guardarVin();
                        }
                        else{
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
                      },
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
          ),
        )
      )
    );
  }

  Widget _dropDownCliente() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasA>(
          items: listaCliente,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Seleccione Cliente",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasA? item) {

          getListaModelo(item?.valor);
          setState(() {
            // selectArea = (item?.valor);
            itemP.addClienteSeleccionado(item?.texto);
          });
        },
        itemAsString: (ListasA item) => item.texto,
        validator: (value) {
          if(value == null) {
            return 'Favor de Seleccionar Cliente';
          }

          return null;
        },
      )
    );
  }

   Widget _dropDownModelo() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasM>(
          items: listaModelo,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Seleccione Modelo",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasM? item) {
          setState(() {
            // selectArea = (item?.valor);
            itemP.addModeloSeleccionado(item?.texto);
          });
        },
        itemAsString: (ListasM item) => item.texto,
        validator: (value) {
          if(value == null) {
            return 'Favor de Seleccionar Modelo';
          }

          return null;
        },
      )
    );
  }

  Widget _dropDownDestino() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasD>(
          items: listaDestino,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Seleccione Destino",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasD? item) {
          setState(() {
            // selectArea = (item?.valor);
            itemP.addDestinoSeleccionado(item?.texto);
          });
        },
        itemAsString: (ListasD item) => item.texto,
        validator: (value) {
          if(value == null) {
            return 'Favor de Seleccionar Destino';
          }

          return null;
        },
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
            hintText: "* Seleccione Orientacion",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (cl) {
          setState(() {
            itemP.addOrientacionSeleccionado(cl);
          });
        },
        validator: (value) {
          if(value == null || value.isEmpty) {
            return 'Favor de Seleccionar Orientacion';
          }

          return null;
        },
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
    if(_formKey.currentState!.validate()) {
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
        modelo: itemP.modeloSeleccionado,
        marca: itemP.clienteSeleccionado,
        posicion: _posicionTextController.text.trim(),
        orientacion: itemP.orientacionSeleccionado,
        compra: 1,
        fecha_carga: null,
        fecha_creacion: fecha,
        fecha_sync: null
      );

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
    else {
      Fluttertoast.showToast(
        msg: "Complete la informacion",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }

  Future<List<ListasA>> getListas() async {
    List<ListasA> resultados = [];
    try {
      await DatabaseProvider.db.obtenerCliente().then((value) {
        setState(() {
          listaCliente = value.map((item) => ListasA(valor: item.idAdvan.toString(), texto: '${item.cliente}')).toList();
        });
      });

      await DatabaseProvider.db.obtenerDestino().then((value) {
        setState(() {
          listaDestino = value.map((item) => ListasD(valor: item.id_destino.toString(), texto: '${item.destino}')).toList();
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
  }

  Future<List<ListasA>> getListaModelo(id) async {
    List<ListasA> resultados = [];
    try {
      await DatabaseProvider.db.obtenerModeloXMarca(id).then((value) {
        setState(() {
          listaModelo = value.map((item) => ListasM(valor: item.id_modelo.toString(), texto: '${item.modelo}')).toList();
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
  }
}