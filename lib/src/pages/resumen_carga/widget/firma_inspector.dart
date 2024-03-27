import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class FirmaInspectorWidget extends StatefulWidget {
  const FirmaInspectorWidget({ Key? key }) : super(key: key);

  @override
  State<FirmaInspectorWidget> createState() => _FirmaInspectorWidgetState();
}

class _FirmaInspectorWidgetState extends State<FirmaInspectorWidget> {

  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  
  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Firma de conformidad'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.delete_solid), 
            onPressed: () {
              _signaturePadKey.currentState!.clear();
              setState(() {
                // formatoBloc.firmaSeguridadDelete();
              });
            }
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.check_mark_circled_solid), 
            onPressed: () async {
              await crearImagen();
              Navigator.pop(context);
            }
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1.1,
            child: SfSignaturePad(
              key: _signaturePadKey,
              strokeColor: Colors.black,
              minimumStrokeWidth: 2.0,
              maximumStrokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> crearImagen() async {
    ui.Image data = await _signaturePadKey.currentState!.toImage(pixelRatio: 2.0);
    final byteData = await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes = byteData!.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    // formatoBloc.firmaSeguridadAdd(base64Encode(imageBytes));
  }
}