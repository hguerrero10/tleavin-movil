import 'dart:developer';

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

  final _vinTextController = TextEditingController();

  var infoydatos = [];
  var todosVins = [];

  obtenerDatos(v) async {
    var datos = await DatabaseProvider.db.obtenerInfoVin(v);
    setState(() {
      infoydatos = datos;
      log(infoydatos.toString());
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleVin(inf: infoydatos)));
  }

  obtenerlistaCompletaVins() async {
    var datos = await DatabaseProvider.db.obtenerListaVins();
    setState(() {
      todosVins = datos;
    });
  }

  @override
  void initState() {
    obtenerlistaCompletaVins();
    
    super.initState();
  }

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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _vinTextController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              hintText: 'VIN',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              )
                            )
                          )
                        )
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
                            minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              )
                            )
                          ),
                          child: const Icon(
                            Icons.scanner,
                            color: Colors.white
                          )
                        )
                      )
                    ]
                  )
                ),
                Expanded(
                  child: vinsDisponibles(todosVins),
                )
              ]
            )
          )
        ]
      )
    );
  }
          
  Widget vinsDisponibles(da) {
    return da.isNotEmpty ? GridView.count(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      childAspectRatio: 1.0,
      crossAxisCount: 2,
      crossAxisSpacing: 40,
        children: List.generate(da.length, (index) {
          return GestureDetector(
            onTap: () async => await obtenerDatos('${da[index].vin}'),
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Icon(
                    CupertinoIcons.car_detailed, 
                    color: da[index].compra == 1 ? Colors.green : Colors.black,
                    size: 90
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          '${da[index].vin}',
                          textAlign: TextAlign.center,
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
          Icon(
            CupertinoIcons.car_detailed , 
            color: Colors.grey[300], 
            size: 60
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 250,
            child: Text(
              'No hay VINs disponibles',
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
}