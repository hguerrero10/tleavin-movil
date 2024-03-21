import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/home/home.dart';
import 'package:tleavin_mobil/src/startup/register/register_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool pass = false;
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
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
                        child: _input('Usuario', 'Usuario invalido', TextInputType.text, _emailController, Icons.person, false, false),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: _inputPassword('Contraseña', 'Contraseña invalida', TextInputType.visiblePassword, _passwordController, Icons.vpn_key_outlined),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: _buttons('Iniciar Sesion', const Color.fromRGBO(242, 211, 0, 1)  , () => {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return HomeScreen(
                                    );
                                  }
                                )
                              )
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              child: const Text(
                                'Crear cuenta',
                                style: TextStyle(
                                  color: Colors.white,
                                )
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return RegisterScreen(
                                      // userRepository: _userRepository,
                                    );
                                  }
                                )
                              );
                              },
                            ),
                            // TextButton(
                            //   child: const Text(
                            //     'Restablecer contraseña',
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //     )
                            //   ),
                            //   onPressed: () {},
                            // ),
                          ],
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          )
        ),
      ),
    );
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

  void _onEmailChanged() {
    // _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    // _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }
}