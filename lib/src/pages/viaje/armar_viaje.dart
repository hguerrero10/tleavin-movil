import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/viaje.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/dano/listas.dart';
import 'package:tleavin_mobil/src/pages/viaje/vin_para_viaje.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class ArmarViaje extends StatefulWidget {
  final vinesqueseleccionaron;
  const ArmarViaje({super.key, this.vinesqueseleccionaron});

  @override
  State<ArmarViaje> createState() => _ArmarViajeState();
}

class _ArmarViajeState extends State<ArmarViaje> {

  final _ecoTextController = TextEditingController();
  final _nombreOpTextController = TextEditingController();
  final _origenTextController = TextEditingController();
  final _destinoTextController = TextEditingController();
  final _notaTextController = TextEditingController();

  String? tipoEco;

  var listaVinsViaje = [];
  String? vinEscaneado;
  Viaje? viaje;

  var formato;
  var fecha;

  List<ListasA> listaCliente = [];
  String? selectClie;
  String? selectClieText;

  Future<List<ListasA>> getListas() async {
    List<ListasA> resultados = [];

    try {
      await DatabaseProvider.db.obtenerCliente().then((value) {
        setState(() {
          listaCliente = value.map((item) => ListasA(valor: item.idAdvan.toString(), texto: '${item.cliente}')).toList();
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
  }

  @override
  void initState() {
    initializeDateFormatting();
    formato = DateFormat('yyyy/MM/dd'); 
    fecha = formato.format(DateTime.now());

    _origenTextController.text = itemP.usuario!.locacion!;

    getListas();
    
    super.initState();
  }

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
      body: CustomScrollView(
        slivers: [
         SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              const Cuerpo(),

              _titulo('Numero Eco.'),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true
                            ),
                            items: const ['TLE', 'TLEA', 'C', 'OTRO'],
                            dropdownDecoratorProps: const  DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Tipo",
                                hintStyle: TextStyle(
                                  color: Colors.grey
                                )
                              )
                            ),
                            onChanged: (cl) {
                              setState(() {
                                tipoEco = cl;
                              });
                            }
                          )
                        ),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            controller: _ecoTextController,
                            keyboardType: tipoEco != 'OTRO' ? TextInputType.number : TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              hintText: 'Numero Economico',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              )
                            )
                          )
                        )
                    ]
                  ),
              ),
              
              const SizedBox(height: 10),

              _titulo('Nombre Operador'),
              _inputs(_nombreOpTextController, 'Escriba Nombre del Operador', TextInputType.text),
              const SizedBox(height: 10),

              _titulo('Cliente'),
              _dropDownCliente(),
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
                  // onPressed: () => scanQR(),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VinsParaViaje())),
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
                    'Seleccionar VINES',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )
                  )
                )
              ),
              const SizedBox(height: 30),

              Expanded(child: itemP.vinesSeleccionadosParaViaje.isNotEmpty ? SizedBox( height: 200, child: vinsSeleccionados(itemP.vinesSeleccionadosParaViaje)) : const SizedBox()),
              
              const SizedBox(height: 30),

              _inputs(_notaTextController, 'Nota', TextInputType.text),
              
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: () => crearViaje(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(15)),
                    minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 40)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    )
                  ),
                  child: const Text(
                    'Registrar viaje',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )
                  )
                )
              ),
              const SizedBox(height: 30)
            ]
          )
         )
        ]
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

        var vinvalido = value.length;
        
        if(vinvalido > 0) {
          int index = listaVinsViaje.indexOf(v);

          if(index == -1) {
            setState(() {
              listaVinsViaje.add(value[0]['vin']);
            });
          }
          else {
            Fluttertoast.showToast(
              msg: "El VIN ya encuentra en el viaje",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0
            );
          }
        }
        else {
          Fluttertoast.showToast(
            msg: "VIN no Comprado o no Registrado",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
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
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          hintText: place,
          hintStyle: const TextStyle(
            color: Colors.grey
          )
        )
      )
    );
  }

  Widget _dropDownCliente() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 16, right: 16,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasA>(
          items: listaCliente,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecciona"
          ),
        ),
        onChanged: (ListasA? item) {
          setState(() {
            selectClie = (item?.valor);
            selectClieText = (item?.texto);
          });
        },
        itemAsString: (ListasA item) => item.texto,
      )
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
    return listav != null ? ListView.builder(
      itemCount: listav.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
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
    ) : const SizedBox();
  }

  crearViaje() async {
    viaje = Viaje(
      supervisor: itemP.usuario!.nombre!,
      folio_bitacora: null ,
      cartaporte: null,
      bitacora_fecha_carga: null,
      num_eco_unidad: tipoEco != 'OTRO' ? '$tipoEco-${_ecoTextController.text.trim().toUpperCase()}' : _ecoTextController.text.trim().toUpperCase(),
      nombre_operador: _nombreOpTextController.text.trim().toUpperCase(),
      cliente_clave: int.parse(selectClie.toString()),
      cliente_nombre: selectClieText,
      ruta_clave: null,
      ruta_nombre: null,
      origen: _origenTextController.text.trim().toUpperCase(),
      destino: _destinoTextController.text.trim().toUpperCase(),
      etiqueta: null,
      status_carga: 0,
      notas: _notaTextController.text,
      registrada_por: itemP.usuario!.usuario!,
      tipo_viaje: null,
      semana: null,
      estadoViaje: 'En Proceso',
      fecha_creacion: fecha,
      fecha_sync: null
    );

    await DatabaseProvider.db.insertarViaje(viaje!).then((value) async {
      log('viaje insertado');

      listaVinsViaje = itemP.vinesSeleccionadosParaViaje;

      for(var ed in listaVinsViaje) {
        var vinsviaje = (
          vin: ed,
          idviaje: value,
          origen: _origenTextController.text,
          destino: _destinoTextController.text,
        );

        await DatabaseProvider.db.asignarVinViaje(vinsviaje).then((value) {
          log('vin asignado');
        }).timeout(const Duration(seconds: 30), onTimeout: () {
          itemP.addError();
        });
      }

      Fluttertoast.showToast( 
        msg: "Viaje armado con Exito!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20
      );

      itemP.deleteVSPV();

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });

  }
}