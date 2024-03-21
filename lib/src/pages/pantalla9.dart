import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/bodycontent.dart';
import 'pantalla10.dart';

class Pantalla9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 9'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Cuerpo(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Unidad TLEA-458',
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  ),
                  Text(
                    'Bitacora: 789654',
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  ),

                ]
              )
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Verificado 1 de 8',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Table(
                    border: TableBorder.all(),
                    children: const [
                      TableRow(
                        children: [
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '3GTPUCEK2G274842',
                                  style: TextStyle(
                                    fontSize: 18.0,
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
                                child: Text(
                                  '2022 Chevrolet Silverdo 4WD',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                child: Text(
                                  'Daño',
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
                                  'Imagen',
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
                                  child: Text('Daño 1'),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      'assets/img/imagen.png',
                                      width: 50,
                                      height: 50,
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
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 2'),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      'assets/img/imagen.png',
                                      width: 50,
                                      height: 50,
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
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Daño 3'),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      'assets/img/imagen.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
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
                          child: Text(
                            'Registrar Otro Daño',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
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
                          child: Text(
                            'Registrar Faltante',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
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
                          child: Text(
                            'Finalizar',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pantalla10()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                            ),
                          ),
                          child: Text(
                            'Rechazar',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                ]
              )
            ),
            SizedBox(height: 30)
          ]
        )
      )
    );
  }
}