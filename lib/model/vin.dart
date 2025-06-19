import 'package:tleavin_mobil/model/dano.dart';

class Vin{
  int? idv;
  int? idviaje;
  int? cartaporte;
  String? vin;
  String? distrib_clave;
  String? dest_nombre;
  int? ruta_clave;
  String? ruta_nombre;
  String? origen;
  String? destino;
  String? modelo;
  String? marca;
  String? posicion;
  String? orientacion;
  int? compra;
  String? fecha_carga;
  String? fecha_creacion;
  String? fecha_sync;
  List<Dano>? danos;

  Vin({
    this.idv,
    this.idviaje,
    this.cartaporte,
    this.vin,
    this.distrib_clave,
    this.dest_nombre,
    this.ruta_clave,
    this.ruta_nombre,
    this.origen,
    this.destino,
    this.modelo,
    this.marca,
    this.posicion,
    this.orientacion,
    this.compra,
    this.fecha_carga,
    this.fecha_creacion,
    this.fecha_sync,
    this.danos = const [],
  });

  @override
  String toString() {
    return '{"idv": $idv, "idviaje": $idviaje, "cartaporte": $cartaporte, "vin": "$vin", "distrib_clave": $distrib_clave, "dest_nombre": $dest_nombre, "ruta_clave": $ruta_clave, "ruta_nombre": "$ruta_nombre", "origen": "$origen", "destino": "$destino", "modelo": "$modelo", "marca": "$marca", "posicion": $posicion, "orientacion": "$orientacion", "compra": $compra, "fecha_carga": "$fecha_carga", "fecha_creacion": "$fecha_creacion", "fecha_sync": "$fecha_sync", "danos": $danos}';
  }

  factory Vin.fromMap(Map<String, dynamic> map) => Vin(
    idv: map['idv'],
    idviaje: map['idviaje'],
    cartaporte: map['cartaporte'],
    vin: map['vin'].toString(),
    distrib_clave: map['distrib_clave'].toString(),
    dest_nombre: map['dest_nombre'].toString(),
    ruta_clave: map['ruta_clave'],
    ruta_nombre: map['ruta_nombre'].toString(),
    origen: map['origen'].toString(),
    destino: map['destino'].toString(),
    modelo: map['modelo'].toString(),
    marca: map['marca'].toString(),
    posicion: map['posicion'].toString(),
    orientacion: map['orientacion'].toString(),
    compra: map['compra'],
    fecha_carga: map['fecha_carga'].toString(),
    fecha_creacion: map['fecha_creacion'].toString(),
    fecha_sync: map['fecha_sync'].toString(),
    danos: map['danos']
  );

  Map<String, dynamic> toMap() => {
    "idv": idv,
    "idviaje": idviaje,
    "cartaporte": cartaporte,
    "vin": vin,
    "distrib_clave": distrib_clave,
    "dest_nombre": dest_nombre,
    "ruta_clave": ruta_clave,
    "ruta_nombre": ruta_nombre,
    "origen": origen,
    "destino": destino,
    "modelo": modelo,
    "marca": marca,
    "posicion": posicion,
    "orientacion": orientacion,
    "compra": compra,
    "fecha_carga": fecha_carga,
    "fecha_creacion": fecha_creacion,
    "fecha_sync": fecha_sync
  };

  dynamic operator()  {
    var key;
    switch (key) {
      case 'idv': return idv;
      case 'idviaje': return idviaje;
      case 'cartaporte': return cartaporte;
      case 'vin': return vin;
      case 'distrib_clave': return distrib_clave;
      case 'dest_nombre': return dest_nombre;
      case 'ruta_clave': return ruta_clave;
      case 'ruta_nombre': return ruta_nombre;
      case 'origen': return origen;
      case 'destino': return destino;
      case 'modelo': return modelo;
      case 'marca': return marca;
      case 'posicion': return posicion;
      case 'orientacion': return orientacion;
      case 'compra': return compra;
      case 'fecha_carga': return fecha_carga;
      case 'fecha_creacion': return fecha_creacion;
      case 'fecha_sync': return fecha_sync;
      case 'danos': return danos;
      default: throw ArgumentError('Invalid key: $key');
    }
  }
}