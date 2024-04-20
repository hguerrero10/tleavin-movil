import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/model/viaje.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_inspector.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_operador.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_operadorLogico.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

class ResumenViaje extends StatefulWidget {
  final Viaje? viaje;
  const ResumenViaje({super.key,  this.viaje});

  @override
  State<ResumenViaje> createState() => _ResumenViajeState();
}

class _ResumenViajeState extends State<ResumenViaje> {

  Evidencia? evidencia;
  var firmas = [];
  var formatWH;
  var fechaH;
  var firmascolectadas = [];

  @override
  void initState() {
    initializeDateFormatting();
    formatWH = DateFormat('yyyy/MM/dd HH:mm:ss'); 
    fechaH = formatWH.format(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (g) {
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
                _encabezados('Cliente: ', widget.viaje!.cliente_nombre!),
                _encabezados('Origen: ', widget.viaje!.origen),
                _encabezados('Destino: ', widget.viaje!.destino),
                const SizedBox(height: 30),
                
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Firma Inspector',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      )
                    ]
                  )
                ),
                const SizedBox(height: 10),
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Firma Operador Logistico',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Firma Operador',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      )
                    ]
                  )
                ),
                const SizedBox(height: 90),
                Center(
                  child: GradientSlideToAct(
                    width: 320,
                    height: 65,
                    dragableIcon: Icons.arrow_forward,
                    text: 'Desliza para Confirmar',
                    textStyle: const TextStyle(
                      color: Colors.white, 
                      fontSize: 16
                    ),
                    backgroundColor: Colors.black,
                    onSubmit: () => guardarFirmasySalida(),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(242, 211, 0, 1),
                        Color.fromRGBO(242, 211, 0, 1)
                      ]
                    )
                  )
                )
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
          Text(
            sub ?? '',
            style: const TextStyle(
              fontSize: 18
            )
          )
        ]
      )
    );
  }

  guardarFirmasySalida() async {
    firmascolectadas.add({'nombre': 'Inspector', 'firma': itemP.firmainspector});
    firmascolectadas.add({'nombre': 'Operador', 'firma': itemP.firmaOperador});
    firmascolectadas.add({'nombre': 'Operador Logico', 'firma': itemP.firmaOperadorLogistico});
    log(firmascolectadas.toString());

    for(var ed in firmascolectadas) {
      evidencia = Evidencia(
        vin: null,
        iddano: null,
        idviaje: widget.viaje!.idviaje!,
        nombre: ed['nombre'],
        archivo: ed['firma'],
        fechahora: fechaH
      );

      await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) {
        log('evidencia insertada');
        log('$value');
        
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        itemP.addError();
      });

      _dialogBuilder(context);
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                'Embarque con Exito!',
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
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/logistica.png',
                    width: 230,
                    height: 230
                  )
                ),
                const Text(
                  'Viaje en Curso',
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
              child: const Text('Ok'),
              onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false)
            )
          ]
        );
      }
    );
  }
}