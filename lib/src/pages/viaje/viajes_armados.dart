import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/viaje/detalle_viaje.dart';

class ViajesArmados extends StatefulWidget {
  const ViajesArmados({super.key});

  @override
  State<ViajesArmados> createState() => _ViajesArmadosState();
}

class _ViajesArmadosState extends State<ViajesArmados> {
  
  var listaViajes = [];
  var informacionDelViaje = [];

  obtenerViajes() async {
    var data = await DatabaseProvider.db.obtenerViajes();

    setState(() {
      listaViajes = data;
    });
  }

  obtenerViaje(infviaje) async {
    var data = await DatabaseProvider.db.obtenerInfoViaje(infviaje);

    setState(() {
      informacionDelViaje = data;
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleDeViaje(viaje: informacionDelViaje)));
  }

  @override
  void initState() {
    obtenerViajes();

    itemP.deleteFirmaInspecctor();
    itemP.deleteFirmaOperador();
    itemP.deleteFirmaOperadorLogisticio();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Viajes Armados',
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
                Expanded(child: viajes())
              ]
            )
          )
        ]
      )
    );
  }

  Widget viajes() {
    return listaViajes.isNotEmpty ? ListView.builder(
      shrinkWrap: true,
      itemCount: listaViajes.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dato = listaViajes[index];
        return GestureDetector(
          onTap: () async => await obtenerViaje('${dato.idviaje}'),
          child: Container(
            height: 190,
            width: 300,
            margin: const EdgeInsets.only(left: 19, right:19, top: 19, bottom: 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/img/carddi.png'
                ),
                fit: BoxFit.cover
              )
            ),
            child: Card(
              color: const Color.fromARGB(0, 43, 43, 43),
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _encabezadosCard('Numero Eco.: ', '${dato.num_eco_unidad}'),
                    _encabezadosCard('Nombre Op.: ', '${dato.nombre_operador}'),
                    _encabezadosCard('Origen: ', '${dato.origen}'),
                    _encabezadosCard('Destino: ', '${dato.destino}'),
                    _encabezadosCard('Estado: ', '${dato.estadoViaje}')
                  ]
                )
              )
            )
          )
        );
      }
    ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.route,
            color: Colors.grey[300],
            size: 60
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 250,
            child: Text(
              'No hay viajes disponibles',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 19
              )
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
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(
          width: 180,
          child: Text(
            sub ?? '',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            )
          )
        )
      ]
    );
  }
}