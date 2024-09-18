import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:http/http.dart' as http;

class EnviarVentaVin extends StatefulWidget {
  const EnviarVentaVin({super.key});

  @override
  State<EnviarVentaVin> createState() => _EnviarVentaVinState();
}

class _EnviarVentaVinState extends State<EnviarVentaVin> {

  String urlEnviarData = 'https://parapruebas.tlea.online/guardarVIN';

  var fotosTarja = [];
  final ImagePicker picker = ImagePicker();

  String? base64Foto;
  Evidencia? evidencia;
  var todosVins = [];

  obtenerlistaCompletaVins() async {
    var datos = await DatabaseProvider.db.obtenerListaVINESDisponibles();
    
    setState(() {
      todosVins = datos;
    });
  }

  @override
  void initState() {
    super.initState();
    
    obtenerlistaCompletaVins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Sincronizacion de Venta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${todosVins.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  )
                ),
                const SizedBox(width: 10),
                const Text(
                  'VINES Disponibles',
                  style: TextStyle(
                    fontSize: 18
                  )
                )
              ]
            ),
            const SizedBox(height: 20),
      
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
                          Icons.camera,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Tarja',
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
                      
                      Text('${fotosTarja.length}')
                    ]
                  )
                )
              ]
            ),

            const SizedBox(height: 40),

            botonSincronizar(
              Icons.send,
              'Enviar VINES',
              () {
                if(fotosTarja.isNotEmpty) {
                  enviarData();
                }
                else {
                  Fluttertoast.showToast(
                    msg: "Favor de tomar Fotografia de Tarja",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 20
                  );
                }
              }
            )
          ]
        )
      )
    );
  }

  Widget botonSincronizar(ico, titulo, onpress) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              ico,
              color: Colors.white
            ),
            const SizedBox(width: 10),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white
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
    var click = 0;
    if(value != null) {
      final imageData = await File(value).readAsBytes();
      
      if(foto == 1) {
        base64Foto = null;
        base64Foto = base64Encode(imageData);
        click +  1;

        setState(() {
          fotosTarja.add(base64Foto);
          fotosTarja.add({'nombre': 'foto_tarja_$click', 'b64': base64Foto});
        });
      }
    }
  }

  guardarFotosTarja() async {
    var formato = DateFormat('yyyy-MM-dd hh:mm:ss'); 
    var fecha = formato.format(DateTime.now());
    
    for(var ed in fotosTarja) {
      evidencia = Evidencia(
        vin: null,
        iddano: null,
        nombre: ed['nombre'],
        archivo: ed['b64'],
        fechahora: fecha
      );

      await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) {}).timeout(const Duration(seconds: 60), onTimeout: () {
        itemP.addError();
      });
    }
  }

  Future enviarData() async {
    var vines = await DatabaseProvider.db.fetchVINES();

    try{
      http.Response response = await http.post(Uri.parse(urlEnviarData), body: vines.toString(), headers: {"Content-Type": "application/json"});
      if(response.statusCode == 200) {
        final snackBar = SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.green,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 20
                ),
                SizedBox(width: 10),
                Text(
                  'ViNES Sincronizado al Servidor', 
                  style: TextStyle( 
                    fontWeight: FontWeight.bold, 
                    fontSize: 20
                  )
                )
              ]
            )
          )
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } 
      else {
        Fluttertoast.showToast(
          msg: "Favor de comunicarse a soporte (Error: ${response.statusCode}) ${response.reasonPhrase}'",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20
        );

        itemP.addError();
      }
    }
    catch (e) {
      log(e.toString());
    }
  }
}