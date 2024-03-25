import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/src/pages/compra_vin.dart';
import 'package:tleavin_mobil/src/pages/pantalla2.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Usuario usuario = new Usuario();

  @override
  void initState() {
    super.initState();

    // crearUsuario();

    getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Sistema TLEAVIN ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Cuerpo(),
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
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 10.0,
              ),
            ),
            // Sección media
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Ultima Sincronizacion: 2024-02-20 12:45',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Perido: 2024-02-10  2024-02-20',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pantalla2()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                      ),
                    ),
                    child: Text(
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
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            // Sección inferior
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'La DB del dispositivo tiene 3 cargas pendiente por enviar.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Acción del botón
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                      ),
                    ),
                    child: Text(
                      'Enviar Cargas',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Compra_Vin()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16.0)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                            ),
                          ),
                          child: Text(
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