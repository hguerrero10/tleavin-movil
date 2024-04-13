import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/hacershowdialogsalidaviaje.dart';
import 'package:tleavin_mobil/src/pages/dano/resumen_dano.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_inspector.dart';

class ResumenViaje extends StatefulWidget {
  const ResumenViaje({super.key});

  @override
  State<ResumenViaje> createState() => _ResumenViajeState();
}

class _ResumenViajeState extends State<ResumenViaje> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                const Text('Unidad: TLEA-458', style: TextStyle(fontSize: 18.0)),
                const Text('Bitacora: 789654', style: TextStyle(fontSize: 18.0)),
                const Text('Carta Porte: CMTY-745632', style: TextStyle(fontSize: 18.0)),
                const Text('Cliente: Mazda', style: TextStyle(fontSize: 18.0)),
                const Text('Origen: ', style: TextStyle(fontSize: 18.0)),
                const Text('Destino: ', style: TextStyle(fontSize: 18.0)),
                const SizedBox(height: 30),
                
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const FirmaInspectorWidget())));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                    // minimumSize: MaterialStateProperty.all<Size>(const Size(, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        // size: 20,
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
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                        // minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            // size: 20,
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
                    )
                  ]
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _dialogBuilder(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                    minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    )
                  ),
                  child: const Text(
                    'Salida',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    )
                  )
                )
              ]
            )
          )
        )
      ),
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
                'Embarque con Exito!',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(
                  color: Colors.black,
                  thickness: 1.0,
                  height: 20
                ),
            ],
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
                    height: 230,
                  ),
                ),
                const Text(
                  'Viaje en Curso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ]
            )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                              // Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}