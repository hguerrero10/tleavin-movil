import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class Sincronizar extends StatefulWidget {
  const Sincronizar({super.key});

  @override
  State<Sincronizar> createState() => _SincronizarState();
}

class _SincronizarState extends State<Sincronizar> {

  String urlEnvioViaje = 'http://192.168.1.74:3000/addViaje';
  String urlEnvioVIN = 'http://192.168.1.74:3000/addVin';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Sincronizacion',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo()
          ]
        )
      )
    );
  }

  Future enviarViaje() async {
      var json;
      var res;
      
      try{
        https.Response response = await https.post(Uri.parse(urlEnvioViaje), body: json, headers: { "Content-Type" : "application/json"});
        res = jsonDecode(response.body);
        if(response.statusCode == 200) {
          
          Fluttertoast.showToast(
            msg: "Conexion Exitosa al Server",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20
          );

          await viajesparaserver();
        } 
        else {
          _dialogBuilder(context, 'A ocurrido un problema, Favor de comunicarse a soporte(Error:s ${response.statusCode})');
          itemP.addError();
        }
      } catch (e) {
        log(e.toString());
      }
  }

  viajesparaserver() {

  }

  Future<void> _dialogBuilder(BuildContext context, er) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                'Error',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                )
              ),
              Divider(
                color: Colors.black,
                thickness: 1.0
              )
            ]
          ),
          content: SizedBox(
            height: 210,
            child: Column(
              children: [
               Text(er)
              ]
            )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {}
            ),
          ],
        );
      },
    );
  }
}