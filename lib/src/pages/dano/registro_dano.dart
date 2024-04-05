import 'dart:io';
import 'dart:core';
import 'dart:convert';
import 'dart:developer';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/dano/listas.dart';
import 'package:tleavin_mobil/src/pages/dano/resumen_dano.dart';
import 'package:tleavin_mobil/src/pages/vin/registro_vin.dart';
import 'package:tleavin_mobil/src/pages/vin/inspeccion_vin.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RegistroDano extends StatefulWidget {
  final vin;
  final panel;

  const RegistroDano({super.key, this.vin, this.panel});

  @override
  State<RegistroDano> createState() => _RegistroDanoState();
}

class _RegistroDanoState extends State<RegistroDano> {
  var formato;
  var formatWH;
  var fecha;
  var fechaH;

  final _notasTextController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  List<XFile>? _mediaFileList;

  String? base64Foto1;
  String? base64Foto2;
  String? base64Foto3;
  String? base64Foto4;
  var evidenciasDano = [];

  List<ListasA> listaAreaDanos = [];
  List<ListasT> listaTipoDanos = [];
  List<ListasS> listaSeveridad = [];
  List<String> listaCliente = [];
  
  String? selectArea;
  String? selectTipo;
  String? selectSeve;
  String? selectClien;

  Dano? dano;
  Evidencia? evidencia;

  Future<void> getCamara(foto) async {
    final List<XFile> pickedFileList = <XFile>[];
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 10,
      maxWidth: 10,
      imageQuality: 2
      // maxHeight: 720,
      // maxWidth: 1280,
      // imageQuality: 100
    );

    if(photo != null) {
      await GallerySaver.saveImage(photo.path, albumName: 'TLEAVIN');
      setState(() {
        pickedFileList.add(XFile(photo.path));
        _mediaFileList = pickedFileList;
        convertirBase64(photo.path, foto);
      });
    }
  }

  convertirBase64(value, foto) async {
    if(value != null) {
      final imageData = await File(value).readAsBytes();
      
      if(foto == 1) {
        base64Foto1 = null;
        base64Foto1 = base64Encode(imageData);
        // log(base64Foto1.toString());
        evidenciasDano.add(base64Foto1);
      }

      if(foto == 2) {
        base64Foto2 = null;
        base64Foto2 = base64Encode(imageData);
        // log(base64Foto2.toString());
        evidenciasDano.add(base64Foto2);
      }

      if(foto == 3) {
        base64Foto3 = null;
        base64Foto3 = base64Encode(imageData);
        // log(base64Foto3.toString());
        evidenciasDano.add(base64Foto3);
      }

      if(foto == 4) {
        base64Foto4 = null;
        base64Foto4 = base64Encode(imageData);
        // log(base64Foto4.toString());
        evidenciasDano.add(base64Foto4);
      }
      
    }
  }

  @override
  void initState() {
    initializeDateFormatting();
    formato = DateFormat('yyyy/MM/dd'); 
    formatWH = DateFormat('yyyy/MM/dd HH:mm:ss'); 
    fecha = formato.format(DateTime.now());
    fechaH = formatWH.format(DateTime.now());

    getListas();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Registrar Daño',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const CompraVin()), (Route<dynamic> route) => false)
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'VIN: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.vin,
                        style: const TextStyle(
                          fontSize: 17
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Panel Seleccionado: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.panel,
                        style: const TextStyle(
                          fontSize: 17
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  _titulo('Area:'),
                  _dropDownArea(),
                  const SizedBox(height: 10),
                  _titulo('Tipo:'),
                  _dropDownTipo(),
                  const SizedBox(height: 10),
                  _titulo('Severidad:'),
                  _dropDownSeveridad(),
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => getCamara(1),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/camara.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const Text(
                                    'Lejos',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ]
                              )
                            ),
                            GestureDetector(
                              onTap: () => getCamara(2),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/camara.png',
                                    width: 40,
                                    height: 40
                                  ),
                                  const Text(
                                    'Angulo 1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => getCamara(3),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/camara.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const Text(
                                    'Angulo 2',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => getCamara(4),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/camara.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const Text(
                                    'Angulo 3',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  // Container(
                                  //   height: 200,
                                  //   width: 200,
                                  //   child: ListView.builder(
                                  //     key: UniqueKey(),
                                  //     itemBuilder: (BuildContext context, int index) {
                                  //       return Semantics(
                                  //         label: 'image_picker_example_picked_image',
                                  //         child: Image.file(
                                  //         File(_mediaFileList![index].path),
                                  //         errorBuilder: (BuildContext context, Object error,
                                  //             StackTrace? stackTrace) {
                                  //           return const Center(
                                  //               child:
                                  //                   Text('This image type is not supported'));
                                  //         },
                                  //       )                             
                                  //       );
                                  //     },
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _notasTextController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Notas',
                            hintStyle: TextStyle(
                              color: Colors.grey
                            )
                          )
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => {
                            guardarDano(),
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InspeccionVin(vin: widget.vin))
                            )
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                            minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                            shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                          ),
                          child: const Text(
                            'Registrar Otro Daño',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => {
                            guardarDano(),
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResumenDano(vin: widget.vin))
                            )
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                            minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              )
                            ),
                          ),
                          child: const Text(
                            'Finalizar',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            )
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            ),
            const SizedBox(height: 20),
          ]
        )
      )
    );
  }

  Future<List<ListasA>> getListas() async {
    List<ListasA> resultados = [];

    try {
      await DatabaseProvider.db.obtenerAreaDano().then((value) {
        setState(() {
          listaAreaDanos = value.map((item) => ListasA(valor: item.id.toString(), texto: '${item.id} : ${item.descripcion}')).toList();
        });
      });

      await DatabaseProvider.db.obtenerTipoDano().then((value) {
        setState(() {
          listaTipoDanos = value.map((item) => ListasT(valor: item.id.toString(), texto: '${item.id} : ${item.descripcion}')).toList();
        });
      });

      await DatabaseProvider.db.obtenerSeveridad().then((value) {
        setState(() {
          listaSeveridad = value.map((item) => ListasS(valor: item.id.toString(), texto: '${item.id} : ${item.descripcion}')).toList();
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
  }

  Widget _titulo(String titulo) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17
            )
          )
        )
      ]
    );
  }

  Widget _dropDownArea() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasA>(
          items: listaAreaDanos,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecciona"
          ),
        ),
        onChanged: (ListasA? item) {
          setState(() {
            selectArea = (item?.valor);
            log(selectArea.toString());
          });
        },
        itemAsString: (ListasA item) => item.texto,
      )

    );
  }

  Widget _dropDownTipo() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          // border: Border.all(
          //   color: Colors.grey[200]!
          // )
      ),
      child: DropdownSearch<ListasT>(
          items: listaTipoDanos,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecciona"
          ),
        ),
        onChanged: (ListasT? item) {
          setState(() {
            selectTipo = (item?.valor);
            log(selectTipo.toString());
          });
        },
        itemAsString: (ListasT item) => item.texto,
      )

    );
  }

  Widget _dropDownSeveridad() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasS>(
          items: listaSeveridad,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecciona"
          ),
        ),
        onChanged: (ListasS? item) {
          setState(() {
            selectSeve = (item?.valor);
            log(selectSeve.toString());
          });
        },
        itemAsString: (ListasS item) => item.texto,
      )

    );
  }

  guardarDano() async {
    dano = Dano(
      vin: widget.vin,
      panel: widget.panel,
      registroTipo: 'Regular',
      area: int.parse(selectArea.toString()),
      tipo: int.parse(selectTipo.toString()),
      severidad: int.parse(selectSeve.toString()),
      nota: _notasTextController.text,
      fecha_creacion: fecha
    );

    await DatabaseProvider.db.insertarDano(dano!).then((value) async {
      log('dano insertado');
      itemP.addBoton();
      itemP.deleteBoton();

      for(var ed in evidenciasDano) {
        evidencia = Evidencia(
          vin: widget.vin,
          iddano: value,
          nombre: null,
          archivo: ed,
          fechahora: fechaH
        );

        await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) async {
          log('evidencia insertado');
        }).timeout(const Duration(seconds: 30), onTimeout: () {
          itemP.addError();
        });
      }
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });
  }
}