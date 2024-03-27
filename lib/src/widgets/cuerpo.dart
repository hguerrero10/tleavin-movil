import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
    
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy'); 
    var format;
    var dateString;
    var ubi = '';

    @override
    void initState() {
      initializeDateFormatting();
      format = DateFormat.yMMMMd('es');
      dateString = format.format(DateTime.now());
      obtenerUbicacion();
      
      super.initState();
    }

    @override
    void dispose() {
      ubi = '';

      super.dispose();
    }


    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Fecha: ',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          dateString,
                          style: const TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    ConnectivityWidget(
                      builder: (context, isOnline) => Center(
                        child: Text(
                          isOnline ? "ON" : "OFF", 
                          style: TextStyle(
                            fontSize: 10, 
                            fontWeight: FontWeight.bold, 
                            color: isOnline ? Colors.green : Colors.red
                          )
                        )
                        // isOnline ? Image.asset(
                        //       'assets/img/verde.png',
                        //       width: 30,
                        //       height: 30,
                        //     ) :
                        //     Image.asset(
                        //       'assets/img/verde.png',
                        //       width: 30,
                        //       height: 30,
                        // )
                      )
                    )
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
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
                    const Text(
                      'Ubicacion: ',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      // 'Puerto Lazaro Cardenas',
                      ubi,
                      style: const TextStyle(
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

    obtenerUbicacion() async {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        print(place);
        ubi = '${place.administrativeArea}, ${place.country}';
      });
    }
  }