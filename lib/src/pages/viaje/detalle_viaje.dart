import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/viaje.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/resumen_carga/salida_viaje.dart';

class DetalleDeViaje extends StatefulWidget {
  final viaje;
  const DetalleDeViaje({super.key, this.viaje});

  @override
  State<DetalleDeViaje> createState() => _DetalleDeViajeState();
}


class _DetalleDeViajeState extends State<DetalleDeViaje> {

  var vinsasiganadosylisos = [];
  var versiyaesta;

  Viaje? resumenviaje;

  @override
  void initState() {
    // log(widget.viaje.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Detalle del Viaje',
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

                Expanded(child: informacionDelViaje(widget.viaje))
              ]
            )
          )
        ]
      )
    );
  }

  Widget informacionDelViaje(invi) {
    return ListView.builder(
      itemCount: invi.length,
      itemBuilder: (context, index) {
        final dato = invi[index]['viaje'];




        resumenviaje = Viaje(
          idviaje: dato['idviaje'],
          supervisor: dato['supervisor'],
          folio_bitacora: dato['folio_bitacora'],
          cartaporte: dato['cartaporte'],
          bitacora_fecha_carga: dato['bitacora_fecha_carga'],
          num_eco_unidad: dato['num_eco_unidad'],
          nombre_operador: dato['nombre_operador'],
          cliente_clave: dato['cliente_clave'],
          cliente_nombre: dato['cliente_nombre'],
          ruta_clave: dato['ruta_clave'],
          ruta_nombre: dato['ruta_nombre'],
          origen: dato['origen'],
          destino: dato['destino'],
          etiqueta: dato['etiqueta'],
          status_carga: dato['status_carga'],
          notas: dato['notas'],
          registrada_por: dato['registrada_por'],
          tipo_viaje: dato['tipo_viaje'],
          semana: dato['semana'],
          fecha_creacion: dato['fecha_creacion'],
          fecha_sync: dato['fecha_sync']
        );



        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [

                _encabezados('Numero Eco.: ', '${dato['num_eco_unidad']}'),
                _encabezados('Operador: ', '${dato['nombre_operador']}'),
                _encabezados('Cliente.: ', '${dato['cliente_nombre']}'),
                _encabezados('Origen: ', '${dato['origen']}'),
                _encabezados('Destino: ', '${dato['destino']}'),
                _encabezados('Tipo viaje: ', dato['tipo_viaje'] != null ? '${dato['tipo_viaje']}' : 'Sin Especificar'),
                _encabezados('Fecha de armado: ', '${dato['fecha_creacion']}'),
                _encabezados('Notas: ', dato['notas'] != null ? '${dato['notas']}' : 'Sin Notas'),
                _encabezados('VINs: ', ''),

                const SizedBox(height: 10),

                _vinsCard(dato['vins']),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async => await actualizarPoOrVins(dato['vins'], vinsasiganadosylisos),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                    minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    )
                  ),
                  child: const Text(
                    'Firmas',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    )
                  )
                )
              ]
            ),
          ),
        );
      }
    );
  }

  Widget _encabezados(tit, sub) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            tit ?? 0,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
          Text(
            sub ?? '',
            style: const TextStyle(
              fontSize: 18
            )
          )
        ]
      )
    );
  }

  Widget _vinsCard(evi) {
    var inf ;
    for(var di in evi){
      inf = di;
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: inf.length,
      itemBuilder: (context, index) {

        var posi = inf[index]['posicion'] ?? '';
        var orie = inf[index]['orientacion'] ?? '';
        return GestureDetector(
          onTap: () => _dialogBuilder(context, inf[index]['vin']),
          child: SizedBox(
            height: 120,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'VIN: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          inf[index]['vin'],
                          style: const TextStyle(
                            fontSize: 18
                          )
                        )
                      ]
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Posicion: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          posi,
                          style: const TextStyle(
                            fontSize: 18
                          )
                        )
                      ]
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Orientacion: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          orie,
                          style: const TextStyle(
                            fontSize: 18
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            )
          )
        );
      }
    );
  }

  Future<void> _dialogBuilder(BuildContext context, vi) {
    final _posicionTextController = TextEditingController();
    var orientacionSeleccionada;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                'Asignar Orientacion y Posicion',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                )
              ),
              Divider(
                color: Colors.black,
                thickness: 1.0
              )
            ]
          ),
          content: SizedBox(
            height: 210,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'VIN: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      vi,
                      style: const TextStyle(
                        fontSize: 16
                      )
                    )
                  ]
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Posicion: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ],
                ),
                TextField(
                  controller: _posicionTextController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Escriba Posicion de VIN',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    )
                  )
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Orientacion: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ]
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    items: const ['Frente','Reversa'],
                    dropdownDecoratorProps: const  DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Selecciona la Orientacion de VIN",
                        hintStyle: TextStyle(
                          color: Colors.grey
                        )
                      )
                    ),
                    onChanged: (oc) {
                      setState(() {
                        orientacionSeleccionada = oc;
                      });
                    },
                  )
                )
              ]
            )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge
              ),
              child: const Text('Cerrar'),
              onPressed: () => Navigator.of(context).pop()
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge
              ),
              child: const Text('Guardar'),
              onPressed: () {
                var vinsPoOr = (
                  vin: vi,
                  posicion: _posicionTextController.text,
                  orientacion: orientacionSeleccionada
                );

                vinsasiganadosylisos.add(vinsPoOr);
                log(vinsasiganadosylisos.toString());

                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  actualizarPoOrVins(ori, lista) async {
    var inf ;
    for(var di in ori){
      inf = di;
    }

    if(inf.length == lista.length) {
      for(var o in lista) {
        var vinsPoOr = (
          vin: o.vin,
          posicion: o.posicion,
          orientacion: o.orientacion
        );

        await DatabaseProvider.db.asignarPoOrVIN(vinsPoOr).then((value) {
        log('vin asignado PoOr');
        }).timeout(const Duration(seconds: 30), onTimeout: () {
          itemP.addError();
        });

        log('resumendeviaje');
        log(resumenviaje.toString());

        
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => ResumenViaje(viaje: resumenviaje)), (Route<dynamic> route) => false);
      }
    }
    else {
      Fluttertoast.showToast(
        msg: "VINs Pendientes de Posicion y Orientacion",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }
}