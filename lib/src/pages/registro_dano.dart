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
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/vins/registro_vin.dart';
import 'package:tleavin_mobil/src/pages/inspeccion_vin.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:image_picker/image_picker.dart';

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

  List<int> list = <int>[1, 2, 3, 5, 6, 7, 8, 9, 10];

  final ImagePicker picker = ImagePicker();

  String? base64Foto1;
  String? base64Foto2;
  String? base64Foto3;
  String? base64Foto4;
  List<XFile>? _mediaFileList;
  var evidenciasDano = [];

  Dano? dano;
  Evidencia? evidencia;

  Future<void> getCamara(foto) async {
    final List<XFile> pickedFileList = <XFile>[];
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
      imageQuality: 100
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
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int dropdownValue = list.first;

    return Scaffold(
        appBar: AppBar(
        // backgroundColor: Colors.black,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),         
            ),
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
                        'Panel Seleccinado: ',
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
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownButton<int>(
                      items: list.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    )
                  ),
                  const SizedBox(height: 10),
                  _titulo('Tipo:'),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownButton<int>(
                      items: list.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
    
                  ),
                  const SizedBox(height: 10),
                  _titulo('Severidad:'),
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width,
                  //   margin: const EdgeInsets.only(left: 20, right: 20),
                  //   child: DropdownMenu<int>(
                  //     initialSelection: list.first,
                  //     onSelected: (int? value) {
                  //       setState(() {
                  //         dropdownValue = value!;
                  //       });
                  //     },
                  //     dropdownMenuEntries: list.map<DropdownMenuEntry<int>>((int value) {
                  //       return DropdownMenuEntry<int>(value: value, label: value.toString());
                  //     }).toList(),
                  //   )
                  // ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownButton<int>(
                      items: list.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    )
                  ),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InspeccionVin(vin: widget.vin)),
                            );
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
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => ResumenDano(vin: widget.vin)),
                            // );

                            log(evidenciasDano.length.toString());
                            guardarDano();
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

  guardarDano() async {
    dano = Dano(
      vin: widget.vin,
      panel: widget.panel,
      area: 1,
      tipo: 4,
      severidad: 5,
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
          dano: null,
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
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const InicioScreen()), (route) => false);
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });
  }
}