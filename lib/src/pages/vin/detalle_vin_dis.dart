import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

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
      width: 75,
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
          'Detalle de VIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: infoDeVin(widget.inf)
    );
  }

  Widget infoDeVin(vi) {
    return ListView.builder(
      itemCount: vi.length,
      itemBuilder: (context, index) {
        
        log(vi[index]['danoos'].toString());
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _encabezados('VIN: ', vi[index]['vinp']['vin']),
                _encabezados('Marca: ', vi[index]['vinp']['marca'] != null ? '${vi[index]['vinp']['marca']}' : 'Sin Identificar'),
                _encabezados('Modelo: ', vi[index]['vinp']['modelo'] != null ? '${vi[index]['vinp']['modelo']}' : 'Sin Identificar'),
                _encabezados('Comprado: ', vi[index]['vinp']['compra'] == 0 ? 'No' : 'Si'),
                _encabezados('Viaje: ', vi[index]['vinp']['viaje'] != null ? ' ${vi[index]['vinp']['viaje']}' : 'Sin Asignar'),
                _encabezados('Posicion: ', vi[index]['vinp']['posicion'] != null ? ' ${vi[index]['vinp']['posicion']}' : 'Sin Asignar'),
                _encabezados('Orientacion: ', vi[index]['vinp']['orientacion'] != null ? ' ${vi[index]['vinp']['orientacion']}' : 'Sin Asignar'),
                _encabezados('Fecha de registro: ', vi[index]['vinp']['fecha_creacion']),
                const SizedBox(height: 10),
                _cardDanos(vi[index]['danoos']),
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
            tit ?? '',
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

  Widget _encabezadosCard(tit, sub) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          tit ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(
          width: 230,
          child: Text(
            sub ?? '',
            style: const TextStyle(
              fontSize: 18,
            )
          )
        )
      ]
    );
  }

  Widget _cardDanos(da) {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: da.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dato = da[index];
        var totalda = index + 1;
        return Card(
          elevation: 3,
          shadowColor: Colors.black,
          surfaceTintColor: const Color.fromRGBO(242, 211, 0, 1),
          child: SizedBox(
              height: 690,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.only(left:16, right: 16),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.dangerous,
                        size: 30
                      ),
                      title: Row(
                        children: [
                          const Text(
                            'Daño: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '$totalda',
                            style: const TextStyle(
                              fontSize: 18
                            )
                          )
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            'Panel: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6)
                            ),
                          ),
                          Text(
                            dato['panel'] ?? 'General',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6)
                            )
                          )
                        ],
                      )
                    ),

                    dato['area'] == null ? const SizedBox() : _encabezados('Area: ', '${dato['area']}'),
                    dato['tipo'] == null ? const SizedBox() : _encabezados('Tipo: ', '${dato['tipo']}'),
                    dato['severidad'] == null ? const SizedBox() : _encabezados('Severidad: ', '${dato['severidad']}'),
             
                    dato['severidad'] == null ? _encabezados('Estado: ', '${dato['registroTipo']}') : const SizedBox(),

                    dato['area'] == null ? const SizedBox() : _encabezados('Codificacion: ', '${dato['area']}${dato['tipo']}-${dato['severidad']}'),
                    _encabezadosCard('Notas: ', '${dato['nota']}'),
                    _encabezados('Evidencias: ', ''),
     
                    _evidenciasDano(dato['evidencias'])
                  ],
                )
              )
            )
        );
      }
    );
  }

  Widget _evidenciasDano(evi) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: evi.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dato = evi[index];
        return SizedBox(
          height: 95,
          width: 75, 
          child: WidgetZoom(
            heroAnimationTag: 'tag${dato['ide']}',
            zoomWidget: imageFromBase64String('${dato['archivo']}')
          )
        );
      }
    );
  }
}