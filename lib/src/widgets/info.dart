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
          'Info App',
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
              Row(
                children: [
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: Image.asset(
                      'assets/img/logo_tlea.png'
                    )
                  ),
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                  )
                ]
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
                height: 100,
                width: 100,
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
                          color: Color.fromARGB(249, 75, 32, 230)
                        )
                      )
                    ]
                  )
                )
              )
            ]
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Versión: 0.33.0',
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
                  'Compilación: 19101001',
                  style: TextStyle(
                    color: Color(0xfbb5bac9)
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
