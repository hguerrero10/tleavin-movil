

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/src/pages/vins/detalle_vin_dis.dart';

class VinsDisponibles extends StatefulWidget {
  const VinsDisponibles({super.key});

  @override
  State<VinsDisponibles> createState() => _VinsDisponiblesState();
}

class _VinsDisponiblesState extends State<VinsDisponibles> {

  Vin? vin;

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
      body: comprados()
    );
  }

  Widget comprados() {
    return StreamBuilder<List>(
      stream: DatabaseProvider.db.obtenerListaVins().asStream(),
      builder: (context, AsyncSnapshot<List>snapshot) {
        if(snapshot.hasData) {
          return snapshot.data!.isNotEmpty ? GridView.count(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            childAspectRatio: 1.0,
            crossAxisCount: 2,
            crossAxisSpacing: 40,
            mainAxisSpacing: 90,
              children: List.generate(snapshot.data!.length, (index) {
                return Tooltip(
                  message: '${snapshot.data![index].vin}',
                  decoration: const BoxDecoration(
                    color: Colors.black
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleVin(vin: '${snapshot.data![index].vin}')));
                    },
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          child: Icon(CupertinoIcons.car_detailed, color: Colors.black, size: 90),
                        ),
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

  Widget noComprados() {
    return StreamBuilder<List>(
      stream: DatabaseProvider.db.obtenerTipoVin().asStream(),
      builder: (context, AsyncSnapshot<List>snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isNotEmpty ? GridView.count(
            childAspectRatio: 1.0,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 60,
              children: List.generate(snapshot.data!.length, (index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Column(
                      children: <Widget>[
                        SizedBox(
                          width: 90,
                          height: 70,
                          child: Icon(CupertinoIcons.doc_fill, color: Colors.white, size: 70),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Flexible(
                              //   child: Text(
                              //     '${snapshot.data![index]['fecha']} ${snapshot.data![index]['hora']}',
                              //     textAlign: TextAlign.center ,
                              //     style: TextStyle(
                              //       color: Colors.grey[200],
                              //       fontSize: 11
                              //     ),
                              //   ),
                              // ),
                            ]
                          )
                        )
                      ]
                    )
                  )
                );
              }
            )
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.doc_fill , color: Colors.grey[300], size: 60,),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: Text(
                    'No hay vins disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 19
                    ),
                  ),
                )
              ]
            )
          );
        } 
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}