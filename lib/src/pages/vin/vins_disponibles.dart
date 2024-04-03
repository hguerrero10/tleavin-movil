import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/src/pages/vin/detalle_vin_dis.dart';

class VinsDisponibles extends StatefulWidget {
  const VinsDisponibles({super.key});

  @override
  State<VinsDisponibles> createState() => _VinsDisponiblesState();
}

class _VinsDisponiblesState extends State<VinsDisponibles> {

  Vin? vin;
  Dano? dano;
  Evidencia? evidencia;

  var infoydatos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Vins Disponibles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: listaDeVins()
    );
  }

  obtenerDatos(v) async {
    var datos = await DatabaseProvider.db.obtenerInfoVin(v);
    setState(() {
      infoydatos = datos;
    });

    // vin = Vin(
      // id: ele['vi'].id.toString(),
      // viaje: ele['viaje'],
      // cartaporte: ele['cartaporte'],
      // vin: ele['vin'],
      // distrib_clave: ele['distrib_clave'],
      // dest_nombre: ele['dest_nombre'],
      // ruta_clave: ele['ruta_clave'],
      // ruta_nombre: ele['ruta_nombre'],
      // origen: ele['origen'],
      // destino: ele['destino'],
      // modelo: ele['modelo'],
      // marca: ele['marca'],
      // posicion: ele['posicion'],
      // orientacion: ele['orientacion'],
      // compra: ele['compra'],
      // fecha_carga: ele['fecha_carga'],
      // fecha_creacion: ele['fecha_creacion'],
      // fecha_sync: ele['fecha_sync']
    // );
      
    // dano = Dano(
    //   id: datos[1]['id'],
    //   vin: datos[1]['vin'],
    //   panel: datos[1]['panel'], 
    //   registroTipo: datos[1]['registroTipo'], 
    //   area: datos[1]['area'], 
    //   tipo: datos[1]['tipo'], 
    //   severidad: datos[1]['severidad'],
    //   nota: datos[1]['nota'],
    //   fecha_creacion: datos[1]['fecha_creacion']
    // );

    // evidencia = Evidencia(
    //   id: datos[2]['id'],
    //   vin: datos[2]['vin'],
    //   dano: datos[2]['dano'],
    //   nombre: datos[2]['nombre'],
    //   archivo: datos[2]['archivo'],
    //   fechahora: datos[2]['fechahora']
    // );
  }

  Widget listaDeVins() {
    return StreamBuilder<List>(
      stream: DatabaseProvider.db.obtenerListaVins().asStream(),
      builder: (context, AsyncSnapshot<List>snapshot) {
        if(snapshot.hasData) {
          return snapshot.data!.isNotEmpty ? GridView.count(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            childAspectRatio: 1.0,
            crossAxisCount: 2,
            crossAxisSpacing: 40,
              children: List.generate(snapshot.data!.length, (index) {
                return GestureDetector(
                  onTap: () async => {
                    await obtenerDatos('${snapshot.data![index].vin}'),
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleVin(inf: infoydatos)))
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(child: Icon(CupertinoIcons.car_detailed, color: snapshot.data![index].compra == 1 ? Colors.green : Colors.black, size: 90)),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                '${snapshot.data![index].vin}',
                                textAlign: TextAlign.center ,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                )
                              )
                            )
                          ]
                        )
                      )
                    ]
                  )
                );
              }
            )
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.doc_fill , color: Colors.grey[300], size: 60),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: Text(
                    'No hay vins disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 19
                    )
                  )
                )
              ]
            )
          );
        } 
        else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(242, 211, 0, 1)
            )
          );
        }
      }
    );
  }
}