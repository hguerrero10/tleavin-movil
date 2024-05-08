import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/areaDano.dart';
import 'package:tleavin_mobil/model/cliente.dart';
import 'package:tleavin_mobil/model/severidad.dart';
import 'package:tleavin_mobil/model/tipo_dano.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/sincronizacion/enviar_viaje.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class Sincronizar extends StatefulWidget {
  const Sincronizar({super.key});

  @override
  State<Sincronizar> createState() => _SincronizarState();
}

class _SincronizarState extends State<Sincronizar> {

  String urlAreaDanoServer = 'http://api-pruebas.tlea.online/obtenerAreaDano';
  AreaDano? areaDanoInsertList;

  String urlTipoDanoServer = 'http://api-pruebas.tlea.online/obtenertipoDano';
  TipoDano? tipoDanoInsertList;

  String urlSeveridadServer = 'http://api-pruebas.tlea.online/obtenerSeveridad';
  Severidad? severidadInsertList;
  
  String urlClienteServer = 'http://api-pruebas.tlea.online/obtenerCliente';
  Cliente? clienteInsertList;

  obtenerAreaDanoServer() async {
    var responseData;
    try{
      final result = await InternetAddress.lookup('api-pruebas.tlea.online');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try{
          await http.get(Uri.parse(urlAreaDanoServer),headers: {"Content-Type" : "application/json"}).then((value) async {
            if(value.statusCode == 200) {
              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDAreaDano();

              for(var value in responseData['AreaDanos']) {
                areaDanoInsertList = null;
                areaDanoInsertList = AreaDano(
                  id: value['id'], 
                  codigo: value['codigo'], 
                  area: value['area'], 
                  descripcion: value['descripcion']
                );
                
                await DatabaseProvider.db.insertarAreaDano(areaDanoInsertList!);
              }

              Fluttertoast.showToast(
                msg: "${responseData['AreaDanos'].length} Areas Daños Sincronizados",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

              itemP.addDanoAreaInsert();
            } 
            else {
              itemP.addAreaDanoInsertTimeOut();
              itemP.addRegistroAreaDano();
              Fluttertoast.showToast(
                msg: "Conexion sin Exito al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 20
              );
            }
          }).timeout(const Duration(seconds: 15), onTimeout: () {
            itemP.addAreaDanoInsertTimeOut();
            itemP.addRegistroAreaDano();
            Fluttertoast.showToast(
              msg: "Conexion sin Exito al Servidor",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20
            );
          });
        } 
        catch (e) {
          Fluttertoast.showToast(
            msg: "Conexion sin Exito al Servidor",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20
          );
          itemP.addRegistroAreaDano();
          itemP.addAreaDanoInsertTimeOut();
        }
      }
    } on SocketException catch (_) {
      itemP.addAreaDanoInsertTimeOut();
      itemP.addRegistroAreaDano();
      Fluttertoast.showToast(
        msg: "Conexion sin Exito al Servidor",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }

  obtenerTipoDanoServer() async {
    var responseData;
    try{
      final result = await InternetAddress.lookup('api-pruebas.tlea.online');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try{
          await http.get(Uri.parse(urlTipoDanoServer),headers: {"Content-Type" : "application/json"}).then((value) async {
            if(value.statusCode == 200) {

              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDTipoDano();

              for(var value in responseData['TiposDano']) {
                tipoDanoInsertList = null;
                tipoDanoInsertList = TipoDano(
                  id: value['id'], 
                  descripcion: value['descripcion']
                );
                
                await DatabaseProvider.db.insertarTipoDano(tipoDanoInsertList!);
              }

              Fluttertoast.showToast(
                msg: "${responseData['TiposDano'].length} Tipos Daños Sincronizados",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

              itemP.addTipoDanoInsert();
            } 
            else {
              itemP.addTipoDanoInsertTimeOut();
              itemP.addRegistroTipoDano();
              Fluttertoast.showToast(
                msg: "Conexion sin Exito al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 20
              );
            }
          }).timeout(const Duration(seconds: 15), onTimeout: () {
            itemP.addTipoDanoInsertTimeOut();
            itemP.addRegistroTipoDano();
            Fluttertoast.showToast(
              msg: "Conexion sin Exito al Servidor",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20
            );
          });
        } 
        catch (e) {
          Fluttertoast.showToast(
            msg: "Conexion sin Exito al Servidor",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20
          );
          itemP.addRegistroTipoDano();
          itemP.addTipoDanoInsertTimeOut();
        }
      }
    } on SocketException catch (_) {
      itemP.addTipoDanoInsertTimeOut();
      itemP.addRegistroTipoDano();
      Fluttertoast.showToast(
        msg: "Conexion sin Exito al Servidor",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }

  obtenerSeveridadServer() async {
    var responseData;
    try{
      final result = await InternetAddress.lookup('api-pruebas.tlea.online');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try{
          await http.get(Uri.parse(urlSeveridadServer),headers: {"Content-Type" : "application/json"}).then((value) async {
            if(value.statusCode == 200) {
              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDSeveridad();

              for(var value in responseData['Severidades']) {
                severidadInsertList = null;
                severidadInsertList = Severidad(
                  id: value['id'],
                  tipo: value['tipo'],
                  descripcion: value['descripcion']
                );

                await DatabaseProvider.db.insertarSeveridad(severidadInsertList!);
              }

              Fluttertoast.showToast(
                msg: "${responseData['Severidades'].length} Severidades Sincronizadas",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

              itemP.addSeveridadInsert();
            } 
            else {
              itemP.addSeveridadInsertTimeOut();
              itemP.addRegistroSeveridad();
              Fluttertoast.showToast(
                msg: "Conexion sin Exito al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 20
              );
            }
          }).timeout(const Duration(seconds: 15), onTimeout: () {
            itemP.addSeveridadInsertTimeOut();
            itemP.addRegistroSeveridad();
            Fluttertoast.showToast(
              msg: "Conexion sin Exito al Servidor",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20
            );
          });
        } 
        catch (e) {
          Fluttertoast.showToast(
            msg: "Conexion sin Exito al Servidor",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20
          );
          itemP.addRegistroSeveridad();
          itemP.addSeveridadInsertTimeOut();
        }
      }
    } on SocketException catch (_) {
      itemP.addSeveridadInsertTimeOut();
      itemP.addRegistroSeveridad();
      Fluttertoast.showToast(
        msg: "Conexion sin Exito al Servidor",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }

  obtenerClienteServer() async {
    var responseData;
    try{
      final result = await InternetAddress.lookup('api-pruebas.tlea.online');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try{
          await http.get(Uri.parse(urlClienteServer),headers: {"Content-Type" : "application/json"}).then((value) async {
            if(value.statusCode == 200) {
              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDCliente();

              for(var value in responseData['Clientes']) {
                clienteInsertList = null;
                clienteInsertList = Cliente(
                  idAdvan: value['idAdvan'],
                  cliente: value['cliente']
                );

                await DatabaseProvider.db.insertarCliente(clienteInsertList!);
              }

              Fluttertoast.showToast(
                msg: "${responseData['Clientes'].length} Clientes Sincronizados",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

              itemP.addClienteInsert();
            } 
            else {
              itemP.addClienteInsertTimeOut();
              itemP.addRegistroCliente();
              Fluttertoast.showToast(
                msg: "Conexion sin Exito al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 20
              );
            }
          }).timeout(const Duration(seconds: 15), onTimeout: () {
            itemP.addClienteInsertTimeOut();
            itemP.addRegistroCliente();
            Fluttertoast.showToast(
              msg: "Conexion sin Exito al Servidor",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20
            );
          });
        } 
        catch (e) {
          Fluttertoast.showToast(
            msg: "Conexion sin Exito al Servidor",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20
          );
          itemP.addRegistroCliente();
          itemP.addClienteInsertTimeOut();
        }
      }
    } on SocketException catch (_) {
      itemP.addClienteInsertTimeOut();
      itemP.addRegistroCliente();
      Fluttertoast.showToast(
        msg: "Conexion sin Exito al Servidor",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }

  borrarTodaBD() async {
    var datos = await  DatabaseProvider.db.obtenerViajesParaSincronizar();

    if(datos.isEmpty) {
      await DatabaseProvider.db.borrarBDViaje();
      await DatabaseProvider.db.borrarBDVINES();
      await DatabaseProvider.db.borrarBDDanos();
      await DatabaseProvider.db.borrarBDEvidencia();
    }
    else {
      Fluttertoast.showToast(
        msg: "Existen Viajes Sin Sincronizar",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }

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
          )
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const ViajesParaEnviar())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
                  padding: const EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.route,
                      color: Colors.black,
                      size: 40
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sincronizar Viajes',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                      )
                    )
                  ]
                )
              )
            ),

            const SizedBox(height: 40),

            botonSincronizar(Icons.people, 'Sincronizar Clientes', () => obtenerClienteServer()),
            botonSincronizar(Icons.dangerous_outlined, 'Sincronizar Area Daños', () => obtenerAreaDanoServer()),
            botonSincronizar(Icons.list, 'Sincronizar Tipo Daños', () => obtenerTipoDanoServer()),
            botonSincronizar(Icons.warning, 'Sincronizar Severidad', () => obtenerSeveridadServer()),

            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => _dialogBuilder(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Borrar Base de Datos',
                      style: TextStyle(
                        fontSize: 20,
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


  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                '¿Seguro que quieres borrar todo?',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                )
              ),
              Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20
              )
            ]
          ),
          content: Container(
            height: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              children: [
                Text(
                  'Se borrara toda la informacion de la Base de Datos de este Dispositivo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                )
              ]
            )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge
              ),
              child: const Text('No'),
              onPressed: () => Navigator.pop(context)
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge
              ),
              child: const Text('Si borrar todo'),
              onPressed: () => borrarTodaBD()
            )
          ]
        );
      }
    );
  }
}
