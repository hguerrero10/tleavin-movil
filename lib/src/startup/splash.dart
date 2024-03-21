import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/splash.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/img/logo_tlea.png',
                height: 117,
                width: 317 
              )
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(242, 211, 0, 0)),
              strokeWidth: 5,
            )
          ],
        ),
      )     
    );
  }
}