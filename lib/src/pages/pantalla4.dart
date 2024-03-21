import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/bodycontent.dart';
import 'pantalla5.dart';

class Pantalla4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 4'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Cuerpo(),
            Container(
              padding: EdgeInsets.all(16.0),
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
                  Text('Hora de Inicio: ', style: TextStyle(fontSize: 18.0)),
                ],
              ),
            ),
            SizedBox(height: 17),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '3GTPUCEK2G274842',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                                        
                                      ),
                                      child: Text('VERIFICAR', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
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
                  SizedBox(height: 15),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '3GTPUCEK2G274842',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                      ElevatedButton(
                                      onPressed: () {
                                        
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                                        
                                      ),
                                      child: Text('VERIFICAR', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
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
                  SizedBox(height: 15),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '3GTPUCEK2G274842',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                      ElevatedButton(
                                      onPressed: () {
                                        
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                                        
                                      ),
                                      child: Text('VERIFICAR', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
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
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pantalla5()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16.0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                ),
                child: Text(
                  'Verificar Todos - Comenzar',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white
                  ),
                ),
              ),
            ),
              SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}