import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/dano/resumen_dano.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class RegistroUnidadSS extends StatefulWidget {

  final vin;
  final tipo;
  const RegistroUnidadSS({super.key, this.vin, this.tipo});

  @override
  State<RegistroUnidadSS> createState() => _RegistroUnidadSSState();
}

class _RegistroUnidadSSState extends State<RegistroUnidadSS> {
  var formato;
  var formatWH;
  var fecha;
  var fechaH;

  final _notasTextController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  
  String? base64Foto1;
  String? base64Foto2;
  String? base64Foto3;
  String? base64Foto4;

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

  var resumen;

  obtenerResumen(v) async {
    await guardarDano();

    
    var datos = await DatabaseProvider.db.obtenerInfoVin(v);
    setState(() {
      resumen = datos;
    });

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => ResumenDano(resu: resumen)), (Route<dynamic> route) => false);
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
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: Text(
          widget.tipo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.tipo,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'VIN: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        widget.vin,
                        style: const TextStyle(
                          fontSize: 17
                        )
                      )
                    ]
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Adjunte 4 fotografía por cada lado de la unidad.',
                    style: TextStyle(
                      fontSize: 15
                    )
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => getCamara(1),
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/img/camara.png',
                                        width: 40,
                                        height: 40
                                      ),
                                      const Text(
                                        'Lejos',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ]
                                  ),
                                  base64Foto1 != null ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                    size: 60
                                  ) : const SizedBox()
                                ],
                              )
                            ),
                            GestureDetector(
                              onTap: () => getCamara(2),
                              child: Stack(
                                children: <Widget> [
                                  Column(
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
                                      )
                                    ]
                                  ),
                                  base64Foto2 != null ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                    size: 60
                                  ) : const SizedBox()
                                ]
                              )
                            ),
                            GestureDetector(
                              onTap: () => getCamara(3),
                              child: Stack(
                                children: <Widget> [
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/img/camara.png',
                                        width: 40,
                                        height: 40
                                      ),
                                      const Text(
                                        'Angulo 2',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ]
                                  ),
                                  base64Foto3 != null ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                    size: 60
                                  ) : const SizedBox()
                                ],
                              )
                            ),
                            GestureDetector(
                              onTap: () => getCamara(4),
                              child: Stack(
                                children: <Widget>[
                                  Column(
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
                                        )
                                      )
                                    ]
                                  ),
                                  base64Foto4 != null ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                    size: 60
                                  ) : const SizedBox()
                                ],
                              )
                            )
                          ]
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
                          onPressed: () => obtenerResumen(widget.vin),
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
                            'Finalizar',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            )
                          )
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 20),
                ]
              )
            )
          ]
        )
      )
    );
  }

  guardarDano() async {
    dano = Dano(
      vin: widget.vin,
      panel: null,
      registroTipo: widget.tipo,
      area: null,
      tipo: null,
      severidad: null,
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