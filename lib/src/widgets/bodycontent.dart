import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
    
    DateTime ahora = DateTime.now();
    var formatoFecha = DateFormat('dd/MM/yyyy HH:mm');
    String fecha = '';

    @override
    void initState() {
      initializeDateFormatting();
      String fechaFormateada = formatoFecha.format(ahora);
      fecha = fechaFormateada;
      print(fechaFormateada); 
      
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sistema TLEAVIN',
                  style: TextStyle(
                    fontSize: 26.0, fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Fecha: ',
                  // fecha,
                  style: TextStyle(
                    fontSize: 19.0,
                  ),
                ),
                Text(
                  'Usuario: Inspector Calidad',
                  style: TextStyle(
                    fontSize: 19.0,
                  ),
                ),
                Text(
                  'Ubicacion: Puerto Lazaro Cardenas',
                  style: TextStyle(
                    fontSize: 19.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }