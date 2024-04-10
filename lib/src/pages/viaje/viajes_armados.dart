import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tleavin_mobil/database/db.dart';

class ViajesArmados extends StatefulWidget {
  const ViajesArmados({super.key});

  @override
  State<ViajesArmados> createState() => _ViajesArmadosState();
}

class _ViajesArmadosState extends State<ViajesArmados> {
  
  var listaViajes = [];

  obtenerViajes() async {
    var data = await DatabaseProvider.db.obtenerViajes();

    log(data.toString());

    setState(() {
      listaViajes = data;
    });
  }

  obtenerViaje(infviaje) {
    
  }

  @override
  void initState() {
    obtenerViajes();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(242, 211, 0, 1),
        title: const Text(
          'Viajes Armados',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        )
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: [

                Expanded(child: viajes(listaViajes))
              ]
            )
          )
        ]
      )
    );
  }

  Widget viajes(via) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: via.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dato = via[index];
        var totalda = index + 1;
        return via.length > 0 ? GestureDetector(
          onTap: () async => await obtenerViaje('${via[index].idviaje}'),
          child: Container(
            height: 170,
            width: double.maxFinite,
            margin: const EdgeInsets.only(left: 16, right:16, top: 16, bottom: 16),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/img/carddi.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Card(
              color: const Color.fromARGB(0, 0, 0, 1),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${via[index].idviaje}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                    Text(
                      '${via[index].num_eco_unidad}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                    Text(
                      '${via[index].nombre_operador}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      )
                    )
                  ]
                )
              )
            )
          )
        ): Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.doc_fill , 
              color: Colors.grey[300], 
              size: 60
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: Text(
                'No hay vins disponibles',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 19
                )
              )
            )
          ]
        )
      );
      }
    );
  }
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Flexible(
                  //         child: Text(
                  //           '${via[index].idviaje}',
                  //           textAlign: TextAlign.center,
                  //           style: const TextStyle(
                  //             fontSize: 13,
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold
                  //           )
                  //         )
                  //       )
                  //     ]
                  //   )
                  // )
//                 ]
//               )
//             );
//           }
//         )
//       ) : Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               CupertinoIcons.doc_fill , 
//               color: Colors.grey[300], 
//               size: 60
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: 250,
//               child: Text(
//                 'No hay vins disponibles',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.grey[300],
//                   fontSize: 19
//                 )
//               )
//             )
//           ]
//         )
//       );
//     } 
//     else {
//       return const Center(
//         child: CircularProgressIndicator(
//           color: Color.fromRGBO(242, 211, 0, 1)
//         )
//       );
//     }
//   }
}