import 'package:flutter/material.dart';

class InfoApp extends StatefulWidget {
    const InfoApp({super.key});

  @override
  State<InfoApp> createState() => _InfoAppState();
}

class _InfoAppState extends State<InfoApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Informacion de App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 125,
                width: 125,
                child: Image.asset(
                  'assets/img/logo_tlea.png'
                )
              ),
              const SizedBox(
                height: 80,
                child: VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                  width: 10
                )
              ),
              SizedBox(
                height: 85,
                width: 85,
                child: Image.asset(
                  'assets/img/logopp.png'
                )
              )
            ]
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 3),
                child: GestureDetector(
                  onDoubleTap: () {
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Developed by ',
                        style: TextStyle(
                          color: Color.fromARGB(250, 134, 135, 138)
                        ),
                      ),
                      Text(
                        'H_Guerrero',
                        style: TextStyle(
                          color: Color.fromRGBO(242, 211, 0, 1),
                        )
                      )
                    ]
                  )
                )
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 3),
                child: const Text(
                  'Flutter: 3.16.9',
                  style: TextStyle(
                    color: Color(0xfbb5bac9)
                  )
                )
              )
            ]
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Versión: 1.4.0',
                style: TextStyle(
                  color: Color(0xfbb5bac9)
                )
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 3),
                child: const Text(
                  '© 2024',
                  style: TextStyle(
                    color: Color(0xfbb5bac9)
                  )
                )
              )
            ]
          )
        ]
      )
    );
  }
}
