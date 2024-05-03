import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/pages/vin/inspeccion_vin.dart';
import 'package:widget_zoom/widget_zoom.dart';
import 'package:flutter/services.dart';

class DetalleVin extends StatefulWidget {
  final inf;
  const DetalleVin({super.key,  this.inf});

  @override
  State<DetalleVin> createState() => _DetalleVinState();
}

class _DetalleVinState extends State<DetalleVin> {

  String? vinSeleccionado;

  Image imageFromBase64String(base64) {
    return Image.memory(
      base64Decode(base64),
      fit: BoxFit.cover,
      width: 75,
    );
  }

  comprarVin(v) async{
    await DatabaseProvider.db.compraVINRegistrado(v).then((value) {
      Fluttertoast.showToast(
        msg: "VIN: $v Comprado con Exito!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20
      );

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);

    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });
  }

  quitarDano(idd) async {
    await DatabaseProvider.db.quitarDanoVIN(idd).then((value) {
      Fluttertoast.showToast(
        msg: "Daño: $idd fue quitado con Exito!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20
      );

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);

    }).timeout(const Duration(seconds: 30), onTimeout: () {
      itemP.addError();
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InspeccionVin(vin: vinSeleccionado))),
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        child: const Icon(Icons.note_add_rounded)
      ),
      body: infoDeVin(widget.inf)
    );
  }

  Widget infoDeVin(vi) {
    return ListView.builder(
      itemCount: vi.length,
      itemBuilder: (context, index) {
     
      vinSeleccionado = vi[index]['vinp']['vin'];
      
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'VIN: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        vi[index]['vinp']['vin'],
                        style: const TextStyle(
                          fontSize: 20
                        )
                      ),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () async {
                           await Clipboard.setData(ClipboardData(text: vi[index]['vinp']['vin']));
                        },
                        child: const Icon(
                          Icons.copy,
                          size: 23
                        )
                      )
                    ]
                  )
                ),
                _encabezados('Marca: ', vi[index]['vinp']['marca'] != null ? '${vi[index]['vinp']['marca']}' : 'Sin Identificar'),
                _encabezados('Modelo: ', vi[index]['vinp']['modelo'] != null ? '${vi[index]['vinp']['modelo']}' : 'Sin Identificar'),
                _encabezados('Comprado: ', vi[index]['vinp']['compra'] == 0 ? 'No' : 'Si'),
                _encabezados('Viaje: ', vi[index]['vinp']['idviaje'] != null ? ' ${vi[index]['vinp']['idviaje']}' : 'Sin Asignar'),
                _encabezados('Posicion: ', vi[index]['vinp']['posicion'] != null ? ' ${vi[index]['vinp']['posicion']}' : 'Sin Asignar'),
                _encabezados('Orientacion: ', vi[index]['vinp']['orientacion'] != null ? ' ${vi[index]['vinp']['orientacion']}' : 'Sin Asignar'),
                _encabezados('Fecha de registro: ', vi[index]['vinp']['fecha_creacion']),
                const SizedBox(height: 10),
                vi[index]['vinp']['compra'] == 0 ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: () =>comprarVin(vi[index]['vinp']['vin']),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(15)),
                      minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 40)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      )
                    ),
                    child: const Text(
                      'Realizar Compra',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      )
                    )
                  )
                ) : const SizedBox(),
                const SizedBox(height: 10),
                _cardDanos(vi[index]['danoos']),
              ]
            )
          )
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
                    leading: GestureDetector(
                      onTap: () => dato['area'] == null ? _dialogBuilder(context, '${dato['vin']}', '${dato['iddano']}', '${dato['registroTipo']}', () => quitarDano('${dato['iddano']}')): 
                      _dialogBuilder(context, '${dato['vin']}', '${dato['iddano']}', '${dato['area']}-${dato['tipo']}-${dato['severidad']}', () => quitarDano('${dato['iddano']}')),
                      child: const Icon(
                        Icons.dangerous,
                        size: 30
                      ),
                    ),
                    title: Row(
                      children: [
                        const Text(
                          'Daño: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          '$totalda',
                          style: const TextStyle(
                            fontSize: 18
                          )
                        )
                      ]
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
                  const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                    height: 20
                  ),
                  
                  dato['area'] == null ? const SizedBox() : _encabezados('Area: ', '${dato['area']}'),
                  dato['tipo'] == null ? const SizedBox() : _encabezados('Tipo: ', '${dato['tipo']}'),
                  dato['severidad'] == null ? const SizedBox() : _encabezados('Severidad: ', '${dato['severidad']}'),
            
                  dato['area'] == null ? _encabezados('Estado: ', '${dato['registroTipo']}') : const SizedBox(),

                  dato['area'] == null ? const SizedBox() : _encabezados('Codificacion: ', '${dato['area']}-${dato['tipo']}-${dato['severidad']}'),
                  _encabezadosCard('Notas: ', dato['nota'] != '' ?  '${dato['nota']}' : 'Sin notas'),
                  _encabezados('Evidencias: ', ''),
    
                  _evidenciasDano(dato['evidencias'])
                ]
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

  Future<void> _dialogBuilder(BuildContext context, vi, idd, da, onpress) {
    final _posicionTextController = TextEditingController();
    var orientacionSeleccionada;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                'Quitar Daño',
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
            height: 110,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'ID Daño: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      idd,
                      style: const TextStyle(
                        fontSize: 16
                      )
                    )
                  ]
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Codificacion: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      da,
                      style: const TextStyle(
                        fontSize: 16
                      )
                    )
                  ]
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
              child: const Text('Confirmar'),
              onPressed: onpress
            )
          ]
        );
      }
    );
  }

}