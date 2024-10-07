import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tleavin_mobil/model/tarja.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:tleavin_mobil/src/pages/dano/listas.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';

class EnviarVentaVin extends StatefulWidget {
  const EnviarVentaVin({super.key});

  @override
  State<EnviarVentaVin> createState() => _EnviarVentaVinState();
}

class _EnviarVentaVinState extends State<EnviarVentaVin> {
  // String urlEnviarData = 'http://192.168.12.176:3888/guardarVIN';
  String urlEnviarData = 'https://parapruebas.tlea.online/guardarVIN';

  final ImagePicker picker = ImagePicker();

  String? base64Foto;
  Evidencia? evidencia;

  List<ListasA> listaCliente = [];
  List<ListasD> listaDestino = [];

  var todosVins = [];
  var fotosTarja = [];

  var verBotonTarja = false;
  var verBotonEnviar = false;
  var iddetarja = 0;
  var click = 0;

  var enviando = false;

  Future<List<ListasA>> getListas() async {
    List<ListasA> resultados = [];
    
    try {
      await DatabaseProvider.db.obtenerCliente().then((value) {
        setState(() {
          listaCliente = value.map((item) => ListasA(valor: item.idAdvan.toString(), texto: '${item.cliente}')).toList();
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
  }

  Future<List<ListasD>> getListaDestino(id) async {
    List<ListasD> resultados = [];

    try {
      await DatabaseProvider.db.obtenerDestinoXMarca(id).then((value) {
        setState(() {
          listaDestino = value.map((item) => ListasD(valor: item.id_destino.toString(), texto: '${item.destino}')).toList();
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
  }

  obtenerlistaCompletaVins(marca, destino) async {
    var datos = await DatabaseProvider.db.obtenerListaVINESDisponiblesDestino(marca, destino);
    
    setState(() {
      todosVins = datos;

      if(todosVins.isEmpty) {
        Fluttertoast.showToast(
          msg: "No se encontraron VINES para Destino: ${itemP.destinoSeleccionado}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
          fontSize: 20
        );

        verBotonTarja = false;
      }
      else {
        verBotonTarja = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
    getListas();
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

            _dropDownCliente(),
            _dropDownDestino(),

            const SizedBox(height: 40),

            verBotonTarja != false ? Row(
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
            ) : const SizedBox(),

            const SizedBox(height: 30),

            verBotonTarja != false ? Row(
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
            ) : const SizedBox(),
            const SizedBox(height: 30),
            verBotonTarja != false ? botonSincronizar(
              Icons.save,
              'Guardar Fotos',
              () {
                guardarFotosTarja();
              }
            ) : const SizedBox(),

            const SizedBox(height: 200),

            verBotonEnviar != false ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if(fotosTarja.isNotEmpty) {
                        setState(() {
                          enviando = true;
                        });
                        
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
                    width: 410,
                    decoration: BoxDecoration(
                      color: Colors.white38,
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
          click + 1;
          // fotosTarja.add(base64Foto);
          fotosTarja.add({'nombre': 'foto_tarja_$click', 'b64': base64Foto});
        });
      }
    }
  }

  guardarFotosTarja() async {
    var formato = DateFormat('yyyy-MM-dd hh:mm:ss'); 
    var fecha = formato.format(DateTime.now());

    var tarja = Tarja(
      destino: itemP.destinoSeleccionado,
      vines: todosVins.length,
      registro: fecha,
      registrado_por: itemP.usuario!.usuario!
    );
    
    await DatabaseProvider.db.insertarTarja(tarja).then((value) async {
      for(var ed in todosVins) {
        var vines = (
          vin: ed.vin,
          idviaje: value
        );

        await DatabaseProvider.db.asignarTarja(vines).then((value) {}).timeout(const Duration(seconds: 30), onTimeout: () {
          itemP.addError();
        });
      }

      for(var ft in fotosTarja) {
        evidencia = Evidencia(
          vin: null,
          iddano: null,
          idviaje: value,
          nombre: ft['nombre'],
          archivo: ft['b64'],
          fechahora: fecha
        );

        await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) {}).timeout(const Duration(seconds: 60), onTimeout: () {
          itemP.addError();
        });

        setState(() {
          verBotonEnviar = true;
          iddetarja = value;
        });
      }
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });
  }
  
  pruebafor() async {
    var formato = DateFormat('yyyy-MM-dd hh:mm:ss'); 
    var fecha = formato.format(DateTime.now());

    for(var ed in todosVins) {
      var vines = (
        vin: ed.vin,
        fecha_sync: fecha
      );

      await DatabaseProvider.db.marcarComoSincronizado(vines).then((value) {}).timeout(const Duration(seconds: 30), onTimeout: () {
        itemP.addError();
      });
    }
  }

  Widget _dropDownCliente() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasA>(
          items: listaCliente,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "* Seleccione Cliente",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasA? item) {
          setState(() {
            itemP.addClienteSeleccionado(item?.texto);

            getListaDestino(item?.valor);
          });
        },
        itemAsString: (ListasA item) => item.texto,
        validator: (value) {
          if(value == null) {
            return 'Favor de Seleccionar Cliente';
          }

          return null;
        },
      )
    );
  }

  Widget _dropDownDestino() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasD>(
          items: listaDestino,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "* Seleccione Destino",
            hintStyle: TextStyle(
              color: Colors.grey
            )
          )
        ),
        onChanged: (ListasD? item) {
          setState(() {
            itemP.addDestinoSeleccionado(item?.texto);
            obtenerlistaCompletaVins(itemP.clienteSeleccionado, item?.texto);
          });
        },
        itemAsString: (ListasD item) => item.texto,
        validator: (value) {
          if(value == null) {
            return 'Favor de Seleccionar Destino';
          }

          return null;
        },
      )
    );
  }

  Future enviarData() async {
    // var vines = await DatabaseProvider.db.fetchVINES(itemP.clienteSeleccionado, itemP.destinoSeleccionado, iddetarja);
    var vines = await DatabaseProvider.db.enviarConTarja(itemP.clienteSeleccionado, itemP.destinoSeleccionado, iddetarja);
    try{
      http.Response response = await http.post(Uri.parse(urlEnviarData), body: vines.toString(), headers: {"Content-Type": "application/json"});

      if(response.statusCode == 200) {
        pruebafor();
      
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
                  'VINES Sincronizados', 
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

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);
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