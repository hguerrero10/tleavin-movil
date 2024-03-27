import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/pages/pantalla14.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/widget/firma_inspector.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

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
        title: const Text('Resumen del Viaje'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Cuerpo(),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                //border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Unidad: TLEA-458', style: TextStyle(fontSize: 18.0)),
                  Text('Bitacora: 789654', style: TextStyle(fontSize: 18.0)),
                  Text('Carta Porte: CMTY-745632', style: TextStyle(fontSize: 18.0)),
                  Text('Cliente: Mazda', style: TextStyle(fontSize: 18.0)),
                  Text('Origen: ', style: TextStyle(fontSize: 18.0)),
                  Text('Destino: ', style: TextStyle(fontSize: 18.0)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
  
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const FirmaInspectorWidget())));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(242, 211, 0, 1)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                      minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
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
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
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
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Pantalla12()),
                      // );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                      minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
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
                        MaterialPageRoute(builder: (context) => Pantalla14()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                      minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ]
              )
            ),
          ],
        ),
      )
     );
  }
}