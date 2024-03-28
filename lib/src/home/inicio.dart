import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/compra_vin.dart';
import 'package:tleavin_mobil/src/pages/pantalla2.dart';
import 'package:tleavin_mobil/src/startup/login/login_form.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'dart:developer';
// import 'package:tleavin_mobil/src/widgets/drawer.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {

  Usuario usuario = Usuario();

  @override
  void initState() {
    super.initState();


    getUsuarios();
    crearUsuario();
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       'assets/img/nube5G.png',
            //       width: 180,
            //       height: 190,
            //     ),
            //     Image.asset(
            //       'assets/img/nubeGris.png',
            //       width: 180,
            //       height: 190,
            //     ),
            //   ],
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 10.0,
              ),
            ),
            // Sección media
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Ultima Sincronizacion: 2024-02-20 12:45',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    'Perido: 2024-02-10  2024-02-20',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Pantalla2()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                      ),
                    ),
                    child: const Text(
                      'Actualizar Viajes',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Línea divisoria
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            // Sección inferior
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'La DB del dispositivo tiene 3 cargas pendiente por enviar.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Acción del botón
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                      ),
                    ),
                    child: const Text(
                      'Enviar Cargas',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const CompraVin()), (Route<dynamic> route) => false),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                      ),
                    ),
                    child: const Text(
                      'Embarque Manual', 
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        )
      ),
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

  Future getUsuarios() async {
    try{
      await DatabaseProvider.db.obtenerUsuarios().then((value) {
        setState(() {
          log('usuarios => $value');
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }
  }

  crearUsuario() async {
    usuario = Usuario(
      numeroEmpleado: 2044,
      nombre: 'Hugo Guerrero',
      usuario: 'h_guerrero', 
      password: 'Hugo1010', 
      isLogged: 0,
      cargo: 'Desarrollador',
      estado: 'A'
    );

    try{
      await DatabaseProvider.db.insertarUsuario(usuario);
    } 
    catch (e) {
      log('error => $e');
    }
  }
}