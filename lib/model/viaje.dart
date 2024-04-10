class Viaje{
  int? idviaje;
  String? supervisor;
  int? folio_bitacora;
  int? cartaporte;
  String? bitacora_fecha_carga;
  String? num_eco_unidad;
  String? nombre_operador;
  int? cliente_clave;
  String? cliente_nombre;
  int? ruta_clave;
  String? ruta_nombre;
  String? etiqueta;
  int? status_carga;
  String? notas;
  String? registrada_por;
  String? tipo_viaje;
  int? semana;
  String? fecha_creacion;
  String? fecha_sync;

  Viaje({
    this.idviaje,
    this.supervisor,
    this.folio_bitacora,
    this.cartaporte,
    this.bitacora_fecha_carga,
    this.num_eco_unidad,
    this.nombre_operador,
    this.cliente_clave,
    this.cliente_nombre,
    this.ruta_clave,
    this.ruta_nombre,
    this.etiqueta,
    this.status_carga,
    this.notas,
    this.registrada_por,
    this.tipo_viaje,
    this.semana,
    this.fecha_creacion,
    this.fecha_sync
  });

  @override
  String toString() {
    return 'Viaje { supervisor: $supervisor, folio_bitacora: $folio_bitacora, cartaporte: $cartaporte, bitacora_fecha_carga: $bitacora_fecha_carga, num_eco_unidad: $num_eco_unidad, nombre_operador: $nombre_operador, cliente_nombre: $cliente_nombre, cliente_clave: $cliente_clave, ruta_clave: $ruta_clave, ruta_nombre: $ruta_nombre, etiqueta: $etiqueta, status_carga: $status_carga, notas: $notas, registrada_por: $registrada_por, tipo_viaje: $tipo_viaje, semana: $semana, fecha_creacion: $fecha_creacion, fecha_sync: $fecha_sync, idviaje: $idviaje }';
  }

  factory Viaje.fromMap(Map<String, dynamic> map) => Viaje(
    idviaje: map['idviaje'],
    supervisor: map['supervisor'].toString(),
    folio_bitacora: map['folio_bitacora'],
    cartaporte: map['cartaporte'],
    bitacora_fecha_carga: map['bitacora_fecha_carga'].toString(),
    num_eco_unidad: map['num_eco_unidad'].toString(),
    nombre_operador: map['nombre_operador'].toString(),
    cliente_clave: map['cliente_clave'],
    cliente_nombre: map['cliente_nombre'].toString(),
    ruta_clave: map['ruta_clave'],
    ruta_nombre: map['ruta_nombre'].toString(),
    etiqueta: map['etiqueta'].toString(),
    status_carga: map['status_carga'],
    notas: map['notas'].toString(),
    registrada_por: map['registrada_por'].toString(),
    tipo_viaje: map['tipo_viaje'].toString(),
    semana: map['semana'],
    fecha_creacion: map['fecha_creacion'].toString(),
    fecha_sync: map['fecha_sync'].toString()
  );

  Map<String, dynamic> toMap() => {
    "idviaje": idviaje,
    "supervisor": supervisor,
    "folio_bitacora": folio_bitacora,
    "cartaporte": cartaporte,
    "bitacora_fecha_carga": bitacora_fecha_carga,
    "num_eco_unidad": num_eco_unidad,
    "nombre_operador": nombre_operador,
    "cliente_clave": cliente_clave,
    "cliente_nombre": cliente_nombre,
    "ruta_clave": ruta_clave,
    "ruta_nombre": ruta_nombre,
    "etiqueta": etiqueta,
    "status_carga": status_carga,
    "notas": notas,
    "registrada_por": registrada_por,
    "tipo_viaje": tipo_viaje,
    "semana": semana,
    "fecha_creacion": fecha_creacion,
    "fecha_sync": fecha_sync
  };
}