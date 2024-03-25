import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/pages/registro_unidad_ss.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'registro_dano.dart';

class InspeccionVin extends StatefulWidget {

  final vin;
  const InspeccionVin({super.key, this.vin});

  @override
  State<InspeccionVin> createState() => _InspeccionVinState();
}

class _InspeccionVinState extends State<InspeccionVin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspeccion VIN'),
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
            // SizedBox(height: 10),
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
            SizedBox(height: 10),
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
                                  widget.vin,
                                  style: TextStyle(
                                    fontSize: 15,
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
                                    fontSize: 15,
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Registro de Daños',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Center(
              child: Container(
                width: 300,
                height: 360,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/inspeccion_vehiculo.jpg'),
                    fit: BoxFit.fill
                  )
                ),
                child: Stack(
                  children: [
                    _boton(20, 125, '1', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registro_Dano(vin: widget.vin, panel: '1')),
                      )
                    }),
                    _boton(160, 30, '2', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registro_Dano(vin: widget.vin, panel: '2')),
                      )
                    }),
                    _boton(160, 125, '3', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registro_Dano(vin: widget.vin, panel: '3')),
                      )
                    }),
                    _boton(160, 220, '4', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registro_Dano(vin: widget.vin, panel: '4')),
                      )
                    }),
                    _boton(300, 125, '5', () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registro_Dano(vin: widget.vin, panel: '5')),
                      )
                    })
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registro_Unidad_SS(vin: widget.vin, tipo: 'Unidad Sucia')),
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
                    'Unidad Sucia',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registro_Unidad_SS(vin: widget.vin, tipo: 'Unidad Sin Daños')),
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
                    'Sin Daños',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ]
        )
      )
    );
  }

  Widget _boton(double top, double left, String text, onTap) {
    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        height: 50,
        width: 50,
        child: ElevatedButton(
          style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          onPressed: onTap,
        ),
      )
    );
  }
}