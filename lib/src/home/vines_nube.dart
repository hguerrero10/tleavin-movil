import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:tleavin_mobil/src/widgets/search.dart';
//
class VistaCloud extends StatefulWidget {
  const VistaCloud({super.key});

  @override
  State<VistaCloud> createState() => _VistaCloudState();
}

class _VistaCloudState extends State<VistaCloud> {
  String query = '';
  var listadevines = [];
  var todosVins = [];

  Future<void> obtenerlistaCompletaVins() async {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final fechaFin = formatter.format(now);
    final fechaInicio = formatter.format(now.subtract(const Duration(days: 7)));

    final url = Uri.parse('https://parapruebas.tlea.online/obtenerVINESsincornizados/$fechaInicio/$fechaFin');
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final decoded = json.decode(response.body);
      var datos = decoded['Vines'] ?? [];
    
      log('Datos obtenidos: $datos');
      setState(() {
        todosVins = datos;
        listadevines = todosVins;
      });
    }
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
          'VINES Sincronizadosa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false)
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),
            const SizedBox(height: 5),
            buildSearch(),
            listadevines.isNotEmpty
              ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listadevines.length,
                itemBuilder: (context, index) {
                  final vin = listadevines[index];
                  return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(CupertinoIcons.car_detailed, color: Colors.amber),
                    title: Text(
                      vin['vin'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                      subtitle: vin['fecha_sync'] != null ? 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Marca: ${vin['marca']}', style: const TextStyle(color: Colors.grey)),
                          Text('Modelo: ${vin['modelo']}', style: const TextStyle(color: Colors.grey)),
                          Text('Fecha: ${vin['fecha_sync']}', style: const TextStyle(color: Colors.grey)),
                        ],
                      ) 
                      : null,
                    ),
                  );
                },
                )
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const SizedBox(height: 200),
                  Icon(
                    CupertinoIcons.car_detailed,
                    color: Colors.grey[300],
                    size: 60,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    child: Text(
                    'No hay VINES Disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 19,
                    ),
                    ),
                  ),
                  ],
                ),
                )
          ]
        )
      )
    );
  }



  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Escriba el VIN',
    onChanged: searchVIN
  );

  void searchVIN(String query) {
    final vines = todosVins.where((v) {
      final titleLower = v['vin'].toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      listadevines = vines;
    });
  }
}