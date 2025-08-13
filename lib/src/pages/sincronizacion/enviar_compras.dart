import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_inspector.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_operador.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_operadorLogico.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tleavin_mobil/model/evidencia.dart';
// import 'package:tleavin_mobil/src/home/inicio.dart';
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
  String urlEnviarFirmas = 'https://parapruebas.tlea.online/guardarVINCompraConFirmas';


  List<ListasA> listaCliente = [];
  List<ListasD> listaDestino = [];

  var todosVins = [];
  var fotosTarja = [];
  var verBotonTarja = false;
  var verBotonEnviar = false;
  var iddetarja = 0;
  var click = 0;
  var enviando = false;
  var enviandoFirmas = false;
  var vins = [];
  var vinsComprados = [];
  var firmascolectadas = [];
  var formatWH;
  var fechaH;


  var docus = 0;
  Evidencia? evidencia;

  final ImagePicker picker = ImagePicker();

  String? fotoIdentificacion;

  var idunico = DateTime.now().millisecondsSinceEpoch.toString();

  var firmasRealizadas = false;
  
  Future<void> getCamara() async {
    final List<XFile> pickedFileList = <XFile>[];
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxHeight: 720,
      maxWidth: 1280
    );

    if(photo != null) {
      await GallerySaver.saveImage(photo.path, albumName: 'TLEAVIN');
      setState(() {
        pickedFileList.add(XFile(photo.path));
        convertirBase64(photo.path);
      });
    }
  }

  convertirBase64(value) async {
    if(value != null) {
      final imageData = await File(value).readAsBytes();
      
      fotoIdentificacion = null;
      fotoIdentificacion = base64Encode(imageData);
    }
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
  void initState() {
    super.initState();
    formatWH = DateFormat('yyyyy-MM-dd hh:mm:ss'); 
    fechaH = formatWH.format(DateTime.now());
    
    obtenerListaVINES();

    itemP.deleteFirmaInspecctor();
    itemP.deleteFirmaOperador();
    itemP.deleteFirmaOperadorLogisticio();
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
                      leading: const Icon(Icons.directions_car, color: Colors.black),
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
            vins.isNotEmpty ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const FirmaInspectorWidget()))),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.edit_outlined,
                      color: Colors.white
                    ),
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Firma Inspector',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white
                              )
                            ),
                            const SizedBox(width: 10),
                            itemP.firmainspector != null ? const Icon(
                            Icons.check,
                              size: 30,
                              color: Colors.green
                            ) : const SizedBox()
                          ]
                        )
                      ]
                    )
                  ]
                )
              ),
            ) : const SizedBox(),

            vins.isNotEmpty ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const FirmaOperadorWidget()))),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white
                    ),
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Firma Operador',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white
                              )
                            ),
                            const SizedBox(width: 10),
                            itemP.firmaOperador != null ? const Icon(
                            Icons.check,
                              size: 30,
                              color: Colors.green
                            ) : const SizedBox()
                          ]
                        )
                      ]
                    )
                  ]
                )
              ),
            ) : const SizedBox(),
            
            vins.isNotEmpty ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const FirmaOpLogicoWidget()))),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.edit_outlined,
                      color: Colors.white
                    ),
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Firma Operador Logistico',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white
                              )
                            ),
                            const SizedBox(width: 10),
                            itemP.firmaOperadorLogistico != null ? const Icon(
                            Icons.check,
                              size: 30,
                              color: Colors.green
                            ) : const SizedBox()
                          ]
                        )
                      ]
                    )
                  ]
                )
              ),
            ) : const SizedBox(),





             vins.isNotEmpty ? Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () => getCamara(),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset(
                            'assets/img/camara.png',
                            width: 70,
                            height: 70,
                          ),
                          const Text(
                            'Fotografia',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      ),
                      fotoIdentificacion != null ? const Icon(
                        Icons.check_circle_rounded,
                        color: Color.fromARGB(255, 35, 63, 36),
                        size: 60
                      ) : const SizedBox()
                    ]
                  )
                )
              )
            ) : const SizedBox(),


            vins.isNotEmpty ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 5),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      enviandoFirmas = true;
                    });
                    
                    guardarFirmas();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    )
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save,
                        color: Colors.white
                      ),
                      SizedBox(width: 10),
                   
                      Row(
                        children: [
                          Text(
                            'Cargar Firmas',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white
                            )
                          ),
                         
                        ]
                      )
                        
                    ]
                  )
                ),
              ),
               enviandoFirmas != false ? Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 90,
                    width: 810,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: 611,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$docus/4',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20
                              ),
                            ),
                            const SizedBox(width: 10),
                            docus < 4 ? const CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(242, 211, 0, 1)),
                              strokeWidth: 5
                            ) : const SizedBox(),
                          ],
                        )
                      )
                    )
                  )
                ) : const SizedBox()
            
        ]) : const SizedBox(),









            
            
           vins.isNotEmpty ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: firmasRealizadas == true ? ElevatedButton(
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
                  ) : const SizedBox()
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

  guardarFirmas() async {
    if(itemP.firmainspector != null && itemP.firmaOperador != null && itemP.firmaOperadorLogistico != null && fotoIdentificacion != null) {
      firmascolectadas.add({'nombre': 'Inspector', 'b64': itemP.firmainspector});
      firmascolectadas.add({'nombre': 'Operador', 'b64': itemP.firmaOperador});
      firmascolectadas.add({'nombre': 'Operador Logico', 'b64': itemP.firmaOperadorLogistico});
      firmascolectadas.add({'nombre': 'ID Operador Logico', 'b64': fotoIdentificacion});

      for(var ed in firmascolectadas) {
        evidencia = Evidencia(
          vin: null,
          iddano: null,
          idviaje: int.parse(idunico),
          nombre: ed['nombre'],
          archivo: ed['b64'],
          fechahora: fechaH
        );

        await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) {
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          itemP.addError();
        });

        http.Response responseFirmas = await http.post(Uri.parse(urlEnviarFirmas), body: evidencia.toString(), headers: {"Content-Type": "application/json"});
        if (responseFirmas.statusCode == 200) {
          setState(() {
            docus +=  1;
          });

        } 
        else {
          log('Error al enviar firma ${ed['nombre']}: ${responseFirmas.statusCode} - ${responseFirmas.reasonPhrase}');
        } 

      }

      setState(() {
        firmasRealizadas = true;
        enviandoFirmas = true;
      });

    }
    else {
      Fluttertoast.showToast(
        msg: "Favor de capturar todas las firmas y tomar la fotografias",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
      setState(() {
        firmasRealizadas = false;

      enviandoFirmas = false;
    });
    }
  }

  Future enviarData() async {
    int sincronizados = 0;
    for (var element in vins) {
      var vinsin = (
        vin: element['vin'],
        idviaje: idunico
      );

      await DatabaseProvider.db.marcarConLaFirma(vinsin).then((value) {}).timeout(const Duration(seconds: 30), onTimeout: () {
        itemP.addError();
      });


      var formato = DateFormat('yyyy-MM-dd hh:mm:ss');
      var fecha = formato.format(DateTime.now());
      var vines = await DatabaseProvider.db.fetchVINServer(element['vin'].toString(), idunico);

      try {
        var limpio = vines.toString();
        
        if(limpio.startsWith('[')) {
          limpio = limpio.substring(1);
        }

        if(limpio.endsWith(']')) {
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

      await Future.delayed(const Duration(seconds: 2));
    }

    setState(() {
      enviando = false;
    });

    if(context.mounted) {
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
          ]
        )
      );
    }
  }


}