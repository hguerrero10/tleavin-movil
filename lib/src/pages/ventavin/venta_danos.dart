import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'dart:io';
import 'dart:convert';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';

class VentaDanos extends StatefulWidget {
  final vin;
  const VentaDanos({super.key, this.vin});

  @override
  State<VentaDanos> createState() => _VentaDanosState();
}

class _VentaDanosState extends State<VentaDanos> {

  final _areaTextController = TextEditingController();
  final _tipoTextController = TextEditingController();
  final _severidadTextController = TextEditingController();
  final _notasTextController = TextEditingController();

  Dano? dano;
  Evidencia? evidencia;

  final ImagePicker picker = ImagePicker();

  String? base64Foto;
  String? base64Foto1;

  var evidenciasDano = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Registro de Daños',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {}
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column( 
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'VIN: ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        widget.vin,
                        style: const TextStyle(
                          fontSize: 25
                        )
                      )
                    ]
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _areaTextController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Favor de llenar el Area';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: '* Escriba el Area',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    )
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _tipoTextController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Favor de llenar el Tipo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: '* Escriba el Tipo',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    )
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _severidadTextController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Favor de llenar la Severidad';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: '* Escriba la Severidad',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    )
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _notasTextController,
                    keyboardType: TextInputType.text,
                    // validator: (value) {
                    //   if(value == null || value.isEmpty) {
                    //     return 'Favor de llenar la Posicion';
                    //   }
                    //   return null;
                    // },
                    decoration: const InputDecoration(
                      hintText: 'Comentarios',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    )
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => getCamara(1),
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
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Fotografia',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white
                                )
                              )
                            ]
                          )
                        )
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            const Text('Fotos'),
                            
                            Text('${evidenciasDano.length}')
                          ]
                        )
                      )
                    ]
                  ),  
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => getCamara(2),
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
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Fotografia de Tarja',
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
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => nuevoDano(),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
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
                                  Icons.save,
                                  color: Colors.black,
                                  size: 30
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Guardar Daño',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black
                                  )
                                )
                              ]
                            )
                          )
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false),
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
                                  'Guardar y Finalizar',
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
                  ),
                  const SizedBox(height: 30)
                ]
              )
            )
          ]
        )
      ) 
    );
  }

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
        base64Foto = null;
        base64Foto = base64Encode(imageData);

        setState(() {
          evidenciasDano.add(base64Foto);
        });
      }

      if(foto == 2) {
        base64Foto1 = null;
        base64Foto1 = base64Encode(imageData);
        setState(() {
          evidenciasDano.add(base64Foto1);
        });
      }
    }
  }

  nuevoDano() async {
    var formato = DateFormat('yyyy-MM-dd hh:mm:ss'); 
    var fecha = formato.format(DateTime.now());

     dano = Dano(
      vin: widget.vin,
      panel: null,
      registroTipo: 'Regular',
      area: int.parse(_areaTextController.text.trim()),
      tipo: int.parse(_tipoTextController.text.trim()),
      severidad: _severidadTextController.text.trim(),
      notas: _notasTextController.text,
      estado: 'A',
      fecha_creacion: fecha
    );


    await DatabaseProvider.db.insertarDano(dano!).then((value) async {
      itemP.addBoton();
      itemP.deleteBoton();
      
      for(var ed in evidenciasDano) {
        evidencia = Evidencia(
          vin: widget.vin,
          iddano: value,
          nombre: null,
          archivo: ed,
          fechahora: fecha
        );

        await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) {
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          itemP.addError();
        });
      }

      Fluttertoast.showToast(
        msg: "Daño guardado con Exito!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20
      );

      paraLimpiar();

    }).timeout(const Duration(seconds: 60), onTimeout: () {
      itemP.addError();
    });
  }

  paraLimpiar() {
    _areaTextController.clear();
    _tipoTextController.clear();
    _severidadTextController.clear();
    _notasTextController.clear();

    setState(() {
      evidenciasDano = [];
    });

  }
}