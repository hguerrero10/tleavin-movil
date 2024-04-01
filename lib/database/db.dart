import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tleavin_mobil/model/dispositivo.dart';

class DatabaseProvider {

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tleavin.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE usuario (numero_empleado INTEGER PRIMARY KEY UNIQUE, nombre VARCHAR, usuario VARCHAR, password VARCHAR, isLogged INTERGER, cargo VARCHAR, estado VARCHAR)"
      );

      await db.execute(
        "CREATE TABLE vin (id INTEGER PRIMARY KEY AUTOINCREMENT, viaje INTEGER, cartaporte INTEGER, vin VARCHAR UNIQUE, distrib_clave VARCHAR, dest_nombre VARCHAR, ruta_clave INTEGER, ruta_nombre VARCHAR, origen VARCHAR, destino VARCHAR, modelo VARCHAR, marca VARCHAR, posicion VARCHAR, orientacion VARCHAR, compra INTEGER, fecha_carga DATE, fecha_creacion DATE, fecha_sync DATE)"
      );

      await db.execute(
        "CREATE TABLE dano (id INTEGER PRIMARY KEY AUTOINCREMENT, vin VARCHAR, panel VARCHAR, area INTERGER, tipo INTERGER, severidad INTERGER, nota VARCHAR, fecha_creacion DATE)"
      );

      await db.execute(
        "CREATE TABLE evidencia (id INTEGER PRIMARY KEY AUTOINCREMENT, vin VARCHAR, dano VARCHAR, nombre VARCHAR, archivo TEXT, fechahora DATE)"
      );

      await db.execute(
        "CREATE TABLE dispositivo (id INTEGER PRIMARY KEY AUTOINCREMENT, descripcion VARCHAR, api_key VARCHAR, usuario INTEGER, notas VARCHAR)"
      );
    });
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

  Future<List<Usuario>>obtenerUsuarios() async {
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
    return db.update('vin',  vin.toMap() , where: "id = ?" , whereArgs: [vin.id], );
  }

  Future<List<Vin>>obtenerListaVins() async {
    final db = await database;
    List<Vin> listaVins;
    var res = await db.query("vin");
    log(res.toString());

    if (res.isNotEmpty) {
      listaVins =  res.map((v) => Vin.fromMap(v)).toList();
    } 
    else {
      listaVins = [];
    }
    return listaVins;
  }

  Future<List>obtenerInfoVin(vin) async {
    final db = await database;
    List vins = [];

    var res = await db.query("vin WHERE vin = '$vin'");
    var res2 = await db.query("dano WHERE vin = '$vin'");
    var res3 = await db.query("evidencia WHERE vin = '$vin'");

    if (res.isNotEmpty) {
      vins.addAll(res);
    }

    if (res2.isNotEmpty) {
      vins.addAll(res2);
    }

    if (res3.isNotEmpty) {
      vins.addAll(res3);
    }

    if(vins.isEmpty) {
      vins = [];
    }

    return vins;
  }

  Future<List>obtenerTipoVin() async {
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

  Future<List>checarVinExistente(chVin) async {
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
    return db.update('dano',  dano.toMap() , where: "id = ?" , whereArgs: [dano.id], );
  }

  Future<List<Dano>>obtenerDano() async {
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
    return db.update('evidencia',  evidencia.toMap() , where: "id = ?" , whereArgs: [evidencia.id], );
  }

  Future<List<Evidencia>>obtenerEvidencia() async {
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

  Future<List<Dispositivo>>obtenerDispositivos() async {
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
}