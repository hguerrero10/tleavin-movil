import 'package:flutter/material.dart';
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
        title: const Text('Resumen de Viaje'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Cuerpo(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Resumen del Viaje',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                   Center(
                    child: Table(
                      border: TableBorder.all(),
                      children: const [
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                child: Text(
                                  'VIN',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ), 
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(
                                  'Estado',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ), 
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(
                                  'Accion',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ), 
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(
                                  'Daños',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ), 
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(
                                  'No pos',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ), 
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(
                                  'Orientacion F/R',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ), 
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(''),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text('VIN'),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text('VIN'),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text('VIN'),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text('VIN'),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text('VIN'),
                                  ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 3'),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ResumenViaje()),
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
                      'Completar Compra - Firmas',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Pantalla13()),
                      // );
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
                      'Registrar Posiciones',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  )
                ]
              )
            ),
          ],
        ),
      )
     );
  }
}