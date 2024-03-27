import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/src/pages/compra_vin.dart';
import 'package:tleavin_mobil/src/pages/pantalla2.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
// import 'package:tleavin_mobil/src/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Usuario usuario = Usuario();

  @override
  void initState() {
    super.initState();

    // crearUsuario();

    getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Sistema TLEAVIN ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
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
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
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
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CompraVin()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
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

  Future getUsuarios() async {
    try{
      await DatabaseProvider.db.obtenerUsuarios().then((value) {
        setState(() {
          // servidorPublicoList = value;

          print('usuarios => $value');
        });
      });
    } 
    catch (e) {
      print('error => $e');
    }
  }

  crearUsuario() async {
    usuario = Usuario(
      numero_empleado: 2044,
      nombre: 'Hugo Guerrero',
      usuario: 'h_guerrero', 
      password: 'Hugo1010', 
      isLogged: 0,
      cargo: 'Desarrollador',
      estado: 'A'
    );

    await DatabaseProvider.db.insertarUsuario(usuario);
  }
}