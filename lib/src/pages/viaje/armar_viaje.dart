import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class ArmarViaje extends StatefulWidget {
  const ArmarViaje({super.key});

  @override
  State<ArmarViaje> createState() => _ArmarViajeState();
}

class _ArmarViajeState extends State<ArmarViaje> {

  final _origenTextController = TextEditingController();
  final _ecoTextController = TextEditingController();
  final _nombreOpTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Armar Viaje',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Cuerpo(),

            _titulo('Numero Eco.'),
            _inputs(_ecoTextController, 'Escriba Numero Economico', TextInputType.number),
            const SizedBox(height: 10),

            _titulo('Nombre Operador'),
            _inputs(_nombreOpTextController, 'Escriba Nombre del Operador', TextInputType.text),
            const SizedBox(height: 10),

            _titulo('Origen'),
            _inputs(_origenTextController, 'Escriba el Origen del Viaje', TextInputType.text),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () => {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
              ),
                ),
                child: const Text(
                  'Agregar Vin',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  )
                )
              ),
            ),
            const SizedBox(height: 30),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                 return const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                   child: Card(
                      child: ListTile(
                        title: Text('title'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('subtitle1')
                          ]
                        )
                      )
                    )
                 );
              },
            ),
          ]
        )
      )
    );
  }

  Widget _inputs(control, place, tipo) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: control,
        keyboardType: tipo,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: place,
          hintStyle: const TextStyle(
            color: Colors.grey
          )
        )
      ),
    );
  }

  Widget _titulo(tit) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        tit,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
