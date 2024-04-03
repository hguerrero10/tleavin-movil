import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/vin/inspeccion_vin.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class ResumenDano extends StatefulWidget {
  final vin;
  const ResumenDano({super.key, this.vin});

  @override
  State<ResumenDano> createState() => _ResumenDanoState();
}

class _ResumenDanoState extends State<ResumenDano> {

  Vin? vin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Resumen VIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Cuerpo(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Divider(
              color: Colors.black,
              thickness: 1.0,
              height: 20.0,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const Text(
                      'VIN: ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      widget.vin,
                      style: const TextStyle(
                        fontSize: 17
                      ),
                    )
                  ]
                )
              ]
            )
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(
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
                          const TableCell(
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
                          const TableCell(
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
                                padding:  EdgeInsets.all(8.0),
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
                const SizedBox(height: 20),
                Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InspeccionVin(vin: widget.vin))
                          )
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
                          'Registrar Otro Daño',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => {
                          realizarCompra(),
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false)
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
                          'Comprar',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                          minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                          ),
                        ),
                        child: const Text(
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
          )
        ]
      )
    );
  }

  realizarCompra() async {
    vin = Vin(
      id: 1,
      viaje: null,
      cartaporte: null,
      vin: widget.vin,
      distrib_clave: null, 
      dest_nombre: null, 
      ruta_clave: null, 
      ruta_nombre: null, 
      origen: null, 
      destino: null, 
      modelo: null, 
      marca: null, 
      posicion: null, 
      orientacion: null, 
      compra: 1, 
      fecha_carga: null, 
      fecha_creacion: '2024/04/02',
      fecha_sync: null
    );

    await DatabaseProvider.db.actualizarVin(vin!);
  }
}