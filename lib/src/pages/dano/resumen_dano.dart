import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class ResumenDano extends StatefulWidget {
  final resu;
  const ResumenDano({super.key, this.resu});

  @override
  State<ResumenDano> createState() => _ResumenDanoState();
}

class _ResumenDanoState extends State<ResumenDano> {

  Vin? vin;
  var datosVin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirmExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Quieres salir de la Compra?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); 
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Sí'),
              )
            ]
          )
        );
        
        return confirmExit;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
          title: const Text(
            'Resumen VIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
          )
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                children: [
                  const Cuerpo(),
                  Expanded(
                    child: infoVin(widget.resu)
                  ),
                
                  // const SizedBox(height: 40)
                ]
              )
            )
          ]
        )
      ),
    );
  }

  Widget infoVin(vi) {
    return ListView.builder(
      itemCount: vi.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        log(vi[index]['danoos'].toString());
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
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
                      '${vi[index]['vinp']['vin']}',
                      style: const TextStyle(
                        fontSize: 17
                      ),
                    )
                  ]
                ),
                const SizedBox(height: 20),
                Table(
                  border: TableBorder.all(),
                  children: const [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              'Daño',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              )
                            )
                          )
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'Codigo',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              )
                            )
                          )
                        )
                      ]
                    )
                  ]
                ),
                tabla(vi[index]['danoos']),

                const SizedBox(height: 150),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      await realizarCompra(vi[index]['vinp']);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                      minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      )
                    ),
                    child: const Text(
                      'Comprar',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      )
                    )
                  )
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: () =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                      minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      )
                    ),
                    child: const Text(
                      'Rechazar',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      )
                    )
                  )
                )
              ]
            )
          )
        );
      }
    );
  }

  Widget tabla(da) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: da.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dato = da[index];
        var totalda = index + 1;

        return Center(
          child: Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text('Daño:  $totalda')
                      )
                    )
                  ),
                  TableCell(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: dato['area'] != null ? Text('${dato['area']} - ${dato['tipo']} - ${dato['severidad']}') : Text('${dato['registroTipo']}')
                        // Image.asset(
                        //   'assets/img/imagen.png',
                        //   width: 50,
                        //   height: 50,
                        // )
                      )
                    )
                  )
                ]
              )
            ]
          )
        );
      }
    );
  }

  realizarCompra(da) async {
    vin = Vin(
      idv: da['idv'],
      idviaje: da['idviaje'],
      cartaporte: da['cartaporte'],
      vin: da['vin'],
      distrib_clave: da['distrib_clave'], 
      dest_nombre: da['dest_nombre'], 
      ruta_clave: da['ruta_clave'], 
      ruta_nombre: da['ruta_nombre'], 
      origen: da['origen'], 
      destino: da['destino'], 
      modelo: da['modelo'], 
      marca: da['marca'], 
      posicion: da['posicion'], 
      orientacion: da['orientacion'], 
      compra: 1, 
      fecha_carga: da['fecha_carga'], 
      fecha_creacion: da['fecha_creacion'],
      fecha_sync: da['fecha_sync']
    );

    log(vin.toString());

    await DatabaseProvider.db.actualizarVin(vin!);

    Fluttertoast.showToast(
      msg: "VIN comprado con Exito!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 20
    );
  }
}