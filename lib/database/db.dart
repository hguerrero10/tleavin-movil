import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/model/cliente.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/model/areaDano.dart';
import 'package:tleavin_mobil/model/severidad.dart';
import 'package:tleavin_mobil/model/tipo_dano.dart';
import 'package:tleavin_mobil/model/dispositivo.dart';

class DatabaseProvider {

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await iniciarDB();

    return _database!;
  }

  iniciarDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tleavin.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE usuario (numero_empleado INTEGER PRIMARY KEY UNIQUE, nombre VARCHAR, usuario VARCHAR, password VARCHAR, isLogged INTERGER, cargo VARCHAR, estado VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE vin (idv INTEGER PRIMARY KEY AUTOINCREMENT, viaje INTEGER, cartaporte INTEGER, vin VARCHAR UNIQUE, distrib_clave VARCHAR, dest_nombre VARCHAR, ruta_clave INTEGER, ruta_nombre VARCHAR, origen VARCHAR, destino VARCHAR, modelo VARCHAR, marca VARCHAR, posicion VARCHAR, orientacion VARCHAR, compra INTEGER, fecha_carga DATE, fecha_creacion DATE, fecha_sync DATE)"
        );

        await db.execute(
          "CREATE TABLE dano (idd INTEGER PRIMARY KEY AUTOINCREMENT, vin VARCHAR, panel VARCHAR, registroTipo VARCHAR, area INTERGER, tipo INTERGER, severidad INTERGER, nota VARCHAR, fecha_creacion DATE)"
        );

        await db.execute(
          "CREATE TABLE evidencia (ide INTEGER PRIMARY KEY AUTOINCREMENT, vin VARCHAR, iddano INTEGER, nombre VARCHAR, archivo TEXT, fechahora DATE)"
        );

        await db.execute(
          "CREATE TABLE dispositivo (id INTEGER PRIMARY KEY AUTOINCREMENT, descripcion VARCHAR, api_key VARCHAR, usuario INTEGER, notas VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE cliente (id INTEGER PRIMARY KEY AUTOINCREMENT, idAdvan INTEGER, cliente VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE area_dano (id INTEGER PRIMARY KEY AUTOINCREMENT, area VARCHAR, descripcion VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE tipo_dano (id INTEGER PRIMARY KEY AUTOINCREMENT, descripcion VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE severidad (id INTEGER PRIMARY KEY AUTOINCREMENT, tipo VARCHAR, descripcion VARCHAR)"
        );
      }
    );
  }

  // CRUD USUARIOS

  Future<Usuario> login(String user, String password) async {
    final db = await database;
    late Usuario usuario = Usuario();
    var res = await db.rawQuery("SELECT * FROM usuario WHERE usuario = '$user' and password = '$password' and estado = 'A'");

    if(res.isNotEmpty) {
      usuario = Usuario.fromMap(res.first);
    }

    return usuario;
  }

  Future<int> insertarUsuario(Usuario nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("usuario", nuevoRegistro.toMap());

    return res;
  }

  actualizarUsuario(Usuario usuario) async {
    final db = await database;
    return db.update('usuario',  usuario.toMap() , where: "numero_empleado = ?" , whereArgs: [usuario.numeroEmpleado]);
  }

  Future<List<Usuario>> obtenerUsuarios() async {
    final db = await database;
    List<Usuario> listaUsuarios;
    var res = await db.query("usuario");

    if (res.isNotEmpty) {
      listaUsuarios =  res.map((u) => Usuario.fromMap(u)).toList();
    } 
    else {
      listaUsuarios = [];
    }

    return listaUsuarios;
  }

  // CRUD VINS

  Future<int> insertarVin(Vin nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("vin", nuevoRegistro.toMap());

    return res;
  }

  actualizarVin(Vin vin) async {
    final db = await database;
    return db.update('vin',  vin.toMap() , where: "vin = ?" , whereArgs: [vin.vin] );
  }

  Future<List<Vin>> obtenerListaVins() async {
    final db = await database;
    List<Vin> listaVins;
    var res = await db.query("vin");

    if(res.isNotEmpty) {
      listaVins =  res.map((v) => Vin.fromMap(v)).toList();
    } 
    else {
      listaVins = [];
    }
    return listaVins;
  }

  Future<List> obtenerInfoVin(vin) async {
    Database db = await database;
    List<Map> data = await db.rawQuery("SELECT * FROM vin as v INNER JOIN dano as d ON v.vin = d.vin INNER JOIN evidencia as e on e.iddano = d.idd where v.vin = '$vin'");

    Map<String, dynamic> organizedData = {};

    if(data.isNotEmpty) {
      for(var item in data) {
        String vin = item['vin'];
        int iddano = item['iddano'];
        int ide = item['ide'];

        var evidence = {
          'ide': ide,
          'fechahora': item['fechahora'],
          'archivo': item['archivo']
        };

        if(organizedData.containsKey(vin)) {
          bool found = false;
          for(var dano in organizedData[vin]!['danoos']) {
            if(dano['iddano'] == iddano) {
              dano['evidencias'].add(evidence);
              found = true;
              break;
            }
          }

          if(!found) {
            var newDano = {
              'iddano': iddano,
              'panel': item['panel'],
              'registroTipo': item['registroTipo'],
              'area': item['area'],
              'tipo': item['tipo'],
              'severidad': item['severidad'],
              'nota': item['nota'],
              'fecha_creacion': item['fecha_creacion'],
              'evidencias': [evidence]
            };

            organizedData[vin]!['danoos'].add(newDano); 
          }
        } 
        else {
          var obvin = {
            "idv": item['idv'],
            'viaje': item['viaje'],
            'cartaporte': item['cartaporte'],
            'vin': vin,
            'distrib_clave': item['distrib_clave'],
            'dest_nombre': item['dest_nombre'],
            'ruta_clave': item['ruta_clave'],
            'ruta_nombre': item['ruta_nombre'],
            'origen': item['origen'],
            'destino': item['destino'],
            'modelo': item['modelo'],
            'marca': item['marca'],
            'posicion': item['posicion'],
            'orientacion': item['orientacion'],
            'compra': item['compra'],
            'fecha_carga': item['fecha_carga'],
            'fecha_creacion': item['fecha_creacion'],
            'fecha_sync': item['fecha_sync'],
            'danoos': [

            ]
          };

          organizedData[vin] = {'vinp': obvin, 'danoos': []};
        }
      }
    }

    // log(organizedData.values.toString());

    // var jsonObject = jsonDecode(jsonString);

    // log(organizedData.values.toString());

    // Map<String, dynamic> jsonData = jsonDecode(organizedData.values.toList().toString());

    // List<dynamic> danoos = jsonData['vinp']['danoos'];

    // List<dynamic> danoosList = [];

    // for (var dano in danoos) {
    //   danoosList.add(dano);
    // }

    // log(danoosList.toString());

    


    return organizedData.values.toList();
  }














  // Future<List> obtenerInfoVin(vin) async {
  //   final db = await database;
  //   var data = [];
  //   var data2 = [];
  //   var data3 = [];
  //   var infov = [];
  //   var res = await db.query("vin WHERE vin = '$vin'");
  //   var res2 = await db.query("dano WHERE vin = '$vin'");
  //   // var res3 = await db.query("evidencia WHERE dano = 1");
  //   if(res.isNotEmpty) {
  //     data = ([{"vi": res}]);
  //     infov.add(data);
  //     // log(data.toString());
  //   }
  //   if(res2.isNotEmpty) {
  //     for (var item in res2) {
  //       data2.add({"da": item});
  //     }
  //     infov.add(data2);
  //     // log(data2.toString());
  //   }
  //   // if(res3.isNotEmpty) {
  //   //   for (var item in res3) {
  //   //     data3.add({"evvvvvvv": item});
  //   //   }
  //   //   infov.add(data3);
  //   //   // log(data3.toString());
  //   // }
  //   if(infov.isEmpty) {
  //     infov = [];
  //   }
  //   // log(infov.toString());
  //   return infov;
  // }

  Future<List> obtenerTipoVin() async {
    final db = await database;
    List vins = [];
    var res = await db.query("vin");

    if (res.isNotEmpty) {
      vins.addAll(res);
    }

    if(vins.isEmpty) {
      vins = [];
    }

    return vins;
  }

  Future<List> checarVinExistente(chVin) async {
    final db = await database;
    List vins = [];
    var res = await db.query("vin where vin = '$chVin'");

    if (res.isNotEmpty) {
      vins.addAll(res);
    }

    if(vins.isEmpty) {
      vins = [];
    }

    return vins;
  }

  // CRUD DAÑO 

  Future<int> insertarDano(Dano nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("dano", nuevoRegistro.toMap());

    return res;
  }

  actualizarDano(Dano dano) async {
    final db = await database;
    return db.update('dano',  dano.toMap() , where: "idd = ?" , whereArgs: [dano.idd], );
  }

  Future<List<Dano>> obtenerDano() async {
    final db = await database;
    List<Dano> listaDanos;
    var res = await db.query("dano");

    if (res.isNotEmpty) {
      listaDanos =  res.map((d) => Dano.fromMap(d)).toList();
    } 
    else {
      listaDanos = [];
    }
    return listaDanos;
  }

  // CRUD EVIDENCIA

  Future<int> insertarEvidencia(Evidencia nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("evidencia", nuevoRegistro.toMap());

    return res;
  }

  actualizarEvidencia(Evidencia evidencia) async {
  final db = await database;
  return db.update('evidencia',  evidencia.toMap() , where: "ide = ?" , whereArgs: [evidencia.ide], );
}

  Future<List<Evidencia>> obtenerEvidencia() async {
    final db = await database;
    List<Evidencia> listaEvidencia;
    var res = await db.query("evidencia");

    if (res.isNotEmpty) {
      listaEvidencia =  res.map((c) => Evidencia.fromMap(c)).toList();
    } 
    else {
      listaEvidencia = [];
    }
    return listaEvidencia;
  }
  
  // CRUD DISPOSITIVOS
  
  Future<int> insertarDispositivo(Dispositivo nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("dispositivo", nuevoRegistro.toMap());
    return res;
  }

  actualizarDispositivo(Dispositivo dispositivo) async {
    final db = await database;
    return db.update('dispositivo',  dispositivo.toMap() , where: "id = ?" , whereArgs: [dispositivo.id], );
  }

  Future<List<Dispositivo>> obtenerDispositivos() async {
    final db = await database;
    List<Dispositivo> listDispositivo;
    var res = await db.query("dispositivo");

    if (res.isNotEmpty) {
      listDispositivo =  res.map((c) => Dispositivo.fromMap(c)).toList();
    } 
    else {
      listDispositivo = [];
    }
    return listDispositivo;
  }

  // CRUD AREA / TIPO DANO / SEVERIDAD / CLIENTE

  Future<List<Cliente>> obtenerCliente() async {
    final db = await database;
    List<Cliente> lista;
    var res = await db.query("cliente");

    if (res.isNotEmpty) {
      lista =  res.map((u) => Cliente.fromMap(u)).toList();
    } 
    else {
      lista = [];
    }
    return lista;
  }

  Future<int> insertarCliente(Cliente nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("cliente", nuevoRegistro.toMap());

    return res;
  }

  Future<List<AreaDano>> obtenerAreaDano() async {
      final db = await database;
      List<AreaDano> lista;
      var res = await db.query("area_dano");

      if (res.isNotEmpty) {
        lista =  res.map((u) => AreaDano.fromMap(u)).toList();
      } 
      else {
        lista = [];
      }
      return lista;
    }

  Future<int> insertarAreaDano(AreaDano nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("area_dano", nuevoRegistro.toMap());

    return res;
  }

  Future<List<TipoDano>> obtenerTipoDano() async {
    final db = await database;
    List<TipoDano> lista;
    var res = await db.query("tipo_dano");

    if (res.isNotEmpty) {
      lista =  res.map((u) => TipoDano.fromMap(u)).toList();
    } 
    else {
      lista = [];
    }
    return lista;
  }

  Future<int> insertarTipoDano(TipoDano nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("tipo_dano", nuevoRegistro.toMap());

    return res;
  }

  Future<List<Severidad>> obtenerSeveridad() async {
    final db = await database;
    List<Severidad> lista;
    var res = await db.query("severidad");

    if (res.isNotEmpty) {
      lista =  res.map((u) => Severidad.fromMap(u)).toList();
    } 
    else {
      lista = [];
    }
    return lista;
  }

  Future<int> insertarSeveridad(Severidad nuevoRegistro) async {
      var db = await database;
      int res = await db.insert("severidad", nuevoRegistro.toMap());

      return res;
    }
}