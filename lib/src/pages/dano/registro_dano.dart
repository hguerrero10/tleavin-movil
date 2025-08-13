import 'dart:io';
import 'dart:core';
import 'dart:convert';
import 'dart:developer';
// import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/database/db.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:tleavin_mobil/src/widgets/cuerpo.dart';
import 'package:tleavin_mobil/src/pages/dano/listas.dart';
import 'package:tleavin_mobil/provider/items_provider.dart';
import 'package:tleavin_mobil/src/pages/dano/resumen_dano.dart';
// import 'package:tleavin_mobil/src/pages/vin/inspeccion_vin.dart';

class RegistroDano extends StatefulWidget {
  final vin;
  final panel;
  final stopw;

  const RegistroDano({super.key, this.vin, this.panel, this.stopw});

  @override
  State<RegistroDano> createState() => _RegistroDanoState();
}

class _RegistroDanoState extends State<RegistroDano> {

  final _formKey = GlobalKey<FormState>();

  var formato;
  var formatWH;
  var fecha;
  var fechaH;

  final _notasTextController = TextEditingController();

  final _areaTextController = TextEditingController();
  final _tipoTextController = TextEditingController();
  final _severidadTextController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  String? base64Foto1;
  String? base64Foto2;
  String? base64Foto3;
  String? base64Foto4;
  var evidenciasDano = [];

  List<ListasA> listaAreaDanos = [];
  List<ListasT> listaTipoDanos = [];
  List<ListasS> listaSeveridad = [];
  List<String> listaCliente = [];
  
  String? selectArea;
  String? selectTipo;
  String? selectSeve;
  String? selectClien;

  Dano? dano;
  Evidencia? evidencia;

  String queryA = '';
  var queryT;
  var queryS;

  List<String> listaA = [];
  List<String> listaT = [];
  List<String> listaS = [];

  var enviando = true;
  var otroenviando = true;
    
  Future<void> getCamara(foto) async {
    final List<XFile> pickedFileList = <XFile>[];
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
      imageQuality: 100
    );

    if(photo != null) {
      await GallerySaver.saveImage(photo.path, albumName: 'TLEAVIN');
      setState(() {
        pickedFileList.add(XFile(photo.path));
        convertirBase64(photo.path, foto);
      });
    }
  }

  convertirBase64(value, foto) async {
    if(value != null) {
      final imageData = await File(value).readAsBytes();
      
      if(foto == 1) {
        base64Foto1 = null;
        base64Foto1 = base64Encode(imageData);
        evidenciasDano.add(base64Foto1);
      }

      if(foto == 2) {
        base64Foto2 = null;
        base64Foto2 = base64Encode(imageData);
        evidenciasDano.add(base64Foto2);
      }

      if(foto == 3) {
        base64Foto3 = null;
        base64Foto3 = base64Encode(imageData);
        evidenciasDano.add(base64Foto3);
      }

      if(foto == 4) {
        base64Foto4 = null;
        base64Foto4 = base64Encode(imageData);
        evidenciasDano.add(base64Foto4);
      }
    }
  }

  var resumen;

  String? _searchingWithQuery;
    // late final Ticker _ticker;
  String tiempoFormateado = "00:00";

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    formato = DateFormat('yyyy-MM-dd hh:mm:ss'); 
    formatWH = DateFormat('yyyy-MM-dd hh:mm:ss'); 
    fecha = formato.format(DateTime.now());
    fechaH = formatWH.format(DateTime.now());

    getListas();

    //     _ticker = Ticker((_) {
    //   setState(() {
    //     final duration = widget.stopw.elapsed;
    //     final minutos = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    //     final segundos = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    //     tiempoFormateado = "$minutos:$segundos";
    //   });
    // })..start();
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirmExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Quieres salir del Registro Daño?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); 
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Sí')
              )
            ]
          )
        );
        
        return confirmExit;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
          title: const Text(
            'Registrar Daño',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
          )
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Cuerpo(),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const Text(
                          'VIN: ',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          widget.vin,
                          style: const TextStyle(
                            fontSize: 17
                          )
                        )
                      ]
                    ),
                    // Row(
                    //   children: [
                    //     const Text(
                    //       'Panel Seleccionado: ',
                    //       style: TextStyle(
                    //         fontSize: 17,
                    //         fontWeight: FontWeight.bold
                    //       )
                    //     ),
                    //     Text(
                    //       widget.panel,
                    //       style: const TextStyle(
                    //         fontSize: 17
                    //       )
                    //     )
                    //   ]
                    // ),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _titulo('* Area:'),
                          // Autocomplete<String>(
                          //   optionsBuilder: (TextEditingValue textEditingValue) {
                          //     if(textEditingValue.text == '') {
                          //       return const Iterable<String>.empty();
                          //     }   
                          //     print(listaAreaDanos.map((item) => item.texto).where((option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase())));
                          //     return listaAreaDanos.map((item) => item.texto).where((option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          //   },
                          //   onSelected: (String selection) {
                          //     debugPrint('You just selected $selection');
                          //   }
                          // ),



                        //  Autocomplete<String>(
                        //     optionsBuilder: (TextEditingValue textEditingValue) {
                        //       if (textEditingValue.text == '') {
                        //         return const Iterable<String>.empty();
                        //       }
                        //       return listaAreaDanos.where(( option) {
                        //         return option.contains(textEditingValue.text.toLowerCase());
                        //       });
                        //     },
                        //     onSelected: (String selection) {
                        //       debugPrint('You just selected $selection');
                        //     },
                        //   ),
                          // _dropDownArea(),
 

                          // _autoCompleteArea(),
                          TextFormField(
                            controller: _areaTextController,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return 'Favor de llenar el Area';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Escriba el Area',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              )
                            )
                          ),


                          // _dropDownArea(),
                          // TextFormField(
                          //   controller: _areaTextController,
                          //   keyboardType: TextInputType.number,
                          //   validator: (value) {
                          //     if(value == null || value.isEmpty) {
                          //       return 'Favor de llenar el Area';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: const InputDecoration(
                          //     hintText: 'Escriba el Area',
                          //     hintStyle: TextStyle(
                          //       color: Colors.grey
                          //     )
                          //   )
                          // ),
                          const SizedBox(height: 10),


                          _titulo('* Tipo:'),
                          // Autocomplete<String>(
                          //   optionsBuilder: (TextEditingValue textEditingValue) {
                          //     if (textEditingValue.text == '') {
                          //     return const Iterable<String>.empty();
                          //     }
                          //     return listaTipoDanos.map((item) => item.texto).where((option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          //   },
                          //   onSelected: (String selection) {
                          //     debugPrint('You just selected $selection');
                          //   }
                          // ),
                          // TextFormField(
                          //   controller: _tipoTextController,
                          //   keyboardType: TextInputType.number,
                          //   validator: (value) {
                          //     if(value == null || value.isEmpty) {
                          //       return 'Favor de llenar el Tipo';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: const InputDecoration(
                          //     hintText: 'Escriba el Tipo',
                          //     hintStyle: TextStyle(
                          //       color: Colors.grey
                          //     )
                          //   )
                          // ),

                          // _autoCompleteTipo(),


                                       TextFormField(
                            controller: _tipoTextController,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return 'Favor de llenar el Tipo';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Escriba el Tipo',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              )
                            )
                          ),

                          const SizedBox(height: 10),


                          _titulo('* Severidad:'),
                          // Autocomplete<String>(
                          //   optionsBuilder: (TextEditingValue textEditingValue) {
                          //     if (textEditingValue.text == '') {
                          //     return const Iterable<String>.empty();
                          //     }
                          //     return listaSeveridad.map((item) => item.texto).where((option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          //   },
                          //   onSelected: (String selection) {
                          //     debugPrint('You just selected $selection');
                          //   }
                          // ),
                          // TextFormField(
                          //   controller: _severidadTextController,
                          //   keyboardType: TextInputType.number,
                          //   validator: (value) {
                          //     if(value == null || value.isEmpty) {
                          //       return 'Favor de llenar la Severidad';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: const InputDecoration(
                          //     hintText: 'Escriba la Severidad',
                          //     hintStyle: TextStyle(
                          //       color: Colors.grey
                          //     )
                          //   )
                          // )
                      // _autoCompleteSeveridad()

                                   TextFormField(
                            controller: _severidadTextController,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return 'Favor de llenar el Severidad';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Escriba el Severidad',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              )
                            )
                          ),

                        ]
                      )
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => getCamara(1),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/img/camara.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                        const Text(
                                          '1m de Distancia',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          )
                                        )
                                      ]
                                    ),
                                    base64Foto1 != null ? const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                      size: 60
                                    ) : const SizedBox()
                                  ]
                                )
                              ),
                              GestureDetector(
                                onTap: () => getCamara(2),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/img/camara.png',
                                          width: 40,
                                          height: 40
                                        ),
                                        const Text(
                                          '15 cm de Distancia',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          )
                                        )
                                      ]
                                    ),
                                    base64Foto2 != null ? const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                      size: 60
                                    ) : const SizedBox()
                                  ]
                                )
                              ),
                              GestureDetector(
                                onTap: () => getCamara(3),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/img/camara.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                          const Column(
                                            children: [
                                              Text(
                                                '45 Grados Izq.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                                )
                                              ),
                                              Text(
                                                '(Opcional)',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red
                                                )
                                              )
                                          ]
                                        )
                                      ]
                                    ),
                                    base64Foto3 != null ? const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                      size: 60
                                    ) : const SizedBox()
                                  ]
                                )
                              ),
                              GestureDetector(
                                onTap: () => getCamara(4),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/img/camara.png',
                                          width: 40,
                                          height: 40
                                        ),
                                        const Column(
                                          children: [
                                             Text(
                                              '45 Grados Der.',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              )
                                            ),
                                            Text(
                                                '(Opcional)',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red
                                                )
                                              )
                                          ]
                                        )
                                      ]
                                    ),
                                    base64Foto4 != null ? const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                      size: 60
                                    ) : const SizedBox()
                                  ]
                                )
                              )
                            ]
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _notasTextController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              hintText: 'Notas',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              )
                            )
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async => await guardarDano('OtroDano'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                              minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                )
                              )
                            ),
                            child: const Text(
                              'Registrar Otro Daño',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white
                              )
                            )
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async => guardarDano('Finalizar'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(18.0)),
                              minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                )
                              ),
                            ),
                            child: const Text(
                              'Finalizar',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white
                              )
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              ),
              const SizedBox(height: 20)
            ]
          ) 
        )
      )
    );
  }

  // Future<List<ListasA>> getListas() async {
  //   List<ListasA> resultados = [];
  //   try {
  //     await DatabaseProvider.db.obtenerAreaDano().then((value) {
  //       setState(() {
  //         listaAreaDanos = value.map((item) => ListasA(valor: item.codigo.toString(), texto: '${item.codigo} : ${item.descripcion}')).toList();
  //       });
  //     });
  //     await DatabaseProvider.db.obtenerTipoDano().then((value) {
  //       setState(() {
  //         listaTipoDanos = value.map((item) => ListasT(valor: item.id.toString(), texto: '${item.id} : ${item.descripcion}')).toList();
  //       });
  //     });
  //     await DatabaseProvider.db.obtenerSeveridad().then((value) {
  //       setState(() {
  //         listaSeveridad = value.map((item) => ListasS(valor: item.id.toString(), texto: '${item.id} : ${item.tipo}')).toList();
  //       });
  //     });
  //   } 
  //   catch (e) {
  //     log('error => $e');
  //   }
  //   return resultados;
  // }


  Future<List<ListasA>> getListas() async {
    List<ListasA> resultados = [];
    List<String> result = [];
    List<String> result1 = [];
    List<String> result2 = [];
    
    try {
      await DatabaseProvider.db.obtenerAreaDano().then((value) {
        setState(() {

          for(var i = 0; i < value.length; i++) {
            result.add('${value[i].codigo.toString()}-${value[i].descripcion.toString()}');
          }

          listaA = result;

          log(listaA.toString());
        });
      });

      await DatabaseProvider.db.obtenerTipoDano().then((value) {
        setState(() {

          for(var i = 0; i < value.length; i++) {
            result1.add('${value[i].id.toString()}-${value[i].descripcion.toString()}');
          }

          listaT = result1;
        });
      });

      await DatabaseProvider.db.obtenerSeveridad().then((value) {
        setState(() {

          for(var i = 0; i < value.length; i++) {
            result2.add('${value[i].id.toString()}-${value[i].descripcion.toString()}');
          }

          listaS = result2;
        });
      });
    } 
    catch (e) {
      log('error => $e');
    }

    return resultados;
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
            )
          )
        )
      ]
    );
  }

  Widget _dropDownArea() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasA>(
          items: listaAreaDanos,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecciona"
          )
        ),
        onChanged: (ListasA? item) {
          setState(() {
            selectArea = (item?.valor);
          });
        },
        itemAsString: (ListasA item) => item.texto,
      )
    );
  }

  Widget _dropDownTipo() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          // border: Border.all(
          //   color: Colors.grey[200]!
          // )
      ),
      child: DropdownSearch<ListasT>(
          items: listaTipoDanos,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecciona"
          ),
        ),
        onChanged: (ListasT? item) {
          setState(() {
            selectTipo = (item?.valor);
          });
        },
        itemAsString: (ListasT item) => item.texto,
      )

    );
  }

  Widget _dropDownSeveridad() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownSearch<ListasS>(
          items: listaSeveridad,
          dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecciona"
          ),
        ),
        onChanged: (ListasS? item) {
          setState(() {
            selectSeve = (item?.valor);
          });
        },
        itemAsString: (ListasS item) => item.texto,
      )
    );
  }










  Widget _autoCompleteArea() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          _searchingWithQuery = textEditingValue.text.toLowerCase();
          return listaA.where((String option) => option.toLowerCase().contains(_searchingWithQuery!));
        },
        onSelected: (String selection) {
          setState(() {
            _areaTextController.text = selection;
          });
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: '* Ingrese Area',
              hintText: 'Seleccione Area',
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Favor de llenar el Area';
              }
              return null;
            }
          );
        }
      )
    );
  }

  Widget _autoCompleteTipo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          _searchingWithQuery = textEditingValue.text.toLowerCase();
          return listaT.where((String option) => option.toLowerCase().contains(_searchingWithQuery!));
        },
        onSelected: (String selection) {
          setState(() {
            _tipoTextController.text = selection;
          });
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: '* Ingrese Tipo',
              hintText: 'Seleccione Tipo',
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Favor de llenar el Tipo';
              }
              return null;
            }
          );
        }
      )
    );
  }

  Widget _autoCompleteSeveridad() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          _searchingWithQuery = textEditingValue.text.toLowerCase();
          return listaS.where((String option) => option.toLowerCase().contains(_searchingWithQuery!));
        },
        onSelected: (String selection) {
          setState(() {
            _severidadTextController.text = selection;
          });
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: '* Ingrese Severidad',
              hintText: 'Seleccione Severidad',
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Favor de llenar la Severidad';
              }
              return null;
            }
          );
        }
      )
    );
  }








  guardarDano(tipo) async {
    if(_formKey.currentState!.validate()) {
      // if(evidenciasDano.length >= 2) {

        // var _area = _areaTextController.text.split('-')[0];
        // var _tipo = _tipoTextController.text.split('-')[0];
        // var _severidad = _severidadTextController.text.split('-')[0];

        dano = Dano(
          vin: widget.vin,
          panel: 'Compra',
          registroTipo: 'Regular',
          // area: int.parse(selectArea.toString()),
          // tipo: int.parse(selectTipo.toString()),
          // severidad: selectSeve.toString(),
          area: int.parse(_areaTextController.text.trim()),
          tipo: int.parse(_tipoTextController.text.trim()),
          severidad: _severidadTextController.text.trim(),
          // area: int.parse(_areaTextController.text.trim()),
          // tipo: int.parse(_tipoTextController.text.trim()),
          // severidad: _severidadTextController.text.trim(),
          // area: int.parse(_area),
          // tipo: int.parse(_tipo),
          // severidad: _severidad,
          notas: _notasTextController.text,
          estado: 'A',
          fecha_creacion: fecha
        );

        await DatabaseProvider.db.insertarDano(dano!).then((value) async {
          itemP.addBoton();
          itemP.deleteBoton();
          
          for(var ed in evidenciasDano) {
            evidencia = Evidencia(
              vin: widget.vin,
              iddano: value,
              nombre: null,
              archivo: ed,
              fechahora: fechaH
            );

            await DatabaseProvider.db.insertarEvidencia(evidencia!).then((value) {
            }).timeout(const Duration(seconds: 60), onTimeout: () {
              itemP.addError();
            });
          }       


                Fluttertoast.showToast(
              msg: "Guardado con Exito!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 20
            );                   
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          itemP.addError();
        });

        if(tipo == 'OtroDano') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistroDano(vin: widget.vin))
          );
        }
        else {
          var datos = await DatabaseProvider.db.obtenerInfoVin(widget.vin);
          setState(() {
            resumen = datos;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) => ResumenDano(resu: resumen)), (Route<dynamic> route) => false);
        }
      // }
      // else {
      //   Fluttertoast.showToast(
      //     msg: "Tome las 2 fotografia",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 20
      //   );
      // }
    }
    else {
      Fluttertoast.showToast(
        msg: "Seleccione codificacion de Daño",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20
      );
    }
  }
}