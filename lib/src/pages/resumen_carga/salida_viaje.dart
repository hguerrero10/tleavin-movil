import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/viaje.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_inspector.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_operador.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_operadorLogico.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ResumenViaje extends StatefulWidget {
  final Viaje? viaje;
  const ResumenViaje({super.key,  this.viaje});

  @override
  State<ResumenViaje> createState() => _ResumenViajeState();
}

class _ResumenViajeState extends State<ResumenViaje> {

  final slideActionKey = GlobalKey<SlideActionState>();

  Evidencia? evidencia;
  Vin? dataVine;
  List<Dano>? dataDano;
  List<Evidencia>? dataEvidencia;
  var firmas = [];
  var formatWH;
  var fechaH;
  var firmascolectadas = [];
  final ImagePicker picker = ImagePicker();

  String? fotoIdentificacion;

  var vinesViaje =  [];

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

  vinesDelViaje() async {
    var vxv = await  DatabaseProvider.db.vinesXviaje(widget.viaje!.idviaje);
    setState(() {
      vinesViaje = vxv;
    });
  }

  obtenerVine(v) async {
    Vin? data;
    data = await DatabaseProvider.db.obtenerVIN(v);

    setState(() {
      dataVine = data;
    });
  }

  obtenerDanos(v) async {
    List<Dano>? data;
    data = await DatabaseProvider.db.fetchDanos(v,'');

    setState(() {
      dataDano = data;
    });
  }

  Image imageFromBase64String(base64) {
    return Image.memory(
      base64Decode(base64),
      fit: BoxFit.cover,
      width: 75,
    );
  }

  @override
  void initState() {
    initializeDateFormatting();
    formatWH = DateFormat('yyyyy-MM-dd hh:mm:ss'); 
    fechaH = formatWH.format(DateTime.now());

    vinesDelViaje();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirmExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Quieres salir de la aplicación?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); 
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); 
                },
                child: const Text('Sí')
              )
            ]
          )
        );
        return confirmExit;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
          title: const Text(
            'Resumen de Viaje',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
          )
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                _encabezados('Unidad: ', widget.viaje!.num_eco_unidad!),
                _encabezados('Operador: ', widget.viaje!.nombre_operador!),
                // _encabezados('Cliente: ', widget.viaje!.cliente_nombre!),
                _encabezados('Origen: ', widget.viaje!.origen),
                _encabezados('Destino: ', widget.viaje!.destino),
                
                const SizedBox(height: 10),
                listaVinesViaje(vinesViaje),
                
                const SizedBox(height: 20),
                ElevatedButton(
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const FirmaOpLogicoWidget()))),
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
                const SizedBox(height: 20),
                ElevatedButton(
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
                        Icons.person,
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
                const SizedBox(height: 20),
                Center(
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
                              'ID Operador Logistico',
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
                ),
                const SizedBox(height: 40),          
                Center(
                  child: SlideAction(
                    height: 70,
                    sliderRotate: false,
                    outerColor: const Color.fromRGBO(242, 211, 0, 1),
                    alignment: Alignment.centerRight,
                    innerColor: Colors.black,
                    elevation: 1,
                    text: 'Deslizar para Confirmar',
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    onSubmit: () {

                      //HG891042!
                  
                       return guardarFirmasySalida();
                    }
                  )
                ),
                const SizedBox(height: 20)
              ]
            )
          )
        )
      )
    );
  }

  Widget _encabezados(tit, sub) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            tit ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(
            width: 210,
            child: Text(
              sub ?? '',
              style: const TextStyle(
                fontSize: 18
              )
            )
          )
        ]
      )
    );
  }

  Widget _encabezadosVin(tit, sub) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            tit ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(
            width: 90,
            child: Text(
              sub ?? '',
              style: const TextStyle(
                fontSize: 18
              )
            )
          )
        ]
      )
    );
  }

  Widget listaVinesViaje(listav) {
    return listav != null ? ListView.builder(
      itemCount: listav.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            await obtenerVine(listav[index]['vin']);
            await obtenerDanos(listav[index]['vin']);

            _dialogBuilder(context, dataVine);
          },
          child: Card(
            child: ListTile(
              title: Text('Vin: ${listav[index]['vin']}'),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: []
              )
            )
          )
        );
      }
    ) : const SizedBox();
  }

  Future<void> _dialogBuilder(BuildContext context, vine) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                'VIN: ${vine.vin}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                )
              ),
              const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20
              )
            ]
          ),
          content: Container(
            height: 500,
            width: 900,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _encabezadosVin('Viaje: ', vine.idviaje != null ? ' ${vine.idviaje}' : 'Sin Asignar'),
                  _encabezadosVin('Posicion: ', vine.posicion != null ? ' ${vine.posicion}' : 'Sin Asignar'),
                  _encabezadosVin('Orientacion: ', vine.orientacion != null ? ' ${vine.orientacion}' : 'Sin Asignar'),

                  _cardDanos(dataDano)
                ]
              )
            )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge
              ),
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context)
            )
          ]
        );
      }
    );
  }

  Widget _cardDanos(da) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: da.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dato = da[index];
        var totalda = index + 1;
        return Card(
          elevation: 3,
          shadowColor: Colors.black,
          surfaceTintColor: const Color.fromRGBO(242, 211, 0, 1),
          child: SizedBox(
            height: 590,
            width: 800,
            child: Container(
              padding: const EdgeInsets.only(left:16, right: 16),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: [
                        const Text(
                          'Daño: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          '$totalda',
                          style: const TextStyle(
                            fontSize: 18
                          )
                        )
                      ]
                    ),
                    subtitle: SizedBox(
                      child: Row(
                        children: [
                          Text(
                            'Panel: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6)
                            )
                          ),
                          Text(
                            dato.panel ?? 'General',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6)
                            )
                          )
                        ]
                      )
                    )
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                    height: 20
                  ),
            
                  dato.area == null ? _encabezadosVin('Estado: ', '${dato.registroTipo}') : const SizedBox(),

                  dato.area == null ? const SizedBox() : _encabezadosVin('Codificacion: ', '${dato.area}-${dato.tipo}-${dato.severidad}'),
                  _encabezadosVin('Notas: ', dato.notas != '' ?  '${dato.notas}' : 'Sin notas'),
                  _encabezadosVin('Evidencias: ', ''),
    
                  _evidenciasDano(dato.evidencias)
                ]
              )
            )
          )
        );
      }
    );
  }

  guardarFirmasySalida() async {
    if(itemP.firmainspector != null && itemP.firmaOperador != null && itemP.firmaOperadorLogistico != null && fotoIdentificacion != null) {
      firmascolectadas.add({'nombre': 'Inspector', 'b64': itemP.firmainspector});
      firmascolectadas.add({'nombre': 'Operador', 'b64': itemP.firmaOperador});
      firmascolectadas.add({'nombre': 'Operador Logico', 'b64': itemP.firmaOperadorLogistico});
      firmascolectadas.add({'nombre': 'ID Operador Logico', 'b64': fotoIdentificacion});

      for(var ed in firmascolectadas) {
        evidencia = Evidencia(
          vin: null,
          iddano: null,
          idviaje: widget.viaje!.idviaje!,
          nombre: ed['nombre'],
          archivo: ed['b64'],
          fechahora: fechaH
        );

        await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) {
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          itemP.addError();
        });

        await DatabaseProvider.db.actualizarEstadoViaje(widget.viaje!.idviaje!).then((result) {}).timeout(const Duration(seconds: 60), onTimeout: () {
          itemP.addError();
        });
      }

      Fluttertoast.showToast(
        msg: "Embarque realizado con Exito!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20
      );

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);
    }
    else {
      Fluttertoast.showToast(
        msg: "Firmas y/o Fotografia faltante",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );

      setState(() {
        slideActionKey.currentState?.reset();
      });
    }
  }

  Widget _evidenciasDano(evi) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: evi.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dato = evi[index];
        return SizedBox(
          height: 95,
          width: 75, 
          child: WidgetZoom(
            heroAnimationTag: 'tag${dato.ide}',
            zoomWidget: imageFromBase64String('${dato.archivo}')
          )
        );
      }
    );
  }
}