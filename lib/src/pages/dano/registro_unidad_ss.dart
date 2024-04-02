import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/pages/dano/resumen_dano.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class RegistroUnidadSS extends StatefulWidget {

  final vin;
  final tipo;
  const RegistroUnidadSS({super.key, this.vin, this.tipo});

  @override
  State<RegistroUnidadSS> createState() => _RegistroUnidadSSState();
}

class _RegistroUnidadSSState extends State<RegistroUnidadSS> {

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
            const Cuerpo(),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
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
            // const SizedBox(height: 20),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Divider(
                color: Colors.black,
                thickness: 1,
                height: 20,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  // '3GTPUCEK2G274842',
                                  widget.vin,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                      const TableRow(
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
                  const SizedBox(height: 20),
                  Text(
                    widget.tipo,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Text(
                    'Adjunte 1 fotografía por cada lado de la unidad.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/img/camara.png',
                          width: 130,
                          height: 130,
                        ),
                        const Text(
                          'Tomar Fotografia',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'NOTAS',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResumenDano(vin: widget.vin)),
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
            const SizedBox(height: 20),
          ]
        )
      )
    );
  }
}