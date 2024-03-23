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
    
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy'); 
    var format;
    var dateString;

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
            padding: EdgeInsets.only(left: 16, right: 16),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sistema TLEAVIN',
                  style: TextStyle(
                    fontSize: 26.0, fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Fecha: ',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        dateString,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Text(
                      'Usuario: ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Inspector Calidad',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Ubicacion: ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Puerto Lazaro Cardenas',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }