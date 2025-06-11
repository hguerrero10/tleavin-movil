import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:tleavin_mobil/src/pages/dano/listas.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';

class EnviarCompraVin extends StatefulWidget {
  const EnviarCompraVin({super.key});

  @override
  State<EnviarCompraVin> createState() => _EnviarCompraVinState();
}

class _EnviarCompraVinState extends State<EnviarCompraVin> {
  String urlEnviarData = 'https://parapruebas.tlea.online/guardarVINCompra';

  List<ListasA> listaCliente = [];
  List<ListasD> listaDestino = [];

  var todosVins = [];
  var fotosTarja = [];

  var verBotonTarja = false;
  var verBotonEnviar = false;
  var iddetarja = 0;
  var click = 0;

  var enviando = false;

  var vins = [];
  var vinsComprados = [];

  @override
  void initState() {
    super.initState();

    obtenerListaVINES();
  }

  obtenerListaVINES() async {
    var data = await DatabaseProvider.db.obtenerListaVinsSinSincronizar();
    var vc = [];

    for(var d in data) {
      vc.add({'vin': d.vin, 'idv': d.idv}); // Guardar tanto vin como idv
    }

    setState(() {
      vinsComprados = vc;
      vins = vinsComprados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Sincronizacion de Compra',
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
                  '${vins.length}',
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vins.length,
                itemBuilder: (context, index) {
                  final vinData = vins[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.directions_car, color: Colors.amber),
                      title: Text(
                        vinData['vin'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('ID: ${vinData['idv'] ?? ''}'),
                    )
                  );
                }
              )
            ),

            const SizedBox(height: 20),

           vins.length > 0 ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      // if(fotosTarja.isNotEmpty) {
                        setState(() {
                          enviando = true;
                        });
                        
                        enviarData();
                      // }
                      // else {
                      //   Fluttertoast.showToast(
                      //     msg: "Favor de tomar Fotografia de Tarja",
                      //     toastLength: Toast.LENGTH_LONG,
                      //     gravity: ToastGravity.BOTTOM,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 20
                      //   );
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 5,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.send,
                          color: Colors.white
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Enviar VINES',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          )
                        )
                      ]
                    )
                  )
                ),
                enviando != false ? Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 80,
                    width: 810,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const SizedBox(
                      height: 120,
                      width: 611,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(242, 211, 0, 1)),
                          strokeWidth: 5
                        )
                      )
                    )
                  )
                ) : const SizedBox()
              ],
            ) : const SizedBox()
          ]
        )
      )
    );
  }

  Widget botonSincronizar(ico, titulo, onpress) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80, bottom: 16),
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






























































  Future enviarData() async {
    int sincronizados = 0;
    for (var element in vins) {
      var formato = DateFormat('yyyy-MM-dd hh:mm:ss');
      var fecha = formato.format(DateTime.now());
      log(element['vin']);
      var vines = await DatabaseProvider.db.fetchVINServer(element['vin'].toString(), iddetarja);

      try {
        var limpio = vines.toString();
        if (limpio.startsWith('[')) {
          limpio = limpio.substring(1);
        }

        if (limpio.endsWith(']')) {
          limpio = limpio.substring(0, limpio.length - 1);
        }

        http.Response response = await http.post(Uri.parse(urlEnviarData), body: limpio, headers: {"Content-Type": "application/json"});

        if (response.statusCode == 200) {
          var vinsin = (
            vin: element['vin'],
            fecha_sync: fecha
          );

          await DatabaseProvider.db.marcarComoSincronizado(vinsin).then((value) {}).timeout(const Duration(seconds: 30), onTimeout: () {
            itemP.addError();
          });

          sincronizados++;

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
                    'VIN Sincronizado',
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

        } else {
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
      } catch (e) {
        log(e.toString());
      }

      await Future.delayed(const Duration(seconds: 2));
    }

    setState(() {
      enviando = false;
    });

    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sincronización completada'),
          content: Text('$sincronizados VIN(es) fueron sincronizados.'),
          actions: [
            TextButton(
              onPressed: () {
                
                obtenerListaVINES();
                Navigator.of(context).pop();
              }, 
              child: const Text('OK')
            )
          ],
        ),
      );
    }
  }
}