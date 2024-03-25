class LogSistema{
  int? id;
  String? modulo;
  String? tipo;
  String? fechahora;
  String? detalles;

  LogSistema({
    this.id,
    this.modulo,
    this.tipo,
    this.fechahora,
    this.detalles
  });

  // @override
  // String toString() {
  //   return 'LogSistema { modulo: $modulo, tipo: $tipo, fechahora: $fechahora, detalles: $detalles }';
  // }

  factory LogSistema.fromMap(Map<String, dynamic> map) => LogSistema(
    id: map['id'],
    modulo: map['modulo'].toString(),
    tipo: map['tipo'].toString(),
    fechahora: map['fechahora'].toString(),
    detalles: map['detalles'].toString()
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "modulo": modulo,
    "tipo": tipo,
    "fechahora": fechahora,
    "detalles": detalles
  };
}