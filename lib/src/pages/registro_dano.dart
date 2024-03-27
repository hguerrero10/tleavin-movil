// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tleavin_mobil/src/pages/inspeccion_vin.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:image_picker/image_picker.dart';
import 'resumen_dano.dart';

class RegistroDano extends StatefulWidget {
  final vin;
  final panel;

  const RegistroDano({super.key, this.vin, this.panel});

  @override
  State<RegistroDano> createState() => _RegistroDanoState();
}

class _RegistroDanoState extends State<RegistroDano> {

  List<int> list = <int>[1, 2, 3, 5, 6, 7, 8, 9, 10];
  final ImagePicker picker = ImagePicker();
  // List<XFile>? _mediaFileList;

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
      // setState(() {
      //   _mediaFileList = pickedFileList;
      // });
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
    int dropdownValue = list.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Daños'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Cuerpo(),
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
                  Row(
                    children: [
                      Text(
                        'VIN: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.vin,
                        style: TextStyle(
                          fontSize: 17
                        ),
                      )
                    ],
                  ),
                  _titulo('Area:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.panel,
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _titulo('Tipo:'),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownButton<int>(
                      items: list.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
    
                  ),
                  SizedBox(height: 10),
                  _titulo('Severidad:'),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownMenu<int>(
                      initialSelection: list.first,
                      onSelected: (int? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries: list.map<DropdownMenuEntry<int>>((int value) {
                        return DropdownMenuEntry<int>(value: value, label: value.toString());
                      }).toList(),
                    )
                  ),
       
                  SizedBox(height: 25),
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
                              onTap: () => getCamara(),
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
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InspeccionVin(vin: widget.vin)),
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
                              MaterialPageRoute(builder: (context) => ResumenDano(vin: widget.vin)),
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
            SizedBox(height: 20),
          ]
        )
      )
    );
  }

  Widget _titulo(String titulo) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17
            ),
          ),
        )
      ],
    );
  }
}