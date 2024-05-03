import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/src/pages/vin/detalle_vin_dis.dart';
import 'package:tleavin_mobil/src/widgets/search.dart';

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
   String query = '';
  var vins = [];

  obtenerDatos(v) async {
    var datos = await DatabaseProvider.db.obtenerInfoVin(v);
    setState(() {
      infoydatos = datos;
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
    super.initState();
    
    obtenerlistaCompletaVins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'VINES Disponibles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: todosVins.isNotEmpty ? ListView.builder(
                shrinkWrap: true,
                itemCount: todosVins.length,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return  GestureDetector(
                    onTap: () async => await obtenerDatos('${todosVins[index].vin}'),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: todosVins[index].compra == 1 ? const Color.fromRGBO(25, 241, 38, 240) : const Color.fromRGBO(227, 227, 227, 1),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          boxShadow: null,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'VIN',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey
                                      )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '${todosVins[index].vin}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600
                                        )
                                      )
                                    )
                                  ]
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Fecha Compra',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey
                                      )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '${todosVins[index].fecha_creacion}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600
                                        )
                                      )
                                    )
                                  ]
                                )
                              ]
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 20,
                              thickness: 1
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 61,
                                  width: 61,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromRGBO(242, 211, 0, 1),
                                    image: DecorationImage(
                                      image: AssetImage('assets/img/modelovin.png'),
                                      fit: BoxFit.fill
                                    )
                                  )
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${todosVins[index].modelo}' != 'null' ? '${todosVins[index].modelo}' : 'Sin Identicar',
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700
                                              )
                                            )
                                          )
                                        ]
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text.rich(
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                              TextSpan(
                                                text: 'Marca: ',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey
                                                ),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: '${todosVins[index].marca}' != 'null' ? '${todosVins[index].marca}' : 'Sin Identicar',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.black
                                                    )
                                                  )
                                                ]
                                              )
                                            )
                                          ),
                                          const SizedBox(width: 16),
                                        ]
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text.rich(
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                              TextSpan(
                                                text: 'Comprado: ',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey
                                                ),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: todosVins[index].compra == 1 ? 'Si' : 'No',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.black
                                                    )
                                                  )
                                                ]
                                              )
                                            )
                                          )
                                        ]
                                      )
                                    ]
                                  )
                                )
                              ]
                            )
                          ]
                        )
                      )
                    )
                  );
                }
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
                        'No hay VINES disponibles',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 19
                        )
                      )
                    )
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }

 Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Escriba el VIN',
    onChanged: searchVIN
  );

  searchVIN(String query) {

    log(query.toString());
    final vinsf = todosVins.where((v) {
      final titleLower = v.vin.toLowerCase();

      if(query != '') {
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }
      else {
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }
    }).toList();

    setState(() {
      this.query = query;
      vins = vinsf;
    });
  }
          
  Widget vinsDisponibles(da) {
    return da.length != 0 ? ListView.builder(
      shrinkWrap: true,
      itemCount: da.length,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  GestureDetector(
          onTap: () async => await obtenerDatos('${da[index].vin}'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: da[index].compra == 1 ? const Color.fromRGBO(25, 241, 38, 240) : const Color.fromRGBO(227, 227, 227, 1),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: null,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'VIN',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '${da[index].vin}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600
                              )
                            )
                          )
                        ]
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fecha Compra',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '${da[index].fecha_creacion}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600
                              )
                            )
                          )
                        ]
                      )
                    ]
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 1
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 61,
                        width: 61,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromRGBO(242, 211, 0, 1),
                          image: DecorationImage(
                            image: AssetImage('assets/img/modelovin.png'),
                            fit: BoxFit.fill
                          )
                        )
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${da[index].modelo}' != 'null' ? '${da[index].modelo}' : 'Sin Identicar',
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                    )
                                  )
                                ),
                                // Container(
                                //   margin: const EdgeInsets.only(left: 16),
                                //   decoration: BoxDecoration(
                                //   color: Colors.black,
                                //     borderRadius: const BorderRadius.all(
                                //       Radius.circular(5))
                                //     ),
                                //   padding: const EdgeInsets.all(3),
                                //   child: Text(
                                //     '2019',
                                //     style: TextStyle(
                                //         color: Colors.blueAccent,
                                //         fontSize: 10,
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // ),
                              ]
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text.rich(
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    TextSpan(
                                      text: 'Marca: ',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '${da[index].marca}' != 'null' ? '${da[index].marca}' : 'Sin Identicar',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                          )
                                        )
                                      ]
                                    )
                                  )
                                ),
                                const SizedBox(width: 16),
                              ]
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text.rich(
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    TextSpan(
                                      text: 'Comprado: ',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: da[index].compra == 1 ? 'Si' : 'No',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                          )
                                        )
                                      ]
                                    )
                                  )
                                )
                              ]
                            )
                          ]
                        )
                      )
                    ]
                  )
                ]
              )
            )
          )
        );
      }
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
              'No hay VINES disponibles',
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