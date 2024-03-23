import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tleavin_mobil/src/widgets/bodycontent.dart';
import 'package:image_picker/image_picker.dart';
import 'pantalla9.dart';

class Pantalla8 extends StatefulWidget {
  const Pantalla8({super.key});

  @override
  State<Pantalla8> createState() => _Pantalla8State();
}

class _Pantalla8State extends State<Pantalla8> {

final ImagePicker picker = ImagePicker();
List<XFile>? _mediaFileList;

Future<void> getCamara() async {
   final List<XFile> pickedFileList = <XFile>[];
  final photo = await picker.pickImage(
    source: ImageSource.camera,
     maxHeight: 1080,
     maxWidth: 1920,
     imageQuality: 100
  );

  if(photo != null) {
    await GallerySaver.saveImage(photo.path, albumName: 'TLEAVIN');

    pickedFileList.add(XFile(photo.path));
    setState(() {
      _mediaFileList = pickedFileList;
    });
  }

  // if(photo != null) {
  //   pickedFileList.add(photo);
  //   setState(() {
  //     _mediaFileList = pickedFileList;
  //   });
  // }
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 8'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Cuerpo(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Unidad TLEA-458',
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  ),
                  Text(
                    'Bitacora: 789654',
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  ),
                ]
              )
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Verificado 1 de 8',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 20.0,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Table(
                    border: TableBorder.all(),
                    children: const [
                      TableRow(
                        children: [
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '3GTPUCEK2G274842',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '2022 Chevrolet Silverdo 4WD',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                'Area:',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                              child: Text(
                                'Tipo:',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                              child: Text(
                                'Gravedad:',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                'Ubicacion:',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                  SizedBox(height: 25.0,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'NOTAS',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => {
                                getCamara()

  
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/camara.png',
                                    width: 150,
                                    height: 150,
                                  ),
                                  Text(
                                    'Tomar Fotografia',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  // Container(
                                  //   height: 200,
                                  //   width: 200,
                                  //   child: ListView.builder(
                                  //     key: UniqueKey(),
                                  //     itemBuilder: (BuildContext context, int index) {
                                  //       return Semantics(
                                  //         label: 'image_picker_example_picked_image',
                                  //         child: Image.file(
                                  //         File(_mediaFileList![index].path),
                                  //         errorBuilder: (BuildContext context, Object error,
                                  //             StackTrace? stackTrace) {
                                  //           return const Center(
                                  //               child:
                                  //                   Text('This image type is not supported'));
                                  //         },
                                  //       )
                                                  
                                  //       );
                                  //     },
                                  //   ),
                                  // )

                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   style: ButtonStyle(
                            //     backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                            //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                            //     shape: MaterialStateProperty.all(
                            //       RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(16)
                            //       ),
                            //     ),
                            //   ),
                            //   child: Text(
                            //     'Adjuntar Imagen',
                            //     style: TextStyle(
                            //       fontSize: 20.0,
                            //       color: Colors.white
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                            shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                          ),
                          child: Text(
                            'Registrar Otro Daño',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pantalla9()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18.0)),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                            shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                          ),
                          child: Text(
                            'Finalizar',
                            style: TextStyle(
                              fontSize: 20.0,
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
            SizedBox(height: 30),
          ]
        )
      )
    );
  }
}