import 'dart:convert';
import 'dart:developer';
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
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class Sincronizar extends StatefulWidget {
  const Sincronizar({super.key});

  @override
  State<Sincronizar> createState() => _SincronizarState();
}

class _SincronizarState extends State<Sincronizar> {

  String urlEnvioViaje = 'http://tleavin.tlea.online/movil/viaje';
  // String urlEnvioVIN = 'http://api-pruebas.tlea.online/agreagrVIN';


  String urlAreaDanoServer = 'http://api-pruebas.tlea.online/obtenerAreaDano';
  AreaDano? areaDanoInsertList;

  String urlTipoDanoServer = 'http://api-pruebas.tlea.online/obtenertipoDano';
  TipoDano? tipoDanoInsertList;

  String urlSeveridadServer = 'http://api-pruebas.tlea.online/obtenerSeveridad';
  Severidad? severidadInsertList;
  
  String urlClienteServer = 'http://api-pruebas.tlea.online/obtenerCliente';
  Cliente? clienteInsertList;

  var viajesCompletos = [];


  obtenerAreaDanoServer() async {
    var responseData;
    try{
      final result = await InternetAddress.lookup('api-pruebas.tlea.online');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try{
          await http.get(Uri.parse(urlAreaDanoServer),headers: {"Content-Type" : "application/json"}).then((value) async {
            if(value.statusCode == 200) {
              Fluttertoast.showToast(
                msg: "Conexion Exitosa al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

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
                log('Area Dano');
                await DatabaseProvider.db.insertarAreaDano(areaDanoInsertList!);
              }

              Fluttertoast.showToast(
                msg: "${responseData['AreaDanos'].length} Area Daños Sincronizados",
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
              Fluttertoast.showToast(
                msg: "Conexion Exitosa al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDTipoDano();
              for(var value in responseData['TiposDano']) {
                tipoDanoInsertList = null;
                tipoDanoInsertList = TipoDano(
                  id: value['id'], 
                  descripcion: value['descripcion']
                );
                log('Tipo Dano');
                await DatabaseProvider.db.insertarTipoDano(tipoDanoInsertList!);
              }

              Fluttertoast.showToast(
                msg: "${responseData['TiposDano'].length} Tipo Daños Sincronizados",
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
              Fluttertoast.showToast(
                msg: "Conexion Exitosa al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDSeveridad();
              for(var value in responseData['Severidades']) {
                severidadInsertList = null;
                severidadInsertList = Severidad(
                  id: value['id'],
                  tipo: value['tipo'],
                  descripcion: value['descripcion']
                );
                log('Severidad');
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
              Fluttertoast.showToast(
                msg: "Conexion Exitosa al Servidor",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20
              );

              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDCliente();
              log(responseData['Clientes'].length.toString());
              for(var value in responseData['Clientes']) {
                clienteInsertList = null;
                clienteInsertList = Cliente(
                  idAdvan: value['idAdvan'],
                  cliente: value['cliente']
                );
                log('Cliente');
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

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(30)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    )
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        CupertinoIcons.car_detailed,
                        color: Colors.white,
                        size: 40
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sincronizar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      ),
                      Text(
                        'VINs',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      )
                    ]
                  )
                ),
                ElevatedButton(
                  onPressed: () => enviarViaje(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(242, 211, 0, 1)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(30)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    )
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.route,
                        color: Colors.black,
                        size: 40
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sincronizar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                        )
                      ),
                      Text(
                        'Viajes',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                        )
                      )
                    ]
                  )
                )
              ]
            ),

            const SizedBox(height: 10),

            botonSincronizar(Icons.dangerous_outlined, 'Sincronizar Area Daños', () => obtenerAreaDanoServer()),
            botonSincronizar(Icons.list, 'Sincronizar Tipo Daños', () => obtenerTipoDanoServer()),
            botonSincronizar(Icons.warning, 'Sincronizar Severidad', () => obtenerSeveridadServer()),

            botonSincronizar(Icons.people, 'Sincronizar Clientes', () => obtenerClienteServer())
          ]
        )
      )
    );
  }

  Widget botonSincronizar(ico, titulo, onpress) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: onpress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            )
          )
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

  Future enviarViaje() async {
    String token = "83c44c8cf9264486e94906844090e30b89a21715";
    var datos = await DatabaseProvider.db.enviarViajeServer();
    
    try{
      http.Response response = await http.post(Uri.parse(urlEnvioViaje), body: datos, headers: {
        "Content-Type" : "application/json",
        "Authorization":  "Bearer $token"
      });
      
      if(response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Conexion Exitosa al Servidor",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20
        );

        Fluttertoast.showToast(
          msg: "Viajes Sincronizados al Servidor",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20
        );
      } 
      else {
        _dialogBuilder(context, 'A ocurrido un problema, Favor de comunicarse a soporte (Error: ${response.statusCode}) $response');
        itemP.addError();
      }
    }
    catch (e) {
      log(e.toString());
    }
  }

  Future<void> _dialogBuilder(context, er) {
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
              onPressed: () => Navigator.pop(context)
            )
          ]
        );
      }
    );
  }
}