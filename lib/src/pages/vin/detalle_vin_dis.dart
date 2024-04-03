import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetalleVin extends StatefulWidget {
  final inf;
  const DetalleVin({super.key,  this.inf});

  @override
  State<DetalleVin> createState() => _DetalleVinState();
}

class _DetalleVinState extends State<DetalleVin> {

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
      body: _buildItem(widget.inf)
    );
  }

  Widget _buildItem(v) {
    return ListView.builder(
      itemCount: v.length,
      itemBuilder: (context, index) {

        // log(v.toString());
        // log('${v?[index][0]}');
        log('${v[index][0]['da'][0]}');
        log('${v[index][0]['vi'][0]['vin']}');
        return ListTile(
          // title: Text('VIN: ${v?[index][0]['vi']}'),
          // subtitle: Text('Nota: ${v[index][0]['nota']}'),
        );
      },
    );
    // Column(
    //   children: [
        // Text('VIN: ${v?.vin}'),
        // Text('panel: ${d?.panel}'), 
        // Text('fechahora: ${e?.fechahora}'),
        
    // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     SizedBox(height: 100, width: 100, child: imageFromBase64String('${e?.archivo}')),
        //   ],
        // ),
      
  }
}