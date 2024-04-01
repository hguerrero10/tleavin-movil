import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/home/inicio.dart';
// import 'package:tleavin_mobil/src/startup/register/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  Usuario nuevousuario = Usuario();

  Usuario? usuario;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool pass = false;
  bool get isPopulated => _userController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    crearUsuario();

    super.initState();
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
      body: SafeArea(
        bottom: false,
        top: false,
        child: StreamBuilder(
          stream: itemP.getStream,
          initialData: itemP.registroUser,
          builder:(context, snapshot) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 97,
                image: AssetImage("assets/img/fondo_login.jpg"),
                fit: BoxFit.cover
              ),
            ),
            child: SizedBox(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 260),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/img/logo_tlea.png', width: 270, height: 220),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: _input('Usuario', 'Usuario invalido', TextInputType.text, _userController, Icons.person, false, false),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: _inputPassword('Contraseña', 'Contraseña invalida', TextInputType.visiblePassword, _passwordController, Icons.vpn_key_outlined),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 40),
                          child: _buttons('Iniciar Sesion', const Color.fromRGBO(242, 211, 0, 1)  , () => {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) {
                            //       return const InicioScreen();
                            //     }
                            //   )
                            // )
          
                            if(_userController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                              // animacionEnviar();  
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
                          }),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left:15, right: 15),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       TextButton(
                        //         child: const Text(
                        //           'Crear cuenta',
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //           )
                        //         ),
                        //         onPressed: () {
                        //           Navigator.of(context).push(
                        //             MaterialPageRoute(builder: (context) {
                        //               return RegisterScreen(
                        //                 // userRepository: _userRepository,
                        //               );
                        //             }
                        //           )
                        //         );
                        //         },
                        //       ),
                        //       // TextButton(
                        //       //   child: const Text(
                        //       //     'Restablecer contraseña',
                        //       //     style: TextStyle(
                        //       //       color: Colors.white,
                        //       //     )
                        //       //   ),
                        //       //   onPressed: () {},
                        //       // ),
                        //     ],
                        //   ),
                        // )
                      ],
                    )
                  )
                ],
              ),
            )
          );
        }),
      ),
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
          backgroundColor: Colors.red,
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
            estado: value.estado,
          );
        });
        
        log(value.toString());
        DatabaseProvider.db.actualizarUsuario(usuario!);
        itemP.addUser(value);
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
    nuevousuario = Usuario(
      numeroEmpleado: 2044,
      nombre: 'Hugo Guerrero',
      usuario: 'h_guerrero', 
      password: 'Hugo1010', 
      isLogged: 0,
      cargo: 'Desarrollador',
      estado: 'A'
    );

    try{
      await DatabaseProvider.db.insertarUsuario(nuevousuario);
      log('insertado');
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
                hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputPassword(String placeholder, String mensaje, TextInputType tipo, TextEditingController controller, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: kBoxDecorationStyle,
      padding: const EdgeInsets.only(left: 10),
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
              ),
            ),
          ),
        ],
      ),
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
            child:  ElevatedButton(
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
                          color: Colors.white, 
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}