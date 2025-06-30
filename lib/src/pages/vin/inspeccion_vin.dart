import 'package:flutter/scheduler.dart';

import '../dano/registro_dano.dart';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:tleavin_mobil/src/pages/dano/registro_unidad_ss.dart';
// import 'package:tleavin_mobil/src/pages/vin/registro_vin.dart';

class InspeccionVin extends StatefulWidget {
  final vin;
  const InspeccionVin({super.key, this.vin});

  @override
  State<InspeccionVin> createState() => _InspeccionVinState();
}

class _InspeccionVinState extends State<InspeccionVin> {
  final stopwatch = Stopwatch();
  late final Ticker _ticker;
  String tiempoFormateado = "00:00";

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    _ticker = Ticker((_) {
      setState(() {
        final duration = stopwatch.elapsed;
        final minutos = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
        final segundos = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
        tiempoFormateado = "$minutos:$segundos";
      });
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    stopwatch.stop();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirmExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Quieres salir de la Inspeccion?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); 
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);
                },
                child: const Text('Sí')
              )
            ]
          )
        );
        
        return confirmExit;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
          title: const Text(
            'Inspeccion VIN',
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
                 Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Text(
                      'Registro de Daños',
                      style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.timer, 
                      color: Colors.red
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tiempoFormateado.toString(),
                      style: const TextStyle(
                        color: Colors.red
                      ),
                    )
                  ],
                )
                ),
                const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
          
                  ],
                ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const Text(
                          'VIN: ',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          widget.vin,
                          style: const TextStyle(
                            fontSize: 17
                          )
                        )
                      ]
                    )
                  ]
                )
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 460,
                  height: 540,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/inspeccion_vehiculo.jpg'),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Stack(
                    children: [
                      _boton(60, 167, 'Frente', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'FRENTE', stopw: stopwatch,)))),

                      _boton(170, 165, 'Interior', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'INTERIOR', stopw: stopwatch,)))), 
                      
                      _botonVertical(205, 60, 1, 'L-Izquierdo', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'L-IZQUIERDO', stopw: stopwatch,)))),
                     
                      _boton(290, 165, 'P-Superior', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'P-SUPERIOR', stopw: stopwatch,)))),
                      
                      _botonVertical(205, 375, 3, 'L-Derecho', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'L-DERECHO', stopw: stopwatch,)))),
                      
                      _boton(475, 167, 'P-Tracera', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'P-TRACERA', stopw: stopwatch,)))),
                      
                      _boton(390, 10, 'B-Vehiculo', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'B-VEHICULO', stopw: stopwatch,)))),
                      
                      _boton(420, 275, 'Accesorios', () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin, panel: 'ACCESORIOS', stopw: stopwatch,))))
                    ]
                  )
                )
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroUnidadSS(vin: widget.vin, tipo: 'Unidad Sucia'))),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      )
                    ),
                    child: const Text(
                      'Unidad Sucia',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      )
                    )
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroUnidadSS(vin: widget.vin, tipo: 'Unidad Sin Daños'))),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      )
                    ),
                    child: const Text(
                      'Sin Daños',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      )
                    )
                  )
                ]
              ),
              const SizedBox(height: 30)
            ]
          )
        )
      )
    );
  }

  Widget _boton(double top, double left, String text, onTap) {
    return Positioned(
      top: top,
      left: left,
      child:  SizedBox(
        height: 30,
        width: 130,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              )
            )
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15
            )
          )
        )
      )
    );
  }

  Widget _botonVertical(double top, double left, int rote, String text, onTap) {
    return Positioned(
      top: top,
      left: left,
      child: RotatedBox(
        quarterTurns: rote,
        child: SizedBox(
          height: 30,
          width: 140,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              )
            ),
            onPressed: onTap,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15
              )
            )
          )
        )
      )
    );
  }

}