import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tleavin_mobil/model/vin.dart';
import 'package:tleavin_mobil/model/dano.dart';
import 'package:tleavin_mobil/model/viaje.dart';
import 'package:tleavin_mobil/model/usuario.dart';
import 'package:tleavin_mobil/model/cliente.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tleavin_mobil/model/areaDano.dart';
import 'package:tleavin_mobil/model/severidad.dart';
import 'package:tleavin_mobil/model/tipo_dano.dart';
import 'package:tleavin_mobil/model/evidencia.dart';
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
          "CREATE TABLE usuario (numero_empleado INTEGER PRIMARY KEY UNIQUE, nombre VARCHAR, usuario VARCHAR, password VARCHAR, isLogged INTERGER, cargo VARCHAR, locacion VARCHAR, estado VARCHAR)"
        );



        await db.execute(
          "CREATE TABLE vin (idv INTEGER PRIMARY KEY AUTOINCREMENT, idviaje INTEGER, cartaporte INTEGER, vin VARCHAR UNIQUE, distrib_clave VARCHAR, dest_nombre VARCHAR, ruta_clave INTEGER, ruta_nombre VARCHAR, origen VARCHAR, destino VARCHAR, modelo VARCHAR, marca VARCHAR, posicion VARCHAR, orientacion VARCHAR, compra INTEGER, fecha_carga DATE, fecha_creacion DATE, fecha_sync DATE)"
        );

        await db.execute(
          "CREATE TABLE dano (idd INTEGER PRIMARY KEY AUTOINCREMENT, vin VARCHAR, panel VARCHAR, registroTipo VARCHAR, area INTERGER, tipo INTERGER, severidad VARCHAR, nota VARCHAR, estado VARCHAR, fecha_creacion DATE)"
        );

        await db.execute(
          "CREATE TABLE evidencia (ide INTEGER PRIMARY KEY AUTOINCREMENT, vin VARCHAR, iddano INTEGER, idviaje INTEGER, nombre VARCHAR, archivo TEXT, fechahora DATE)"
        );



        await db.execute(
          "CREATE TABLE dispositivo (id INTEGER PRIMARY KEY AUTOINCREMENT, descripcion VARCHAR, api_key VARCHAR, usuario INTEGER, notas VARCHAR)"
        );



        await db.execute(
          "CREATE TABLE cliente (idAdvan INTEGER PRIMARY KEY, cliente VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE area_dano (id INTEGER PRIMARY KEY AUTOINCREMENT, codigo INTEGER, area VARCHAR, descripcion VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE tipo_dano (id INTEGER PRIMARY KEY AUTOINCREMENT, descripcion VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE severidad (id INTEGER PRIMARY KEY AUTOINCREMENT, tipo VARCHAR, descripcion VARCHAR)"
        );

        await db.execute(
          "CREATE TABLE viaje (idviaje INTEGER PRIMARY KEY AUTOINCREMENT, supervisor VARCHAR, folio_bitacora INTEGER, cartaporte INTEGER, bitacora_fecha_carga VARCHAR, num_eco_unidad VARCHAR, nombre_operador VARCHAR, cliente_clave INTEGER, cliente_nombre VARCHAR, ruta_clave INTEGER, ruta_nombre VARCHAR, origen VARCHAR, destino VARCHAR, etiqueta VARCHAR, status_carga INTEGER, notas VARCHAR, registrada_por VARCHAR, tipo_viaje VARCHAR, semana INTEGER, estadoViaje VARCHAR, fecha_creacion VARCHAR, fecha_sync VARCHAR)"
        );
      }
    );
  }

  // PRUEBAS
  
  Future paraPruebas() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM evidencia WHERE ide = 1");

    for(var i in result) {
      Evidencia vi = Evidencia.fromMap(i);

      var arc = vi.archivo?.trim();
      var edn = arc?.replaceAll("\\s{2,}", "");
       
      log(edn.toString());
    }
    return result;
  }

  // CRUD USUARIOS

  Future<Usuario> login(String user, String password) async {
    final db = await database;
    late Usuario usuario = Usuario();
    var res = await db.rawQuery("SELECT * FROM usuario WHERE usuario = '$user' AND password = '$password' AND estado = 'A'");

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

  Future borrarBDUsuarios() async {
    final db = await database;
    return db.delete('usuario');
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

  Future<List<Vin>> obtenerListaVinsComprados() async {
    final db = await database;
    List<Vin> listaVins;
    var res = await db.rawQuery("SELECT * FROM vin WHERE compra = 1 AND idviaje ISNULL");

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
    List<Map> dataD = await db.rawQuery("SELECT * FROM dano WHERE vin = '$vin'");
    Map<String, dynamic> organizedData = {};

    if(dataD.isEmpty) {
      List<Map> data = await db.rawQuery("SELECT * FROM vin WHERE vin = '$vin'");
        if(data.isNotEmpty) {
        for(var item in data) {
          String vin = item['vin'] ?? '';
          int iddano = item['iddano'] ?? 0;
          int ide = item['ide'] ?? 0;

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

              if(item['estado'] == 'A'){
                var newDano = {
                  'iddano': iddano,
                  'vin': vin,
                  'panel': item['panel'],
                  'registroTipo': item['registroTipo'],
                  'area': item['area'],
                  'tipo': item['tipo'],
                  'severidad': item['severidad'],
                  'nota': item['nota'],
                  'estado': item['estado'],
                  'fecha_creacion': item['fecha_creacion'],
                  'evidencias': [evidence]
                };

                organizedData[vin]!['danoos'].add(newDano); 
              }
            }
          } 
          else {
            var obvin = {
              "idv": item['idv'],
              'idviaje': item['idviaje'],
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
    }
    else {
      List<Map> data = await db.rawQuery("SELECT * FROM vin AS vi INNER JOIN dano AS da ON vi.vin = da.vin INNER JOIN evidencia AS evi ON evi.iddano = da.idd WHERE vi.vin = '$vin'");

      if(data.isNotEmpty) {
        for(var item in data) {
          String vin = item['vin'] ?? '';
          int iddano = item['iddano'] ?? 0;
          int ide = item['ide'] ?? 0;

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
                if(item['estado'] == 'A'){
                var newDano = {
                  'iddano': iddano,
                  'vin': vin,
                  'panel': item['panel'],
                  'registroTipo': item['registroTipo'],
                  'area': item['area'],
                  'tipo': item['tipo'],
                  'severidad': item['severidad'],
                  'nota': item['nota'],
                  'estado': item['estado'],
                  'fecha_creacion': item['fecha_creacion'],
                  'evidencias': [evidence]
                };

                organizedData[vin]!['danoos'].add(newDano); 
              }
            }
          } 
          else {
            var obvin = {
              "idv": item['idv'],
              'idviaje': item['idviaje'],
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
    }

    return organizedData.values.toList();
  }

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

  Future<List> checarVinParaViaje(vinViaje) async {
    final db = await database;
    List vins = [];
    var res = await db.query("vin WHERE vin = '$vinViaje' AND compra = 1");

    if(res.isNotEmpty) {
      vins.addAll(res);
    }

    if(vins.isEmpty) {
      vins = [];
    }

    return vins;
  }

  Future vinesTotales() async {
    Database db = await database;
    List<Map> dataD = await db.rawQuery("SELECT compra, COUNT(*) as Total FROM vin GROUP BY compra");
  
    var jsonString  = jsonEncode(dataD);
      
    return jsonString;
  }

  asignarVinViaje(vv) async {
    final db = await database;
    return db.update('vin', {'idviaje' : vv.idviaje, 'origen' : vv.origen, 'destino' : vv.destino}, where: "vin = ?", whereArgs: [vv.vin]);
  }
  
  asignarPoOrVIN(vv) async {
    final db = await database;

    return db.update('vin', {'posicion' : vv.posicion, 'orientacion' : vv.orientacion}, where: "vin = ?", whereArgs: [vv.vin]);
  }

  compraVINRegistrado(vin) async { // para comprar el vin en detalle vin
    final db = await database;
    return db.update('vin', {'compra' : 1}, where: "vin = ?", whereArgs: [vin]);
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

  quitarDanoVIN(idd) async {
    final db = await database;

    return db.update('dano', {'estado': 'I'}, where: "idd = ?", whereArgs: [idd]);
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
  
  Future<List> verEvidenciaDeViaje(idvi) async {
    final db = await database;
    List eviden = [];
    var res = await db.query("evidencia where idviaje = '$idvi'");

    if (res.isNotEmpty) {
      eviden.addAll(res);
    }

    if(eviden.isEmpty) {
      eviden = [];
    }

    return eviden;
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
    var res = await db.rawQuery("SELECT * FROM area_dano ORDER BY codigo ASC");

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

  Future borrarBDAreaDano() async {
    final db = await database;
    return db.delete('area_dano');
  }

  Future borrarBDTipoDano() async {
    final db = await database;
    return db.delete('tipo_dano');
  }

  Future borrarBDSeveridad() async {
    final db = await database;
    return db.delete('severidad');
  }

  Future borrarBDCliente() async {
    final db = await database;
    return db.delete('cliente');
  }

  // CRUD VIAJES

  Future<List<Viaje>> obtenerViajes() async {
    List<Viaje> lista;
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM viaje WHERE estadoviaje = 'En Proceso'");
    // var res = await db.rawQuery("SELECT * FROM viaje");

    if(res.isNotEmpty) {
      lista = res.map((u) => Viaje.fromMap(u)).toList();
    } 
    else {
      lista = [];
    }

    return lista;
  }

  Future<List<Viaje>> obtenerViajesParaSincronizar() async {
    List<Viaje> lista;
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM viaje WHERE estadoviaje = 'Completo'");
    // var res = await db.rawQuery("SELECT * FROM viaje");

    if(res.isNotEmpty) {
      lista = res.map((u) => Viaje.fromMap(u)).toList();
    } 
    else {
      lista = [];
    }

    return lista;
  }

  Future<int> insertarViaje(Viaje nuevoRegistro) async {
    var db = await database;
    int res = await db.insert("viaje", nuevoRegistro.toMap());

    return res;
  }

  Future<List> obtenerInfoViaje(idvia) async {
    Database db = await database;

    List<Map> data = await db.rawQuery("SELECT via.idviaje, via.supervisor, via.folio_bitacora, via.cartaporte, via.bitacora_fecha_carga, via.num_eco_unidad, via.nombre_operador, via.cliente_clave, via.cliente_nombre, via.ruta_clave, via.ruta_nombre, via.origen, via.destino, via.etiqueta, via.status_carga, via.notas, via.registrada_por, via.tipo_viaje, via.semana, via.estadoViaje, via.fecha_creacion, via.fecha_sync, vi.idv, vi.idviaje, vi.cartaporte, vi.vin, vi.distrib_clave, vi.dest_nombre, vi.ruta_clave, vi.ruta_nombre, vi.origen, vi.destino, vi.modelo, vi.marca, vi.posicion, vi.orientacion, vi.compra, vi.fecha_carga, vi.fecha_creacion, vi.fecha_sync FROM viaje AS via INNER JOIN vin AS vi on vi.idviaje = via.idviaje WHERE via.idviaje = $idvia");
    Map<String, dynamic> viajesAgrupados = {};
    Map<String, dynamic> viajesAgrupadosfafg = {};
    if(data.isNotEmpty) {
      for (var viaje in data) {
        final idViaje = viaje['idviaje'];

        var obviaje = {
          'idviaje': viaje['idviaje'],
          'supervisor': viaje['supervisor'],
          'folio_bitacora': viaje['folio_bitacora'],
          'cartaporte': viaje['cartaporte'],
          'bitacora_fecha_carga': viaje['bitacora_fecha_carga'],
          'num_eco_unidad': viaje['num_eco_unidad'],
          'nombre_operador': viaje['nombre_operador'],
          'cliente_clave': viaje['cliente_clave'],
          'cliente_nombre': viaje['cliente_nombre'],
          'ruta_clave': viaje['ruta_clave'],
          'ruta_nombre': viaje['ruta_nombre'],
          'origen': viaje['origen'],
          'destino': viaje['destino'],
          'etiqueta': viaje['etiqueta'],
          'status_carga': viaje['status_carga'],
          'notas': viaje['notas'],
          'registrada_por': viaje['registrada_por'],
          'tipo_viaje': viaje['tipo_viaje'],
          'semana': viaje['semana'],
          'estadoViaje': viaje['estadoViaje'],
          'fecha_creacion': viaje['fecha_creacion'],
          'fecha_sync': viaje['fecha_sync'],
          'vins': []
        };

        var obvin = {
          'idv': viaje['idv'],
          'idviaje': viaje['idviaje'],
          'cartaporte': viaje['cartaporte'],
          'vin': viaje['vin'],
          'distrib_clave': viaje['distrib_clave'],
          'dest_nombre': viaje['dest_nombre'],
          'ruta_clave': viaje['ruta_clave'],
          'ruta_nombre': viaje['ruta_nombre'],
          'origen': viaje['origen'],
          'destino': viaje['destino'],
          'modelo': viaje['modelo'],
          'marca': viaje['marca'],
          'posicion': viaje['posicion'],
          'orientacion': viaje['orientacion'],
          'compra': viaje['compra'],
          'fecha_carga': viaje['fecha_carga'],
          'fecha_creacion': viaje['fecha_creacion'],
          'fecha_sync': viaje['fecha_sync']
        };

        viajesAgrupados[idViaje.toString()] ??= [];  
        viajesAgrupados[idViaje.toString()]!.add(obvin);

        obviaje['vins'].add(viajesAgrupados[idViaje.toString()]);

        viajesAgrupadosfafg[idViaje.toString()] = {'viaje': obviaje};
      }
    }
      
    return viajesAgrupadosfafg.values.toList();
  }
  
  actualizarEstadoViaje(idviaje) async {
    final db = await database;

    return db.update('viaje', {'estadoViaje': 'Completo'}, where: "idviaje = ?", whereArgs: [idviaje]);
  }

  actualizarEstadoViajeSincronizado(idviaje) async {
    final db = await database;

    return db.update('viaje', {'estadoViaje': 'Sincronizado'}, where: "idviaje = ?", whereArgs: [idviaje]);
  }

  Future borrarViaje(idviaje) async {
    final db = await database;

    return db.delete("viaje", where: "idviaje = ?", whereArgs: [idviaje]);
  }

  Future<Viaje> envioViajeCompleto(idviaje) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM viaje WHERE idviaje = $idviaje");

    Viaje viaje = Viaje.fromMap(result[0]);
    List<Vin> vins = [];
    List<Evidencia> firmasf = [];

    vins = await fetchVIN(viaje.idviaje);
    viaje.vines = vins;

    firmasf = await fetchEvideciasViaje(viaje.idviaje);
    viaje.firmas = firmasf;
    
    return viaje;
  }

  Future<List<Vin>> fetchVIN(idviaje) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM vin WHERE idviaje = $idviaje");

    List<Vin> listavines = [];

    for(var i in result) {
      Vin vi = Vin.fromMap(i);

      List<Dano> dano = [];
      dano = await fetchDanos(vi.vin);
      vi.danos = dano;

      listavines.add(vi);
    }

    return listavines;
  }

  Future<List<Dano>> fetchDanos(vin) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM dano WHERE vin = '$vin'");

    List<Dano> listaDanos = [];

    for(var i in result) {
      Dano dano = Dano.fromMap(i);

      List<Evidencia> evidencia = [];
      evidencia = await fetchEvidecias(dano.idd);
      dano.evidencias = evidencia;

      listaDanos.add(dano);
    }

    return listaDanos;
  }

  Future<List<Evidencia>> fetchEvidecias(idd) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM evidencia WHERE iddano = $idd");

    List<Evidencia> evidencia = [];
 
    for(var i in result){
      Evidencia evidencias = Evidencia.fromMap(i);

      evidencia.add(evidencias);
    }

    return evidencia;
  }

  Future<List<Evidencia>> fetchEvideciasViaje(idviaje) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM evidencia WHERE idviaje = $idviaje");

    List<Evidencia> evidencia = [];
 
    for(var i in result){
      Evidencia evidencias = Evidencia.fromMap(i);

      evidencia.add(evidencias);
    }

    return evidencia;
  }

  Future borrarBDViaje() async {
    final db = await database;
    return db.delete('viaje');
  }

  Future borrarBDVINES() async {
    final db = await database;
    return db.delete('vin');
  }

  Future borrarBDDanos() async {
    final db = await database;
    return db.delete('dano');
  }

  Future borrarBDEvidencia() async {
    final db = await database;
    return db.delete('evidencia');
  }


} 