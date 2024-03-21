import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/bodycontent.dart';
import 'pantalla4.dart';

class Pantalla3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 3'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Cuerpo(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Container(
                    width: 350.0,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _buildTablaRegistros1()
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pantalla4()),
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
                      'Realizar Carga',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Container(
                    width: 350.0,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _buildTablaRegistros2()
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pantalla4()),
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
                      'Realizar Carga',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTablaRegistros1() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Unidad',
            style: TextStyle(
              fontSize: 18.0
            ),
          )
        ),
        DataColumn(
          label: Text(
            'Cliente',
            style: TextStyle(
              fontSize: 18.0
            ),
          )
        ),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('TLEA-124')),
          DataCell(Text('Mazda')),
        ]),
        DataRow(cells: [
          DataCell(Text('Carla Porte')),
          DataCell(Text('Vehiculos')),
        ]),
        DataRow(cells: [
          DataCell(Text('CMTY-478954')),
          DataCell(Text('11'))
        ]),
      ],
    );
  }

  Widget _buildTablaRegistros2() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Unidad')),
        DataColumn(label: Text('Cliente')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('TLEA-124')),
          DataCell(Text('Mazda'))
        ]),
        DataRow(cells: [
          DataCell(Text('Carla Porte')),
          DataCell(Text('Vehiculos'))
        ]),
        DataRow(cells: [
          DataCell(Text('CMTY-478954')),
          DataCell(Text('11'))
        ]),
      ],
    );
  }
}
