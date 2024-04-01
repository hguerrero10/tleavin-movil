import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';

class DetalleVin extends StatefulWidget {
  final vin;
  
  const DetalleVin({super.key, this.vin});

  @override
  State<DetalleVin> createState() => _DetalleVinState();
}

class _DetalleVinState extends State<DetalleVin> {
  var info = [];

  Image imageFromBase64String(base64) {
    return Image.memory(
      base64Decode(base64),
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Detalle de Vin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: detalleVin(widget.vin)
    );
  }

  Widget detalleVin(v) {
    return StreamBuilder<List>(
      stream: DatabaseProvider.db.obtenerInfoVin(v).asStream().distinct(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasError) {
          return Text('Ocurrió un error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.map((item) => _buildItem(item)).toList(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(242, 211, 0, 1)
            )
          );
        }
      },
    );
  }

  Widget _buildItem(Map<String, dynamic> item) {
    return Column(
      children: [
        Text('VIN: ${item['vin']}'),
        Text('fecha: ${item['fecha_creacion']}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 100, width: 100, child: imageFromBase64String('${item['archivo']}')),
          ],
        ),
      ],
    );
  }



  // Widget detalleVin(v) {
  //   return StreamBuilder<List>(
  //     stream: DatabaseProvider.db.obtenerInfoVin(v).asStream(),
  //     builder: (context, AsyncSnapshot<List>snapshot) {
  //       if(snapshot.hasData) {
  //         return SingleChildScrollView(
  //           child: Column(
  //               children: List.generate(snapshot.data!.length, (index) {
  //                 log('${snapshot.data![index]}');
  //                 return SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                        Text('VIN: ${snapshot.data![index]['vin']}'),
  //                        Text('fecha: ${snapshot.data![index]['fecha_creacion']}'),
            
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           children: [
  //                             SizedBox(height: 100, width: 100, child: imageFromBase64String('${snapshot.data![index]['archivo']}')),
  //                           ]
  //                         ),
  //                     ],
  //                   ),
  //                 );
  //               }
  //             )
  //           ),
  //         );        
  //       } 
  //       else {
  //         return const Center(
  //           child: CircularProgressIndicator(
  //             color: Color.fromRGBO(242, 211, 0, 1)
  //           )
  //         );
  //       }
  //     }
  //   );
  // }
}