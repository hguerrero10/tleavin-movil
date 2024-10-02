import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  Usuario? usuario;
  
  Usuario nuevousuario = Usuario();

  String urlUsuariosAppServer = 'https://parapruebas.tlea.online/obtenerUsuarios';
  Usuario? usuarioInsertList;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool pass = false;
  bool get isPopulated => _userController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  Future obtenerUsuariosAppServer() async {
    var responseData;
    try{
      final result = await InternetAddress.lookup('parapruebas.tlea.online');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try{
          await http.get(Uri.parse(urlUsuariosAppServer),headers: {"Content-Type" : "application/json"}).then((value) async {
            if(value.statusCode == 200) {
              responseData = json.decode(value.body);
              await DatabaseProvider.db.borrarBDUsuarios();

              for(var value in responseData['Usuarios']) {
                usuarioInsertList = null;
                usuarioInsertList = Usuario(
                  numeroEmpleado: value['numero_empleado'],
                  usuario: value['usuario'],
                  nombre: value['nombre'],
                  password: value['password'],
                  isLogged: 0,
                  cargo: value['cargo'],
                  locacion: value['locacion'],
                  estado: value['estado']
                );
                
                await DatabaseProvider.db.insertarUsuario(usuarioInsertList!);
              }

              final snackBar = SnackBar(
                  showCloseIcon: true,
                  backgroundColor: Colors.green,
                  content: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Row(
                      children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 20
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Usuarios Sincronizados', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 20
                        )
                      )
                    ]
                  )
                )
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              itemP.addLoginInsert();
            } 
            else {
              itemP.addLoginInsertTimeOut();
              itemP.addRegistroUser();
                         final snackBar = SnackBar(
                showCloseIcon: true,
                backgroundColor: Colors.red,
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Row(
                    children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 20
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sin conexion al servidor', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 20
                      )
                    )
                  ]
                )
              )
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }).timeout(const Duration(seconds: 15), onTimeout: () {
            itemP.addLoginInsertTimeOut();
            itemP.addRegistroUser();
                final snackBar = SnackBar(
                showCloseIcon: true,
                backgroundColor: Colors.red,
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Row(
                    children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 20
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sin conexion al servidor', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 20
                      )
                    )
                  ]
                )
              )
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        } 
        catch (e) {
          final snackBar = SnackBar(
              showCloseIcon: true,
              backgroundColor: Colors.red,
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Row(
                  children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 20
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Sin conexion al servidor', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 20
                    )
                  )
                ]
              )
            )
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          itemP.addRegistroUser();
          itemP.addLoginInsertTimeOut();
        }
      }
    } on SocketException catch (_) {
      itemP.addLoginInsertTimeOut();
      itemP.addRegistroUser();
      final snackBar = SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.red,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Row(
              children: [
              Icon(
                Icons.cancel,
                color: Colors.white,
                size: 20
              ),
              SizedBox(width: 10),
              Text(
                'Sin conexion al servidor', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20
                )
              )
            ]
          )
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    // crearUsuario();
    obtenerUsuariosAppServer();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/fondo_register.jpg"), 
                fit: BoxFit.cover,
                opacity: 0.7
              )
            )
          ),
          SingleChildScrollView(
            child: StreamBuilder(
              stream: itemP.getStream,
              initialData: itemP.registroUser,                                
              builder:(context, snapshot) {
                return Container(
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                        const SizedBox(height: 160),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 160),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/img/logo_tlea.png', width: 290, height: 210)
                            ]
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: _input('Usuario', 'Usuario invalido', TextInputType.text, _userController, Icons.person, false, false)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: _inputPassword('Contraseña', 'Contraseña invalida', TextInputType.visiblePassword, _passwordController, Icons.vpn_key_outlined)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 40),
                          child: _buttons('Iniciar Sesion', const Color.fromRGBO(242, 211, 0, 1), () => {
                            if(_userController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                              login()
                            } 
                            else {
                              Fluttertoast.showToast(
                                msg: "Favor de llenar los campos",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 20
                              )
                            }
                          }
                        )
                      )
                    ]
                  )
                );
              }
            )
          )
        ]
      )
    );
  }

  login() async {
    DatabaseProvider.db.login(_userController.text.trim(), _passwordController.text.trim()).then((value)  {
      if(value.numeroEmpleado == null) {
        itemP.addError();

        Fluttertoast.showToast(
          msg: "Contraseña y/o Usuario incorrectos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.yellow,
          textColor: Colors.white,
          fontSize: 16.0
        );
      } 
      else {
        itemP.addBoton();
        setState(() {
          usuario = Usuario(
            numeroEmpleado: value.numeroEmpleado,
            usuario: value.usuario,
            nombre: value.nombre,
            password: value.password,
            isLogged: 1,
            cargo: value.cargo,
            locacion: value.locacion,
            estado: value.estado
          );
        });
        
        itemP.addUser(value);
        DatabaseProvider.db.actualizarUsuario(usuario!);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => const InicioScreen()), (Route<dynamic> route) => false);
      }
      itemP.deleteBoton();
    });
  }

  final kBoxDecorationStyle = BoxDecoration(
    color: Colors.black38,
    borderRadius: BorderRadius.circular(5.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.transparent,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  crearUsuario() async {
    await DatabaseProvider.db.borrarBDUsuarios();

    nuevousuario = Usuario(
      numeroEmpleado: 2044,
      nombre: 'Usuario Prueba',
      usuario: 'usuario', 
      password: 'qwerty123', 
      isLogged: 0,
      cargo: 'Pruebas',
      locacion: 'Salinas',
      estado: 'A'
    );

    try{
      await DatabaseProvider.db.insertarUsuario(nuevousuario);
        final snackBar = SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.green,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Row(
              children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20
              ),
              SizedBox(width: 10),
              Text(
                'Usuarios Sincronizados', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20
                )
              )
            ]
          )
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      itemP.addLoginInsert();
    } 
    catch (e) {
      log('error => $e');
    }
  }
  
  Widget _input(String placeholder, String mensaje, TextInputType tipo, TextEditingController controller, IconData icon, [bool isPassword = false, bool isfocus = false]) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 15, right: 15),
      height: 60,
      decoration: kBoxDecorationStyle,
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              autofocus: isfocus,
              controller: controller,
              obscureText: isPassword,
              onEditingComplete:() => FocusScope.of(context).nextFocus(),
              textInputAction: TextInputAction.next,
              style: const TextStyle(color: Colors.white, fontSize: 17),
              autocorrect: false,
              keyboardType: tipo,
              decoration: InputDecoration(
                icon: Icon(icon, color: Colors.white),
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: Colors.white, 
                  fontSize: 17
                )
              )
            )
          )
        ]
      )
    );
  }

  Widget _inputPassword(String placeholder, String mensaje, TextInputType tipo, TextEditingController controller, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      padding: const EdgeInsets.only(left: 10),
      decoration: kBoxDecorationStyle,
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: !pass,
              style: const TextStyle(color: Colors.white, fontSize: 17),
              autocorrect: false,
              textAlign: TextAlign.left,
              keyboardType: tipo,
              onEditingComplete:() => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                icon: Icon(icon, color: Colors.white),
                border: InputBorder.none,
                hintText: placeholder,
                contentPadding: const EdgeInsets.only(top: 17.0),
                suffixIcon: IconButton(
                  icon: Icon(
                    pass ? Icons.visibility_off_outlined : Icons.visibility_outlined, 
                    color: Colors.white,
                  ), 
                  onPressed: () {
                    setState(() {
                      pass = !pass;
                    });
                  }
                ),
                hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
              )
            )
          )
        ]
      )
    );
  }

  Widget _buttons(String nombre, Color color, onPressed) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        nombre,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black, 
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        )
                      )
                    )
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }
}