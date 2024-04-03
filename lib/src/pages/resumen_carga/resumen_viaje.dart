import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:tleavin_mobil/src/pages/viaje/salida_viaje.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Resumen de Viaje',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ResumenDano()), (Route<dynamic> route) => false)
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
            const Text('Unidad: TLEA-458', style: TextStyle(fontSize: 18.0)),
            const Text('Bitacora: 789654', style: TextStyle(fontSize: 18.0)),
            const Text('Carta Porte: CMTY-745632', style: TextStyle(fontSize: 18.0)),
            const Text('Cliente: Mazda', style: TextStyle(fontSize: 18.0)),
            const Text('Origen: ', style: TextStyle(fontSize: 18.0)),
            const Text('Destino: ', style: TextStyle(fontSize: 18.0)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => const FirmaInspectorWidget())));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(242, 211, 0, 1)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
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
                    'Firma Inspector',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(242, 211, 0, 1)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                    minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nombre de Operador de Nodriza',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                minimumSize: MaterialStateProperty.all<Size>( const Size(double.infinity, 50)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                ),
              ),
              child: const Text(
                'Podemos Realizar la Carga',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalidaViaje()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                ),
              ),
              child: const Text(
                'Confirmar Carga y Salida',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                )
              )
            )
          ]
        )
      )
    );
  }
}