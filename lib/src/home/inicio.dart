import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/area_Dano.dart';
import 'package:tleavin_mobil/model/cliente.dart';
import 'package:tleavin_mobil/model/severidad.dart';
import 'package:tleavin_mobil/model/tipo_dano.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/viaje/armar_viaje.dart';
import 'package:tleavin_mobil/src/pages/vin/registro_vin.dart';
import 'package:tleavin_mobil/src/pages/vin/vins_disponibles.dart';
import 'package:tleavin_mobil/src/startup/login/login_form.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
// import 'package:tleavin_mobil/src/widgets/drawer.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {

  Usuario usuario = Usuario();
  AreaDano areadano = AreaDano();
  TipoDano tipodano = TipoDano();
  Severidad severidad = Severidad();
  Cliente cliente = Cliente();

  @override
  void initState() {

    registrarAreaDano();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MenuDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Inicio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout()
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
              children: [
                const Text(
                  'Bienvenido ',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  itemP.usuario!.nombre!,
                  style: const TextStyle(
                    fontSize: 21,
                  ),
                ),
              ],
            ),
          ),
            const Cuerpo(),
            const SizedBox(height: 40),
            _cuadricula1(),
            const SizedBox(height: 10),
            _cuadricula2()
          ]
        )
      )
    );
  }

  logout() async{
    usuario = Usuario(
      numeroEmpleado: itemP.usuario!.numeroEmpleado,
      nombre: itemP.usuario!.nombre,
      usuario: itemP.usuario!.usuario,
      password: itemP.usuario!.password,
      isLogged: 0,
      cargo: itemP.usuario!.cargo,
      estado: itemP.usuario!.estado
    );

    await DatabaseProvider.db.actualizarUsuario(usuario);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => const LoginForm()
    ),
      (Route<dynamic> route) => false
    );
  }

  registrarAreaDano() async {
    areadano = AreaDano(
      area: 'L-Izquierdo', 
      descripcion: 'TAPA DE GASOLINA/PUERTA DE CARGA DE BATERIA'
    );

    tipodano = TipoDano(
      descripcion: 'DOBLADO'
    );

    cliente = Cliente(
      idAdvan: 10,
      cliente: 'MAZDA',
    );

    severidad = Severidad(
      tipo: 'HASTA E INCLUYENDO 1" DE LARGO/DIÁMETRO',
      descripcion: 'MENOS DE 2,5 CM',
    );

    try{
      await DatabaseProvider.db.insertarAreaDano(areadano);
      log('insertado are');

      await DatabaseProvider.db.insertarTipoDano(tipodano);
      log('insertado tipo');

      await DatabaseProvider.db.insertarCliente(cliente);
      log('insertado cli');
  
      await DatabaseProvider.db.insertarSeveridad(severidad);
      log('insertado ser');
      
    } 
    catch (e) {
      log('error => $e');
    }
  }

  Widget _cuadricula1() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _panel(CupertinoIcons.car_detailed, () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const CompraVin()), (Route<dynamic> route) => false), 'Comprar vin'),
          _panel(Icons.route_outlined, () => Navigator.push(context,MaterialPageRoute(builder: (context) => const ArmarViaje())), 'Armar Viaje')
          // _panel(Icons.account_box_sharp, () => Navigator.pushNamed(context, 'viewreport'), 'Ver Reportes'),
        ]
      )
    );
  }
  
  Widget _cuadricula2() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _panel(CupertinoIcons.list_bullet_below_rectangle, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VinsDisponibles())), 'Vins Disponibles'),
          _panel(Icons.padding, () => Navigator.pushNamed(context, 'contact'), 'Contacto')
          // _panel(Icons.face, () => Navigator.pushNamed(context, 'predial'), 'Predial'),
        ]
      )
    );
  }

  Widget _panel(icono, onPress, text) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3) // changes position of shadow
          )
        ]
      ),
      child: SizedBox(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.4,
        child: ElevatedButton(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(242, 211, 0, 3)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              )
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: Colors.black,
              )
            )
          ),
          onPressed: onPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icono,
                color: Colors.black,
                size: 50
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}