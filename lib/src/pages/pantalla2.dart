import 'package:flutter/material.dart';
import 'package:tleavin_mobil/src/widgets/bodycontent.dart';
import 'pantalla3.dart';

class Pantalla2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla 2'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Cuerpo(),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pantalla3()),
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
                      'Ver Embarques', 
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.0,
                      height: 20.0,
                    ),
                  ),
                  Container(
                    //padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        Text(
                          'Unidad',
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Ingrese la unidad',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pantalla3()),
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
                            'Realizar Carga', 
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1.0,
                            height: 20.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Pantalla3()),
                            // );
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

                      ]
                    ),
                  ),
                ]
              )
            )
          ]
        ),
      )
    );
  }
}
