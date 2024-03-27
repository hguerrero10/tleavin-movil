import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'pantalla4.dart';

class Pantalla3 extends StatefulWidget {
  const Pantalla3({super.key});

  @override
  State<Pantalla3> createState() => _Pantalla3State();
}

class _Pantalla3State extends State<Pantalla3> {
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
            const  Cuerpo(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Container(
                    width: 350.0,
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _buildTablaRegistros1()
                  ),
                  const SizedBox(height: 10.0),
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
                    child: const Text(
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
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Container(
                    width: 350.0,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _buildTablaRegistros2()
                  ),
                  const SizedBox(height: 10.0),
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
                    child: const Text(
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
      columns: const [
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
      rows: const [
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
      columns: const [
        DataColumn(label: Text('Unidad')),
        DataColumn(label: Text('Cliente')),
      ],
      rows: const [
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
