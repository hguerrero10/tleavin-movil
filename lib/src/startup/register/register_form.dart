import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool pass = false;


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
    return Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar : true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/fondo_register.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(
                            child:  Text(
                              "Registro",
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.white
                              ),
                            )
                          ),
                        ),
                        const SizedBox(height: 50),
                        _input('Nombre', 'Nombre invalido', _nameController, TextInputType.text, Icons.person_outline, 10, false, false),
                        const SizedBox(height: 15),
                        _input('Telefono', 'Telefono invalido', _phoneController, TextInputType.phone, Icons.phone_outlined, 10, false, false),
                        const SizedBox(height: 15),
                        _input('Usuario', 'Usuario invalido', _emailController, TextInputType.text, Icons.person, 100, false, false),
                        const SizedBox(height: 15),
                        _inputPassword('Contraseña', 'Contraseña invalida', TextInputType.visiblePassword, _passwordController, Icons.vpn_key_outlined),
                        const SizedBox(height: 30),
                        _button('Registrar', const Color.fromRGBO(242, 211, 0, 1)  , () => {

                        }),
                      ],
                    )
                  )
                ]
              )
            ),
          ),
        ],
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

  Widget _input(String placeholder, String mensaje,  TextEditingController controller, TextInputType tipo, IconData icon, int max, [bool isPassword = false, bool isfocus = false]) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(left: 15, right: 15),
      alignment: Alignment.center,
      decoration: kBoxDecorationStyle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              autofocus: isfocus,
              controller: controller,
              obscureText: isPassword,
              autovalidateMode: AutovalidateMode.always,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              autocorrect: false,
              keyboardType: tipo,
              maxLength: max,
              decoration: InputDecoration(
                counterText: '',
                prefixIcon: Icon(icon, color: Colors.white),
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
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
      margin: const EdgeInsets.only(left: 15, right: 15),
      height: 60,
      decoration: kBoxDecorationStyle,
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: !pass,
              style: const TextStyle(color: Colors.white, fontSize: 15),
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
                    pass ?
                    Icons.visibility_off_outlined : Icons.visibility_outlined, 
                    color: Colors.white,
                  ), 
                  onPressed: () {
                    setState(() {
                      pass = !pass;
                    });
                  }
                ),
                hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(String nombre, Color color, onPressed) {
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
                          fontSize: 17
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
    // _registerBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    // _registerBloc.add(PasswordChanged(password: _passwordController.text));
  }
}