import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tleavin_mobil/src/widgets/info.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';

class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  var format;
  var dateString;
  var ubi = '';

  @override
  void initState() {
    initializeDateFormatting();
    format = DateFormat.yMMMMd('es');
    dateString = format.format(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onDoubleTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoApp())),
                    child: Text(
                      'Version: 1.0.0',
                      style:  TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400]
                      )
                    )
                  ),
                  SizedBox(
                    width:10,
                    height:10,
                    child: ConnectivityWidget(
                      builder: (context, isOnline) => Center(
                        child: 
                        isOnline ? Image.asset(
                          'assets/img/verde.png',
                          width:10,
                          height:10
                        ) :
                        Image.asset(
                          'assets/img/verde.png',
                          width:10,
                          height:10
                        )
                      )
                    )
                  )
                ]
              ),
              Row(
                children: [
                  const Text(
                    'Fecha: ',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    dateString,
                    style: const TextStyle(
                      fontSize: 19
                    )
                  )
                ]
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Ubicacion: ',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    itemP.usuario!.locacion!,
                    style: const TextStyle(
                      fontSize: 19
                    )
                  )
                ]
              ),
              const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20
              )
            ]
          )
        )
      ]
    );
  }
}