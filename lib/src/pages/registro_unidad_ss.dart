import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/pages/resumen_dano.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class Registro_Unidad_SS extends StatefulWidget {

  final vin;
  final tipo;
  const Registro_Unidad_SS({super.key, this.vin, this.tipo});

  @override
  State<Registro_Unidad_SS> createState() => _Registro_Unidad_SSState();
}

class _Registro_Unidad_SSState extends State<Registro_Unidad_SS> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipo),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Cuerpo(),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: const Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         'Unidad TLEA-458',
            //         style: TextStyle(
            //           fontSize: 16.0
            //         ),
            //       ),
            //       Text(
            //         'Bitacora: 789654',
            //         style: TextStyle(
            //           fontSize: 16.0
            //         ),
            //       ),

            //     ]
            //   )
            // ),
            // SizedBox(height: 20),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: const Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         'Verificado 1 de 8',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            SizedBox(height: 20),
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
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  // '3GTPUCEK2G274842',
                                  widget.vin,
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
                  SizedBox(height: 20),
                  Text(
                    widget.tipo,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'Adjunte 1 fotografía por cada lado de la unidad.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/img/camara.png',
                          width: 130,
                          height: 130,
                        ),
                        Text(
                          'Tomar Fotografia',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'NOTAS',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Resumen_Dano(vin: widget.vin)),
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
                    child: Text(
                      'Finalizar',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ]
        )
      )
    );
  }
}