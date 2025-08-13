import 'package:tleavin_mobil/src/pages/ventavin/venta_danos.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../dano/listas.dart';
import 'dart:developer';

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

String? _searchingWithQuery;
late Iterable<String> _lastOptions = <String>[];
const Duration fakeAPIDuration = Duration(seconds: 1);

List<String> listaC = [];
List<String> listaM = [];
List<String> listaD = [];

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
                    // _dropDownCliente(),
                    _autoCompleteCliente(),
                    // _dropDownModelo(),
                    _autoCompleteModelo(),
                    // _dropDownDestino(),
                    _autoCompleteDestino(),
                    _dropDownOrientacion(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: TextFormField(
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
                      child: const Center(
                        child: SizedBox(
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
                                'Registrar Daños',
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white
                                )
                              )
                            ]
                          )
                        ),
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
            hintText: "* Seleccione Cliente",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasA? item) {
          setState(() {
            itemP.addClienteSeleccionado(item?.texto);

            getListaModelo(item?.valor);
            getListaDestino(item?.valor);
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
            hintText: "* Seleccione Modelo",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasM? item) {
          setState(() {
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
            hintText: "* Seleccione Destino",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasD? item) {
          setState(() {
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

  Widget _autoCompleteCliente() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          _searchingWithQuery = textEditingValue.text.toLowerCase();
          return listaC.where((String option) => option.toLowerCase().contains(_searchingWithQuery!));
        },
        onSelected: (String selection) {
          setState(() {
            var uno = selection.split('-')[1];
            var dos = selection.split('-')[0];

            itemP.addClienteSeleccionado(uno);
            getListaModelo(dos);
            getListaDestino(dos);
          });
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: '* Ingrese Cliente',
              hintText: 'Seleccione Cliente',
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Favor de llenar el Cliente';
              }
              return null;
            },
          );
        }
      )
    );
  }

  Widget _autoCompleteModelo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          _searchingWithQuery = textEditingValue.text.toLowerCase();
          return listaM.where((String option) => option.toLowerCase().contains(_searchingWithQuery!));
        },
        onSelected: (String selection) {
          setState(() {
            itemP.addModeloSeleccionado(selection);
          });
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: '* Ingrese Modelo',
              hintText: 'Seleccione Modelo',
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Favor de llenar el Modelo';
              }
              return null;
            }
          );
        }
      )
    );
  }

  Widget _autoCompleteDestino() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          _searchingWithQuery = textEditingValue.text.toLowerCase();
          return listaD.where((String option) => option.toLowerCase().contains(_searchingWithQuery!));
        },
        onSelected: (String selection) {
          setState(() {
            itemP.addDestinoSeleccionado(selection);
          });
        },

        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: '* Ingrese Destino',
              hintText: 'Seleccione Destino',
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Favor de llenar el Destino';
              }
              return null;
            }
          );
        }
      )
    );
  }
  
  Widget _dropDownOrientacion() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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

  Future<List<ListasA>> getListas() async {
    List<ListasA> resultados = [];
    List<String> result = [];
    
    try {
      await DatabaseProvider.db.obtenerCliente().then((value) {
        setState(() {
          listaCliente = value.map((item) => ListasA(valor: item.idAdvan.toString(), texto: '${item.cliente}')).toList();

          for(var i = 0; i < value.length; i++) {
            result.add('${value[i].idAdvan.toString()}-${value[i].cliente.toString()}');
          }

          listaC = result;
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
    List<String> result = [];

    try {
      await DatabaseProvider.db.obtenerModeloXMarca(id).then((value) {
        setState(() {
          listaModelo = value.map((item) => ListasM(valor: item.id_modelo.toString(), texto: '${item.modelo}')).toList();

          for(var i = 0; i < value.length; i++) {
            result.add(value[i].modelo.toString());
          }
          
          listaM = result;
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
  }

  Future<List<ListasD>> getListaDestino(id) async {
    List<ListasD> resultados = [];
    List<String> result = [];

    try {
      await DatabaseProvider.db.obtenerDestinoXMarca(id).then((value) {
        setState(() {
          listaDestino = value.map((item) => ListasD(valor: item.id_destino.toString(), texto: '${item.destino}')).toList();

          for(var i = 0; i < value.length; i++) {
            result.add(value[i].destino.toString());
          }
          
          listaD = result;
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
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
        dest_nombre: 'Venta',
        ruta_clave: null,
        ruta_nombre: itemP.usuario!.usuario!,
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
}