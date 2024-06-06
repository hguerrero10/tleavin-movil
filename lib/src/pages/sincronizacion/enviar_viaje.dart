import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/viaje.dart';
import 'package:http/http.dart' as http;
import 'package:tleavin_mobil/provider/items_provider.dart';

class ViajesParaEnviar extends StatefulWidget {
  const ViajesParaEnviar({super.key});

  @override
  State<ViajesParaEnviar> createState() => _ViajesParaEnviarState();
}

class _ViajesParaEnviarState extends State<ViajesParaEnviar> {
  String urlEnvioViaje = 'http://tleavin.tlea.online/movil/viaje';
  var _stream;
  var enviando = false;

  @override
  void initState() {
    super.initState();

    _stream = DatabaseProvider.db.obtenerViajesParaSincronizar().asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Viajes para Sincronizar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: lista()
    );
  }

  Widget lista() {
    return StreamBuilder<List<Viaje>>(
      stream: _stream,
      builder: (context, AsyncSnapshot<List<Viaje>>snapshot) {
        if(snapshot.hasData) {
          return snapshot.data!.isNotEmpty ? ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final dato = snapshot.data![index];
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        enviando = true;
                      });

                      enviarViaje(dato.idviaje);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              'assets/img/card uno.png',
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "Numero Eco.: ",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      Text(
                                        '${dato.num_eco_unidad}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[800]
                                        )
                                      )
                                    ]
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Operador: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          '${dato.nombre_operador}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[800]
                                          )
                                        )
                                      )
                                    ]
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Cliente: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      SizedBox(
                                        width: 260,
                                        child: Text(
                                          '${dato.cliente_nombre}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[800]
                                          )
                                        )
                                      )
                                    ]
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Origen: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold
                                            )
                                          ),
                                          Text(
                                            '${dato.origen}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]
                                            )
                                          )
                                        ]
                                      ),
                                      const SizedBox(width: 20),
                                      Row(
                                        children: [
                                          Text(
                                            'Destino: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold
                                            )
                                          ),
                                          Text(
                                            '${dato.destino}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]
                                            )
                                          )
                                        ]
                                      )
                                    ]
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Spacer(),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.transparent
                                        ),
                                        child: Container(
                                          width: 100,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.black
                                          ),
                                          child: const Text(
                                            "Sincronizar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Color.fromRGBO(242, 211, 0, 1))
                                          )
                                        ),
                                        onPressed: () => enviarViaje(dato.idviaje)
                                      )
                                    ]
                                  )
                                ]
                              )
                            ),
                            const SizedBox(height: 5)
                          ]
                        )
                      )
                    )
                  ),
                  enviando != false ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 315,
                      width: 370,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const SizedBox(
                        height: 120,
                        width: 120,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(242, 211, 0, 1)),
                            strokeWidth: 5
                          )
                        )
                      )
                    ),
                  ) : const SizedBox()
                ]
              );
            }
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.route_rounded, color: Colors.grey[300], size: 100),
                const SizedBox(height: 10),
                Text(
                  'Sin Viajes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 19
                  )
                )
              ]
            )
          );
        } 
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Future enviarViaje(idviaje) async {
    var datos = await DatabaseProvider.db.envioViajeCompleto(idviaje);
    String token = "83c44c8cf9264486e94906844090e30b89a21715";

    var limpio = datos.toString().replaceAll('"{', "{").replaceAll('}"', "}");

    try{
      http.Response response = await http.post(Uri.parse(urlEnvioViaje), body: limpio, headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"});

      if(response.statusCode == 200) {
        await DatabaseProvider.db.actualizarEstadoViajeSincronizado(idviaje);

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
                    'Viaje Sincronizado al Servidor', 
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

          setState(() {
            enviando = false;
          });

          setState(() {
            _stream = DatabaseProvider.db.obtenerViajesParaSincronizar().asStream();
          });
      } 
      else {
          setState(() {
            enviando = false;
          });
        Fluttertoast.showToast(
          msg: "Favor de comunicarse a soporte (Error: ${response.statusCode}) $response'",
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