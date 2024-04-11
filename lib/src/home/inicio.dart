import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/areaDano.dart';
import 'package:tleavin_mobil/model/cliente.dart';
import 'package:tleavin_mobil/model/severidad.dart';
import 'package:tleavin_mobil/model/tipo_dano.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/sincronizacion/enviar.dart';
import 'package:tleavin_mobil/src/pages/viaje/armar_viaje.dart';
import 'package:tleavin_mobil/src/pages/viaje/viajes_armados.dart';
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
            const Cuerpo(),
            Container(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                children: [
                  const Text(
                    'Bienvenido ',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    itemP.usuario!.nombre!,
                    style: const TextStyle(
                      fontSize: 21,
                    )
                  )
                ]
              )
            ),
            const SizedBox(height: 40),
            _cuadricula1(),
            const SizedBox(height: 10),
            _cuadricula2(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Sincronizar())),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(15)),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  )
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.swap_vert,
                      color: Colors.white,
                      size: 30
                    ),
                    // AnimateIcon(
                    //     onTap: () {},
                    //     iconType: IconType.continueAnimation,
                    //     height: 30,
                    //     width: 30,
                    //     color: Colors.white,
                    //     animateIcon: AnimateIcons.cloud,
                    // ),
                    SizedBox(width: 10),
                    Text(
                      'Sincronizar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      )
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }

  logout() async {
    usuario = Usuario(
      numeroEmpleado: itemP.usuario!.numeroEmpleado,
      nombre: itemP.usuario!.nombre,
      usuario: itemP.usuario!.usuario,
      password: itemP.usuario!.password,
      isLogged: 0,
      cargo: itemP.usuario!.cargo,
      locacion: itemP.usuario!.locacion,
      estado: itemP.usuario!.estado
    );

    await DatabaseProvider.db.actualizarUsuario(usuario);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => const LoginForm()),
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

    severidad = Severidad(
      tipo: 'HASTA E INCLUYENDO 1" DE LARGO/DIÁMETRO',
      descripcion: 'MENOS DE 2,5 CM',
    );

    var cliente1 = Cliente(
      idAdvan: 10,
      cliente: 'AMERICAN HONDA',
    );

    var cliente2 = Cliente(
      idAdvan: 11,
      cliente: 'AUDI',
    );

    var cliente3 = Cliente(
      idAdvan: 12,
      cliente: 'BMW',
    );

    var cliente4 = Cliente(
      idAdvan: 13,
      cliente: 'CHIREY',
    );

    try{
      await DatabaseProvider.db.insertarAreaDano(areadano);
      log('insertado are');

      await DatabaseProvider.db.insertarTipoDano(tipodano);
      log('insertado tipo');

      await DatabaseProvider.db.insertarSeveridad(severidad);
      log('insertado severidad');

      await DatabaseProvider.db.insertarCliente(cliente1);
      log('insertado cli');
  
      await DatabaseProvider.db.insertarCliente(cliente2);
      log('insertado clie');

      await DatabaseProvider.db.insertarCliente(cliente3);
      log('insertado clie');

      await DatabaseProvider.db.insertarCliente(cliente4);
      log('insertado clie');
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
          _panel(CupertinoIcons.car_detailed, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CompraVin())), 'Comprar vin'),
          _panel(CupertinoIcons.list_bullet_below_rectangle, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VinsDisponibles())), 'Vins Disponibles')
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
          _panel(Icons.route_outlined, () => Navigator.push(context,MaterialPageRoute(builder: (context) => const ArmarViaje())), 'Armar Viaje'),
          _panel(Icons.list_alt_sharp, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ViajesArmados())), 'Viajes')
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
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: SizedBox(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.4,
        child: ElevatedButton(
          onPressed: onPress,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icono,
                size: 50,
                color: Colors.black
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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